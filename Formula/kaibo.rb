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
  version "0.2.0-rc.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "08d0abadb08872157873d7e4fa2d178e618735287d2c8d6b5b741918a614764c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "6e2e37f19d4467ffef720785d10a1595fef3d3aad5d5d11e8269fd35bf4a9796"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "20c72739dcc88664e1bc45abd04c011d286821d1410f8d56d2e994efdaf28127"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "164f5a941e8e3f139ad4caa1f41eba125c74046f24b557e544063dc647630f7e"
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
