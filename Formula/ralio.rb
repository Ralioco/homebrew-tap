# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.11"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.11/ralio-macos-arm64.tar.gz"
    sha256 "c99e3e8e930108e1e9aa61a114416bb64d37c73c05c3efb339ba5065b3836a43"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.11/ralio-linux-x64.tar.gz"
    sha256 "23a1abb7a8e4e7719ce6b56a7d08b3c78c72be55d5ab936cdf583ae3a7e4baa8"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.11/ralio-linux-arm64.tar.gz"
    sha256 "6ac4a7a764db6e2870bf485b6aa6cca79166bb209c8db9e7ae46b1638001ee55"
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
