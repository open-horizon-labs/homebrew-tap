class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.6.2/swamp-0.6.2-aarch64-apple-darwin.tar.gz"
  version "0.6.2"
  sha256 "39f20f211d3e3ebd521f5738a72c427b069ddd043997734305f18a128f643dae"
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
