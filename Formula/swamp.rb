class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.8.2/swamp-0.8.2-aarch64-apple-darwin.tar.gz"
  version "0.8.2"
  sha256 "09494c4c62f1226de20069ed0377c0652153f94ba22efdcb73120c666324c3cf"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "swamp"
    (pkgshare/"skills").install "skills/swamp" if File.directory?("skills/swamp")
  end

  test do
    assert_match "swamp #{version}", shell_output("#{bin}/swamp --version")
    assert_match "report", shell_output("#{bin}/swamp --help")
  end
end
