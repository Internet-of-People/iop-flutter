import 'package:flutter_test/flutter_test.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';

void main() {
  group('Wallet Model notifies listeners', () {
    late int callCount;
    late WalletModel wallet;

    setUp(() {
      callCount = 0;
      wallet = WalletModel.empty()
        ..addListener(() {
          callCount += 1;
        });
    });

    test('Initialize Wallet', () {
      expect(wallet.credentials.length, 0);
      expect(callCount, 0);
    });

    test('Add Credential', () async {
      await wallet.add(Credential.fromJson({
        'sentAt': 'some datetime',
        'processName': 'Sample Digitalized ID Card',
        'capabilityUrl': 'an exact url which you can pull',
        'status': 'approved',
        'witnessStatement': null,
        'rejectionReason': null,
      }));
      expect(wallet.credentials.length, 1);
      expect(callCount, 1);
    });

    test('Remove Credential', () async {
      await wallet.remove(Credential.fromJson({
        'sentAt': 'some datetime',
        'processName': 'Sample Digitalized ID Card',
        'capabilityUrl': 'an exact url which you can pull',
        'status': 'approved',
        'witnessStatement': null,
        'rejectionReason': null,
      }));
      expect(wallet.credentials.length, 0);
      expect(callCount, 1);
    });
  });

  group('Wallet Model Data is persisted', () {
    WalletModel wallet;
    final credential = Credential.fromJson({
      'sentAt': 'some datetime',
      'processName': 'Sample Digitalized ID Card',
      'capabilityUrl': 'an exact url which you can pull',
      'status': 'approved',
      'witnessStatement': null,
      'rejectionReason': null,
    });

    setUp(() async {
      wallet = WalletModel.empty();
      await wallet.emptyStorage();
      await wallet.add(credential);
    });

    test('New Wallet contains credential', () async {
      final newWallet = WalletModel.empty();
      await newWallet.load();
      expect(newWallet.credentials[0].processName, credential.processName);
    });
  });
}
