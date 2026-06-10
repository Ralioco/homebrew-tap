# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.9/ralio-macos-arm64.tar.gz"
    sha256 "3bc8da4fc78771c1e989c019d5cbb2c18e1a3fd49cca547fe9d594136e86cc0e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.9/ralio-linux-x64.tar.gz"
    sha256 "35065a4329fe3d2a64cd2c4b6fc380cb2dfa0d74876921c2ca7a0178abf665d2"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.9/ralio-linux-arm64.tar.gz"
    sha256 "825dfc6d517abf9a4ea050a6e34079b479d17d183a8b6c91bee1cf6ae5a47591"
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
