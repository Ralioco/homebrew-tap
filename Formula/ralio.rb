# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.14"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.14/ralio-macos-arm64.tar.gz"
    sha256 "19cc58b8ed8809b279cfd061b5a58d75ac73ced527c3121af79fed3ac16eb8a7"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.14/ralio-linux-x64.tar.gz"
    sha256 "08d31b8099e2b4795f62ce9b651d4a9dda985f7a7fadf29f51f486606191bb46"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.14/ralio-linux-arm64.tar.gz"
    sha256 "3adcde66bec6de94e2d2f3ed1e643d1ae9b4afef1fb5798dd6f5cb306307eaed"
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
