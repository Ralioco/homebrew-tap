# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.8"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.8/ralio-macos-arm64.tar.gz"
    sha256 "c9de1a5f8f18cd8f522234b3f6a80f409c1b8fb4f213a5b85a8bddd8bc867830"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.8/ralio-linux-x64.tar.gz"
    sha256 "3a1e2d155f6aea65d644ab67c54dc5abecc67f51bb7def34b1a51817597f0ec3"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.8/ralio-linux-arm64.tar.gz"
    sha256 "884fb883afb47d1f907b6d1b4654e353a4df97122b0b97d63471b9ee424cd4b8"
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
