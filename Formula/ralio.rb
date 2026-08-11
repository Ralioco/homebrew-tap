# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.19"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.19/ralio-macos-arm64.tar.gz"
    sha256 "aeb3840e07bc2cf01bbc3d85f23fa625496fb3846878711395a6c8d3415e343b"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.19/ralio-linux-x64.tar.gz"
    sha256 "e60bede3eb7b55c277c343555b3070a3f2b839025430e6fcee165bcece45370e"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.19/ralio-linux-arm64.tar.gz"
    sha256 "db0832f2b1e57b2dc634f3d196fa274cf8edcd1f9abe7c6f7fe613bdb670729f"
  else
    odie "Ralio is only available for macOS (Apple Silicon) and Linux (x86_64, arm64)."
  end

  def install
    # Tarball contains a `ralio/` directory with the launcher binary and an
    # `_internal/` folder holding the bundled Python runtime.  Brew cd's into
    # that single top-level directory before running `install`.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ralio"
  end

  test do
    assert_match "ralio", shell_output("#{bin}/ralio --help", 0)
  end
end
