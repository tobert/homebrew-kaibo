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
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "63f27216cbff1413afaaedc007b12dbb3347341257fb9d6e2045a5d746142cb3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8736b487cc3827134a32074bafa693dd662370d3b9d38b94042ffc1efb803488"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8ea7bbb60c1832243859d067801061a154ded361321ec12c708ea99b994f9f90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tobert/kaibo/releases/download/v#{version}/kaibo-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7b02a8d81c7bd33e155a2ebee1f13e81bda90c8f9a04eb832cbb1cd4eed3a097"
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
