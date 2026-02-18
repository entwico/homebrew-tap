# Homebrew Tap

Custom [Homebrew](https://brew.sh) tap.

## Usage

### Add the tap

```bash
brew tap entwico/tap
```

### Install podproxy

**Stable** (latest tagged release):

```bash
brew install entwico/tap/podproxy
```

**Latest** (bleeding-edge, built from main):

```bash
brew install entwico/tap/podproxy-latest
```

### Update

```bash
brew update
brew upgrade podproxy
```

### Configuration

A default config is installed if one does not already exist.

### Running as a service

Start podproxy as a background service (starts at login):

```bash
brew services start podproxy-latest
```

Stop the service:

```bash
brew services stop podproxy-latest
```

### Running manually

If you don't need a background service:

```bash
/opt/homebrew/opt/podproxy-latest/bin/podproxy --config /opt/homebrew/etc/podproxy/config.yaml
```

### Logs

Logs are written to:

```
/opt/homebrew/var/log/podproxy.log
```

### Uninstall

```bash
brew uninstall podproxy
brew untap entwico/tap
```
