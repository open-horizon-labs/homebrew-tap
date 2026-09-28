class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.7.2/swamp-0.7.2-aarch64-apple-darwin.tar.gz"
  version "0.7.2"
  sha256 "4dad1510cfe4e6da264dc4cef0e1ee667c419c8ffbe7848a443fb1961ce84679"
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
