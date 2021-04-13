import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/shared_prefs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable(explicitToJson: true)
class WalletModel extends ChangeNotifier {
  WalletModel(this.credentials);

  final List<Credential> credentials;

  factory WalletModel.empty() => WalletModel(<Credential>[]);

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
  Map<String, dynamic> toJson() => _$WalletModelToJson(this);

  Future<void> addCredential(Credential credential) async {
    await _updateStorage(() {
      credentials.add(credential);
    });
  }

  Future<void> remove(Credential? credential) async {
    await _updateStorage(() {
      credentials.remove(credential);
    });
  }

  Future<void> load() async {
    final serializedWallet = await AppSharedPrefs.loadWallet();
    if (serializedWallet == null) {
      return;
    }
    final restoredWallet = WalletModel.fromJson(
      json.decode(serializedWallet) as Map<String, dynamic>,
    );
    credentials.clear();
    credentials.addAll(restoredWallet.credentials);
    notifyListeners();
  }

  Future<void> _updateStorage(Function function) async {
    try {
      function.call();
      await save();
    } catch (e) {
      // nothing to do
    }
  }

  Future<void> save() async {
    await AppSharedPrefs.setWallet(json.encode(toJson()));
    notifyListeners();
  }

  Future<void> emptyStorage() async {
    credentials.clear();
    await save();
  }
}
