# typed: false
# frozen_string_literal: true

# Formula auto-updated by CI on each cli-v* tag.
# Template: cli/homebrew/ralio.rb.template
class Ralio < Formula
  desc "CLI for the Ralio payment platform"
  homepage "https://ralio.co"
  version "0.3.26"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.26/ralio-macos-arm64.tar.gz"
    sha256 "b6ade00b3c789318278c7f8fceb26a90cb15608d3842c14a2f296e8666062848"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://releases.ralio.co/cli/cli-v0.3.26/ralio-linux-x64.tar.gz"
    sha256 "043722a47ec7b93f4f00977c5a0a3458f7aadbe4597b4d6923f761687b662637"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://releases.ralio.co/cli/cli-v0.3.26/ralio-linux-arm64.tar.gz"
    sha256 "f878c85b4cbaabbabf6e365a2ee00bf7dfee5d0f1a4e92b81d70fa2ce09ddbdf"
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
