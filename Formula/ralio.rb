# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.5"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.5/ralio-macos-arm64"
    sha256 "192b2f2ce635f6e724f1bcbc3e98d344219c4dc0193e697463fb1cdbe990d56c"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.5/ralio-linux-x64"
    sha256 "dd808b6908124685cadda67e253b6a8af851e60a1b1931b4e51aa2eeaeb4b914"
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
