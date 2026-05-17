# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.4"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.4/ralio-macos-arm64.tar.gz"
    sha256 "c77c9a2eac5bb7188661223eb536e2d756216612880df28403add18ab49fc089"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.4/ralio-linux-x64.tar.gz"
    sha256 "76d4ed5014ac2b09c8e5a1d8824d69a9df39285563e19a78c2424dd0373e8884"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.4/ralio-linux-arm64.tar.gz"
    sha256 "1dd2c17798d9213eb21567fd66302d76ddc62060927faacedc149e9c0cdfb310"
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
