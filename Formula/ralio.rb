# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.25"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.25/ralio-macos-arm64.tar.gz"
    sha256 "058beadd525cf2e11b9e7e0fe2ac7a423b509c866a4724f66411f412c392fb63"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.25/ralio-linux-x64.tar.gz"
    sha256 "93f6883238fc50c8128569ae9a746bcdc0e57d3148eb52a05139e4f84c39b4a2"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.25/ralio-linux-arm64.tar.gz"
    sha256 "98f3733a965e4e78d7d0a9bd7008339250729c2a484ee4f9e3567fad70819c9d"
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
