# homebrew-kaibo

A [Homebrew](https://brew.sh) tap for **[kaibo](https://github.com/tobert/kaibo)** (解剖) — a
read-only MCP consult agent that gives your coding agent grounded, cited answers about a
codebase from a model *outside your own family*.

## Install

```sh
brew install tobert/kaibo/kaibo
```

That one command taps this repo and installs kaibo. Equivalently:

```sh
brew tap tobert/kaibo
brew install kaibo
```

Upgrade later with `brew upgrade kaibo`.

## What you get

A prebuilt, self-contained `kaibo` binary for macOS (Apple Silicon + Intel) and Linux
(arm64 + x86_64), pulled from [kaibo's signed GitHub Releases](https://github.com/tobert/kaibo/releases).

Installing through Homebrew also sidesteps the macOS Gatekeeper quarantine prompt you'd
see downloading the tarball from a browser — `brew` doesn't attach `com.apple.quarantine`,
so the binary runs without the "cannot verify the developer" dialog.

## Verifying the download

kaibo's releases are cosign-signed with SLSA build provenance. To verify the underlying
release assets independently, see the **Verify a download** section of the
[main README](https://github.com/tobert/kaibo#readme).

## Reporting issues

kaibo bugs and feature requests go to the [main repo](https://github.com/tobert/kaibo/issues).
Open issues *here* only for the formula/tap itself (wrong sha, install failure, etc.).
