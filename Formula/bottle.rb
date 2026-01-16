class Bottle < Formula
  desc "Curated snapshot manager for the Open Horizon Labs tool stack"
  homepage "https://github.com/open-horizon-labs/bottle"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.1.9/bottle-aarch64-apple-darwin.tar.xz"
      sha256 "70ea68c7cbe44b3e8361bf34dab5a912fb4b15c15d2dd3dc376d8117c9218ba1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/open-horizon-labs/bottle/releases/download/v0.1.9/bottle-x86_64-apple-darwin.tar.xz"
      sha256 "73fa6601c7fc5253beef9b19c759786f4e825c87e3ed9fdddf1d798caaafeb6b"
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
