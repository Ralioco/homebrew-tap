# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.0/ralio-macos-arm64.tar.gz"
    sha256 "570a668d246e1f19e3661993ff9c19be6d7e54209ae62aac8a800e67d892f6f3"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.0/ralio-linux-x64.tar.gz"
    sha256 "988f67751534b37bfed70a707f209241bc138859db2fa22a30c48efc5563aa85"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.0/ralio-linux-arm64.tar.gz"
    sha256 "1ac386012a5d4c06caf770ab28ca245e33d7f388e97ed1e69ee48de1db8e2628"
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
