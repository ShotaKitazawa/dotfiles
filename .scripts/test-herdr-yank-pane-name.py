import contextlib
import io
import json
from pathlib import Path
import runpy
import subprocess
import unittest
from unittest.mock import patch


SCRIPT = Path(__file__).resolve().parents[1] / "bin/executable_herdr-yank-pane-name"
HELPER = runpy.run_path(str(SCRIPT))


class YankPaneNameTest(unittest.TestCase):
    def invoke(self, name, fail=None, response=None, env=None):
        def run(argv, **kwargs):
            if argv[0] == fail:
                raise subprocess.CalledProcessError(1, argv)
            data = response if response is not None else {"result": {"pane": {"label": name}}}
            return subprocess.CompletedProcess(argv, 0, stdout=json.dumps(data))

        environment = {"HERDR_ACTIVE_PANE_ID": "w0:pB", "HERDR_BIN_PATH": "/test/herdr"}
        with (
            patch.dict("os.environ", environment if env is None else env, clear=True),
            patch("subprocess.run", side_effect=run) as mocked,
            contextlib.redirect_stderr(io.StringIO()),
        ):
            status = HELPER["main"]()
        return status, mocked

    def test_copies_full_unicode_name_without_newline_or_shell_evaluation(self):
        name = "作業名 'quoted' $(touch /tmp/not-run); %s\n" + "長" * 200
        status, run = self.invoke(name)
        self.assertEqual(status, 0)
        self.assertEqual(run.call_count, 2)
        self.assertEqual(run.call_args_list[0].args[0], ["/test/herdr", "pane", "get", "w0:pB"])
        self.assertEqual(run.call_args_list[1].args[0], ["/usr/bin/pbcopy"])
        self.assertEqual(run.call_args_list[1].kwargs["input"], name.encode("utf-8"))
        self.assertTrue(all("shell" not in call.kwargs for call in run.call_args_list))

    def test_copies_before_opening_whole_http_urls(self):
        for url in (
            "https://example.com/" + "long/" * 100,
            "http://localhost:8080/path?a=1&b=2#anchor",
            "https://example.com/日本語",
            "HTTPS://example.com/",
            "https://[::1]:8080/",
        ):
            with self.subTest(url=url):
                status, run = self.invoke(url)
                self.assertEqual(status, 0)
                self.assertEqual(run.call_args_list[1].kwargs["input"], url.encode("utf-8"))
                self.assertEqual(run.call_args_list[2].args[0], ["/usr/bin/open", url])

    def test_only_copies_non_urls_and_malformed_urls(self):
        for name in (
            "normal pane", "see https://example.com", "https://example.com notes",
            " https://example.com", "https://example.com\n", "https://example.com\x00",
            "https://", "https:///path", "https://[bad", "https://example.com:bad",
            "https://example.com:99999", "file:///tmp/test", "javascript:alert(1)",
            "slack://channel", "example.com",
        ):
            with self.subTest(name=name):
                status, run = self.invoke(name)
                self.assertEqual(status, 0)
                self.assertEqual(run.call_count, 2)

    def test_does_not_touch_clipboard_without_an_active_pane(self):
        status, run = self.invoke("name", env={})
        self.assertEqual(status, 1)
        run.assert_not_called()

    def test_does_not_clear_clipboard_for_unnamed_panes_or_invalid_responses(self):
        for response in ({"result": {"pane": {}}}, {"error": "not found"}):
            status, run = self.invoke(None, response=response)
            self.assertEqual(status, 1)
            self.assertEqual(run.call_count, 1)
        for name in (None, "", 123):
            status, run = self.invoke(name)
            self.assertEqual(status, 1)
            self.assertEqual(run.call_count, 1)

    def test_does_not_open_url_when_copy_fails(self):
        status, run = self.invoke("https://example.com", fail="/usr/bin/pbcopy")
        self.assertEqual(status, 1)
        self.assertEqual(run.call_count, 2)

    def test_open_failure_leaves_copy_intact(self):
        status, run = self.invoke("https://example.com", fail="/usr/bin/open")
        self.assertEqual(status, 1)
        self.assertEqual(run.call_args_list[1].kwargs["input"], b"https://example.com")
        self.assertEqual(run.call_count, 3)


if __name__ == "__main__":
    unittest.main()
