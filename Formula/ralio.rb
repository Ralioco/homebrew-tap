# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.12"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.12/ralio-macos-arm64.tar.gz"
    sha256 "42394272319fef8e770f4c8270de145496f4e1f4c055d7644bd86f016b3eee58"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.12/ralio-linux-x64.tar.gz"
    sha256 "20f226febfdc5f1f2e3c515be3d1d88203b3414bb14b94b0a98edc200386cf46"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.12/ralio-linux-arm64.tar.gz"
    sha256 "f0b2a2c52701a186497682923b48f6bb307a8ccd1b0ed3fca6744e94ec1531d2"
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
