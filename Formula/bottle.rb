class Bottle < Formula
  desc "Curated snapshot manager for the Cloud Atlas AI tool stack"
  homepage "https://github.com/cloud-atlas-ai/bottle"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cloud-atlas-ai/bottle/releases/download/v0.1.2/bottle-aarch64-apple-darwin.tar.xz"
      sha256 "b59dc21dd2ee9b09de9dff223699882ca2857928908ef0e516eec3f84d572c92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cloud-atlas-ai/bottle/releases/download/v0.1.2/bottle-x86_64-apple-darwin.tar.xz"
      sha256 "fc64a463139a45aea4d2ae5ddc635af751476256758f8c253a647fd600019d72"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "bottle" if OS.mac? && Hardware::CPU.arm?
    bin.install "bottle" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
