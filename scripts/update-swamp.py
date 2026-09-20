#!/usr/bin/env python3
"""Update only Swamp's release coordinates after verifying published bytes."""
import hashlib
import json
from pathlib import Path
import re
import urllib.request


def download(url):
    request = urllib.request.Request(url, headers={"User-Agent": "swamp-homebrew-updater"})
    return urllib.request.urlopen(request, timeout=60)


def main():
    with download("https://api.github.com/repos/open-horizon-labs/swamp/releases/latest") as response:
        release = json.load(response)
    tag = release["tag_name"]
    if release["draft"] or release["prerelease"] or not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError("Expected a stable semantic-version release")
    version = tag[1:]
    path = Path(__file__).resolve().parents[1] / "Formula/swamp.rb"
    original = path.read_text()
    current = re.search(r'^  version "([0-9.]+)"$', original, re.M).group(1)
    if tuple(map(int, version.split("."))) < tuple(map(int, current.split("."))):
        raise ValueError("Refusing to downgrade Swamp")
    archive = f"swamp-{version}-aarch64-apple-darwin.tar.gz"
    assets = {asset["name"] for asset in release["assets"]}
    if not {archive, archive + ".sha256"} <= assets:
        raise ValueError("Release assets are incomplete; retry after publication finishes")
    base = f"https://github.com/open-horizon-labs/swamp/releases/download/{tag}"
    with download(f"{base}/{archive}.sha256") as response:
        checksum = response.read().decode().strip().split()
    if len(checksum) != 2 or checksum[1] != archive or not re.fullmatch(r"[0-9a-f]{64}", checksum[0]):
        raise ValueError("Invalid checksum manifest")
    digest = hashlib.sha256()
    with download(f"{base}/{archive}") as response:
        while chunk := response.read(1024 * 1024):
            digest.update(chunk)
    if digest.hexdigest() != checksum[0]:
        raise ValueError("Archive checksum mismatch")
    updated = original
    for field, value in (("url", f"{base}/{archive}"), ("version", version), ("sha256", checksum[0])):
        updated, count = re.subn(rf'^  {field} "[^"]+"$', f'  {field} "{value}"', updated, flags=re.M)
        if count != 1:
            raise ValueError(f"Expected one {field} field")
    if updated != original:
        path.write_text(updated)
    print(f"Verified Swamp {version}: {checksum[0]}")


if __name__ == "__main__":
    main()
