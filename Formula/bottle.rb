class Bottle < Formula
  desc "Curated snapshot manager for the Open Horizon Labs tool stack"
  homepage "https://github.com/open-horizon-labs/bottle"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.1/bottle-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "71daea18a7e52c4b9cf30858aca3576706d2949e81915033cf7c9893ea447921"
    else
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.1/bottle-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "792f9d5e9010731b1e811ba76e26e33b1d8a23ae91b0391041e2c226e83f7ae5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.1/bottle-0.3.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a306853443634e5939b3c4dd5e5dc85d5ea40b1f12cd8d7389264ddb274cc3da"
    else
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.1/bottle-0.3.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c1eafb1600d1f9ba3a4464eb99a9ff215dd6d25c92a129ee56ab81d171f1aad7"
    end
  end

  def install
    bin.install "bottle"
  end

  test do
    system "#{bin}/bottle", "--version"
  end
end
