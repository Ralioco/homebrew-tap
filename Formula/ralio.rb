# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.2/ralio-macos-arm64"
    sha256 "4121b7b607f4cf911cb0b07890756abe22953669bc5c4e64361a0d22c700091b"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.2/ralio-linux-x64"
    sha256 "5bebdf44b15f7dc15c2f36b5927e1124c16a1ee64aa684d014bc8950a8ec8330"
  else
    odie "Ralio is only available for macOS (Apple Silicon) and Linux (x86_64)."
  end

  def install
    binary = stable.url.split("/").last
    bin.install binary => "ralio"
  end

  test do
    assert_match "ralio", shell_output("#{bin}/ralio --help", 0)
  end
end
