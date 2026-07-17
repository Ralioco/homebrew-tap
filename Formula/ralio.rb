# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.15"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.15/ralio-macos-arm64.tar.gz"
    sha256 "8121c81cc8debfd03a1ce1fb859d853ee42827984a19db9a404ea923ff5dadf6"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.15/ralio-linux-x64.tar.gz"
    sha256 "aaba5a7edae2656825416175de48d8a14be8bc7360c03e4bd110369f540f82f6"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.15/ralio-linux-arm64.tar.gz"
    sha256 "518ab6b2b69cb798a35a6c79c486fbc2230ca560fb0d41f42f0b514676e20871"
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
