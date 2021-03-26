import 'package:flutter_test/flutter_test.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';

void main() {
  group('Wallet Model notifies listeners', () {
    var callCount = 0;
    late WalletModel wallet;

    setUp(() async {
      callCount = 0;
      wallet = WalletModel()
        ..addListener(() {
          callCount += 1;
        });
      await wallet.emptyStorage();
    });

    test('Load Wallet', () {
      expect(wallet.credentials.length, 0);
      expect(callCount, 0);
    });

    test('Add Credential', () async {
      callCount = 0;
      await wallet.add(Credential.fromJson({
        'name': 'Hello',
        'details': {'name': 'World'}
      }));
      expect(wallet.credentials.length, 1);
      expect(callCount, 1);
    });

    test('Remove Credential', () async {
      callCount = 0;
      await wallet.remove(Credential.fromJson({
        'name': 'Hello',
        'details': {'name': 'World'}
      }));
      expect(wallet.credentials.length, 0);
      expect(callCount, 1);
    });
  });

  group('Wallet Model Data is persisted', () {
    WalletModel wallet;
    final credential = Credential.fromJson({
      'name': 'Hello',
      'details': {'name': 'World'}
    });

    setUp(() async {
      wallet = WalletModel();
      await wallet.emptyStorage();
      await wallet.add(credential);
    });

    test('New Wallet contains credential', () async {
      final newWallet = WalletModel();
      await newWallet.load();
      expect(
          newWallet.credentials[0].credentialName, credential.credentialName);
      expect(newWallet.credentials[0].details, credential.details);
    });
  });
}
