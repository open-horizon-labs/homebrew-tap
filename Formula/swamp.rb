class Swamp < Formula
  desc "Project-oriented disk usage, history, and reviewed developer cleanup"
  homepage "https://github.com/open-horizon-labs/swamp"
  url "https://github.com/open-horizon-labs/swamp/releases/download/v0.8.6/swamp-0.8.6-aarch64-apple-darwin.tar.gz"
  version "0.8.6"
  sha256 "e02d21769f0c34d46943c3eff0ccf11a8c7cea506bb09721ba17df28ee7eaf7c"
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
