# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.14"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.14/ralio-macos-arm64.tar.gz"
    sha256 "a78f27c3688d6b261aa3a1070f89daf6e3c624b4e59a1184ced686403b62f964"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.14/ralio-linux-x64.tar.gz"
    sha256 "4d6d96b0a87fbf73e66c275a0aee92ca4fc4a31afdf02fe0a04bb2aa5c696406"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.14/ralio-linux-arm64.tar.gz"
    sha256 "49079c5c9b688294810d5fb2891a5f035a4448f6befebc5dfe37fef5a2d00305"
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
