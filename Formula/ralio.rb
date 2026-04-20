# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.2.7"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.2.7/ralio-macos-arm64.tar.gz"
    sha256 "b2a19d98d1f1a3c96a7ee5bf2e5f3acf320cce87b986f6cc0d4e5f4c70418400"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.2.7/ralio-linux-x64.tar.gz"
    sha256 "1b8b0c7484ee3c85362d71014ec17baa53c935b2b38f69e516effb253a810abe"
  else
    odie "Ralio is only available for macOS (Apple Silicon) and Linux (x86_64)."
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
