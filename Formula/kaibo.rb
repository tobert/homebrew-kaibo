# Homebrew formula for kaibo (解剖) — installs the prebuilt, signed release
# binaries from GitHub Releases rather than building from source (kaibo already
# ships fully self-contained macOS/Linux binaries per the release workflow).
#
# Installing via `brew` avoids the macOS Gatekeeper quarantine prompt: Homebrew's
# downloader does not set com.apple.quarantine, so the binary runs without the
# "cannot verify the developer" dialog a browser download would trigger. (The
# binary is not yet Developer-ID signed/notarized — that is a separate effort.)
#
# Update on each release: bump `version`, then refresh the four sha256s from each
# target's `.sha256` asset. The release workflow can do this automatically; the
# manual path is, e.g.:
#   gh release download vX.Y.Z --repo tobert/kaibo -p '*-apple-darwin.tar.gz.sha256' -O -
class Kaibo < Formula
  desc "Read-only MCP consult agent: grounded, cited answers about a codebase from a model outside your own family"
  homepage "https://github.com/tobert/kaibo"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "dbbef1e9dbf3e25bc72c810837141fc7ecaf007502b8efa5e04dbdf4bf99bee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "a05cb6aa6afaea56d780abd8750f74d5eb85e646a9773e58808174e30509387c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "26b82260ac8b14b0b4ff1a1440e751bf825a0a9e45a10b0ca7ca04cd9bfc61eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "36cb0381d2da333ce02aa7d754d62eddc3742d1aa8b7335c3449714732077356"
    end
  end

  def install
    # The archive's single top-level dir (kaibo-v<version>-<target>/, holding
    # kaibo + README.md + LICENSE) is auto-descended by Homebrew staging, so the
    # binary is right here in the cwd.
    bin.install "kaibo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kaibo --version")
  end
end
