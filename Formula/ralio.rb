# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.7"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.7/ralio-macos-arm64.tar.gz"
    sha256 "e5b7ebc7a008afd24fd035d003e6cd18cb7d8388ee87f8c86d253dec16a750b7"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.7/ralio-linux-x64.tar.gz"
    sha256 "f83afadfc5fa331484cffaff7ff70008fe7de61d5167d4b9f31bdd5dc1c030ce"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.7/ralio-linux-arm64.tar.gz"
    sha256 "59c6c9a6a2fa4f5791a2d3f2fdbedce7e751de7307034531316c15f8c21f9bc8"
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
