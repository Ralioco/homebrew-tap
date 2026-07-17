# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.16"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.16/ralio-macos-arm64.tar.gz"
    sha256 "9cd327502a29b5df77bde62fbc1547d59a5fd9eaeb0f06811194b815dd0540c0"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.16/ralio-linux-x64.tar.gz"
    sha256 "99142befac119e0f43badb79d10e4f5ab124aae31466384094c7bb1e4839e9c7"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.16/ralio-linux-arm64.tar.gz"
    sha256 "0dc0104aea793e65d7f82186891977ba2b5cc2bf03e73d1f52ebbc2777da0fee"
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
