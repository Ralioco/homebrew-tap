# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.22"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.22/ralio-macos-arm64.tar.gz"
    sha256 "0e647a288e5f0a27363654c0d0bfa25036169f4e5dfe22156f92bee33f5f5246"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.22/ralio-linux-x64.tar.gz"
    sha256 "f2c4fb47097e35c13a519cb98d7bc9505d42a06a28f0c23793f69bc005d262b0"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.22/ralio-linux-arm64.tar.gz"
    sha256 "c5b8e51d9e54a9b6e110cb68338aa0246e168b1f3e220b2cf38aafcd2714103a"
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
