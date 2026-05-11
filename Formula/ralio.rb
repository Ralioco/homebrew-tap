# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.15"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.15/ralio-macos-arm64.tar.gz"
    sha256 "3f8abfee7097a130ec2a23cc6cadffd72ca391218e6d3819c4bc09c1b7da3010"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.15/ralio-linux-x64.tar.gz"
    sha256 "3a7a63730fdde21cd25881d2caccb2b0929fd62e34ec50332ee82773c57c0c23"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.15/ralio-linux-arm64.tar.gz"
    sha256 "74eac799504d6d45b7ca46b7283f7a9c02f5c353af60d5695d8006ca97d9812c"
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
