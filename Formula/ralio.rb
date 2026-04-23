# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.9/ralio-macos-arm64.tar.gz"
    sha256 "1007791eae705678a2ecb812b076ceb6817b20955d05fc689d87fa73c4adfd14"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.9/ralio-linux-x64.tar.gz"
    sha256 "103b43716a53d49c34ff598822adc3b032080b5d4eae68a398a963a559c50d54"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.9/ralio-linux-arm64.tar.gz"
    sha256 "a1212940f7846182dc6c4abfba0df83903afe34dd55ef6ee28f246d6e284fda4"
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
