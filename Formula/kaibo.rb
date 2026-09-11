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
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "7f54855d7336e70a9b261fd4bb7b9b72819cd4f0ad4519ab94882465ab0b7dd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7b97fec32879fb24bf5a636afc493a107483a28b5dddab93fb20f468e674c973"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "24c164a96808097d1a534f8706e386d58c343cc3bb397610d6d8b6ebab6c5404"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b5d2eeca5ed3839231bbd59244e92897a62597f0385814fce9c9e1a01d3402d1"
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
