class Bottle < Formula
  desc "Curated snapshot manager for the Open Horizon Labs tool stack"
  homepage "https://github.com/open-horizon-labs/bottle"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.0/bottle-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "4c453d01fce8d988dbe4f8f99a2f154535a6c3067c6f65b4fd784209518083cf"
    else
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.0/bottle-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "29f1af4179d432b3691be719a387a062dff0a3730b239d6c9cdfc516af6f93d7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.0/bottle-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0c0594c627c9be71fc50bbc7b46ba3bd12539b1cbec9537f84821b723353d6b1"
    else
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.3.0/bottle-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d46a24ff065c1dea53dcf4d34c8030349f9abcc2ca76274a5754805b5ba9a53"
    end
  end

  def install
    bin.install "bottle"
  end

  test do
    system "#{bin}/bottle", "--version"
  end
end
