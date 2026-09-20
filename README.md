# Open Horizon Labs Homebrew Tap

```bash
brew tap open-horizon-labs/tap
brew install bottle
```

## Swamp

```bash
brew install open-horizon-labs/tap/swamp
brew upgrade swamp
```

Swamp currently supports Apple silicon macOS. The formula installs the published
`swamp` and `swamp-mcp` binaries with SHA-256 verification.

The Update Swamp workflow checks for stable releases every 15 minutes and can
also be run manually. GitHub may delay scheduled runs. It verifies the published
archive against its checksum before updating the formula; missing assets or a
checksum mismatch leave the existing formula unchanged. No cross-repository
publishing token is required.
