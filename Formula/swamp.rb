class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.8.4/swamp-0.8.4-aarch64-apple-darwin.tar.gz"
  version "0.8.4"
  sha256 "d89b47b87a1573ec8c2850e937bb6c0549ac931e2fd90c1e8539dfe4c595ee6c"
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
