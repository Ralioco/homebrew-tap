# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.20"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.20/ralio-macos-arm64.tar.gz"
    sha256 "4c2ffcaef48554a37dae68daa947a0ec737a9d5258d16fd5aa5f3d607bc19a9c"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.20/ralio-linux-x64.tar.gz"
    sha256 "839375f82dee45070a7788c39e15fe091d56f8c5f4d0932fa15ba0bf64ba2454"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.20/ralio-linux-arm64.tar.gz"
    sha256 "d2538186fef671b2db3944697c586fe73a2f4fd5e6d48aa6425c34765ceda204"
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
