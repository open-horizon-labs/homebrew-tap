class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.6.3/swamp-0.6.3-aarch64-apple-darwin.tar.gz"
  version "0.6.3"
  sha256 "8f167884ca10aa82fc3fdfa41ae2c6a37f8e2a1366065060699d0c3e648106ed"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "swamp", "swamp-mcp"
  end

  test do
    assert_match "swamp #{version}", shell_output("#{bin}/swamp --version")
    assert_match "cleanup-check", shell_output("#{bin}/swamp --help")
  end
end
