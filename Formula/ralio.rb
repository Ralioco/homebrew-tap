# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.6"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.6/ralio-macos-arm64"
    sha256 "3d05233aaf8e9be7c1e113999cb4a482622115e7c77faf7d88edcc207b344992"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.6/ralio-linux-x64"
    sha256 "afb04618ea00b50c8d744710187f028f0b95c8a17f21da2c6ec1acc41472b1cc"
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
