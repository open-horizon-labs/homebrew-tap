class Bottle < Formula
  desc "Curated snapshot manager for the Open Horizon Labs tool stack"
  homepage "https://github.com/open-horizon-labs/bottle"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.2/bottle-0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "6a5b2c8049c44c5c2e00cb32cab69eef41a7658f3963f836b754b34f858d9a9e"
    else
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.2/bottle-0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "1b831707dcc54db7cc10118a0addb2dbe96fd2bde0fc32b75b68b7ca06147080"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.2/bottle-0.3.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "59e29e7c914a17a82000ab22cc3c414342eec709ecc2fcf96f9214511605a5ae"
    else
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.2/bottle-0.3.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "839f5af3220e1323dcbe5894d134e8d600f742415a5909f5f178017dcb22661b"
    end
  end

  def install
    bin.install "bottle"
  end

  test do
    system "#{bin}/bottle", "--version"
  end
end
