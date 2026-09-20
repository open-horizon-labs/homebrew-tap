import hashlib
import importlib.util
import io
import json
from pathlib import Path
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location("updater", Path(__file__).with_name("update-swamp.py"))
updater = importlib.util.module_from_spec(spec)
spec.loader.exec_module(updater)


class UpdateTests(unittest.TestCase):
    def run_update(self, version="0.6.3", mismatch=False, missing=False):
        archive = f"swamp-{version}-aarch64-apple-darwin.tar.gz"
        payload = b"fixture release bytes"
        digest = hashlib.sha256(payload).hexdigest()
        release = {"tag_name": f"v{version}", "draft": False, "prerelease": False,
                   "assets": [] if missing else [{"name": archive}, {"name": archive + ".sha256"}]}
        responses = [io.BytesIO(json.dumps(release).encode()),
                     io.BytesIO(f"{digest}  {archive}\n".encode()),
                     io.BytesIO(b"corrupt" if mismatch else payload)]
        original = '  url "old"\n  version "0.6.2"\n  sha256 "old"\n'
        with patch.object(updater, "download", side_effect=responses), \
             patch.object(Path, "read_text", return_value=original), \
             patch.object(Path, "write_text") as write:
            if mismatch or missing or version == "0.6.1":
                with self.assertRaises(ValueError):
                    updater.main()
                write.assert_not_called()
            else:
                updater.main()
                written = write.call_args.args[0]
                self.assertIn(f'version "{version}"', written)
                self.assertIn(digest, written)
                self.assertIn(archive, written)

    def test_new_release(self):
        self.run_update()

    def test_corrupt_archive_does_not_write(self):
        self.run_update(mismatch=True)

    def test_incomplete_release_does_not_write(self):
        self.run_update(missing=True)

    def test_downgrade_does_not_write(self):
        self.run_update(version="0.6.1")


if __name__ == "__main__":
    unittest.main()
