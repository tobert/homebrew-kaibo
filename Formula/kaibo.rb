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
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "ecb9a97f1de1557bb13642c4e7e6c52977ae45d62423b2cafdccf5adb6a1bba6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "adbac232039243b9233a24a6a3683872252bc1234f4b779a7df960ca79f80ede"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "713f835a8940e4bb936530f6b867e013ec7dcbedf67f58027873c8b9b988c6ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7357559392a236588b54e42e37c14e8a66b3e44074a2955389ec4ead67f1bf53"
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
