# IOP Wallet

The user app that holds a vault with digital identities (DID and VC's). See more at our [developer portal](https://developer.iop.technology/).

## Development

### Setup

```bash
$ flutter pub get
```

### Lint

```bash
$ flutter analyze
```

### Generate Json Mappers

```bash
$ flutter pub run build_runner build --delete-conflicting-outputs
```

### Generate Icons

```bash
$ flutter pub run flutter_launcher_icons:main
```

### Null Safety

The app is null-safe, however some of its depencies are not:
- build_runner

```bash
# Check which packages are not yet null-safe:
$ flutter pub outdated --mode=null-safety
```