class Bottle < Formula
  desc "Curated snapshot manager for the Cloud Atlas AI tool stack"
  homepage "https://github.com/cloud-atlas-ai/bottle"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cloud-atlas-ai/bottle/releases/download/v0.1.0/bottle-aarch64-apple-darwin.tar.xz"
      sha256 "f7fdb56cdac2a1231307375c3347af6f83f6df4530cc5d4573ddc5abfee2b4a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cloud-atlas-ai/bottle/releases/download/v0.1.0/bottle-x86_64-apple-darwin.tar.xz"
      sha256 "ce994ec159c79645ad90038f93ba9af00a43bf3085fb783db4f1bb672d071ebe"
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
