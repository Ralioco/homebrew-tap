# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.16"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.16/ralio-macos-arm64.tar.gz"
    sha256 "dd06ca2f4381dd2e624ca970b2f01abb553207da9e7968569c521e8136d1e60f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.16/ralio-linux-x64.tar.gz"
    sha256 "33ac4ce633d071b34a577a911fbaa0c88f1e61e0fc00783585eea4c2ee8aa076"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.16/ralio-linux-arm64.tar.gz"
    sha256 "d86553c701c45af674e0b6b01024b15ceb564a6daa796e8614c51daca96a40e9"
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
