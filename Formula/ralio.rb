# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.4"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.4/ralio-macos-arm64"
    sha256 "ba0c68bbcdea93f032a4a7dd2047f8703459b93c08a7713a58ad5e6f2dc675a7"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.4/ralio-linux-x64"
    sha256 "864b1937f2bdd7151458babef7d78f86f58ec3060e3c40ec7f72c0d355db4450"
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
