import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Settings')),
      body: Center(
        child: Column(
          children: [
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => _buildExportDialog(context)),
              title: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Export Vault'),
              ),
            ),
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildRemoveDialog(context)),
              title: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Remove Vault'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Wallet'),
      content: const Text('Are you sure to delete your wallet? '
          'You will lose access to your credentials '
          'unless you have a backup of your seed phrase.'),
      actions: <TextButton>[
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
        TextButton(
            onPressed: () async {
              await AppSharedPrefs.removeVault();
              await Navigator.pushNamedAndRemoveUntil(
                  context, routeWelcome, (Route<dynamic> route) => false);
            },
            child: const Text('Yes')),
      ],
      elevation: 24.0,
    );
  }

  Widget _buildExportDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Export Vault'),
      content: const Text('Are you sure nobody is looking? '
          'Your mnemonic allows anyone to access your identities.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
        TextButton(
            onPressed: () async {
              final serializedVault = await AppSharedPrefs.getVault();
              await FileSaver.instance.saveFile(
                  'iop_vault',
                  Uint8List.fromList(serializedVault!.codeUnits),'.json',
                  mimeType: MimeType.JSON
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saved to Downloads'),
                ),
              );
            },
            child: const Text('Yes')),
      ],
      elevation: 24.0,
    );
  }
}
