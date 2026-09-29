class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.7.4/swamp-0.7.4-aarch64-apple-darwin.tar.gz"
  version "0.7.4"
  sha256 "63a69a2a5b535ac1d4b8e6a30b56fecee68de3d3651ecd980f2ddfe633c18cd7"
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
