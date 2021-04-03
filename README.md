# IOP Wallet

The user app that holds a vault with digital identities (DID and VC's).

### Project setup
```
flutter pub get
```

### Unsafe dependencies

Run to check the dependencies that haven't migrated to null-safety yet:

```
flutter pub outdated --mode=null-safety
```

Current unsafe dependencies:
- build_runner