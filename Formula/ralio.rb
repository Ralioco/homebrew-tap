# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.3/ralio-macos-arm64.tar.gz"
    sha256 "93ab4d7aeae7d4b5967d6f9cee3c6b290284787b0af313b39ca8ef6c73462683"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.3/ralio-linux-x64.tar.gz"
    sha256 "b4f48728902d53637be98237a7b686fabc4a03a280ecbb5088409882f7aaf47f"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.3/ralio-linux-arm64.tar.gz"
    sha256 "39272a6fa0b04d903040510153dd60760eb55068f816b647e5ac2856bf818a6f"
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
