# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.21"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.21/ralio-macos-arm64.tar.gz"
    sha256 "9b23ee8e79d64d05e22f3ebecb484e3c17757b067d4aa62ff1d9c827ad1d493e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.21/ralio-linux-x64.tar.gz"
    sha256 "246b79ddb535855e6adef094af46aadd143b677f2619bd9459ca424f1e6eec50"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.21/ralio-linux-arm64.tar.gz"
    sha256 "d19d77cfef61453b0707ba0066a924b6823b6edf890df71c0dd5c7afcd55cf6c"
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
