import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class SettingsPage extends StatelessWidget {
  late final Future<BlockInfo> _futureBlockInfo = _fetchBlockheight();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BlockInfo>(
        future: _futureBlockInfo,
        builder: (BuildContext context, AsyncSnapshot<BlockInfo> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return _buildScaffold(context, snapshot.data?.height);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildScaffold(
      BuildContext context, Object? blockInfo) {
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
                child: Text('Export Wallet'),
              ),
            ),
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildRemoveDialog(context)),
              title: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Remove Wallet'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Blockheight: $blockInfo'),
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
      title: const Text('Export Wallet'),
      content: const Text('Are you sure nobody is looking? '
          'Your mnemonic allows anyone to access your identities.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
        TextButton(
            onPressed: () async {
              final params = SaveFileDialogParams(
                  sourceFilePath: "path_of_file_to_save"
              );

              final filePath = await FlutterFileDialog.saveFile(params: params);
              print(filePath);
              //Navigator.pop(context);
              //await Navigator.pushNamed(context, routeShowMnemonic);
            },
            child: const Text('Yes')),
      ],
      elevation: 24.0,
    );
  }

  static Future<BlockInfo> _fetchBlockheight() async {
    final resp =
        await http.get(Uri.https('hydra.iop.global:4705', 'api/v2/blockchain'));
    if (resp.statusCode == 200) {
      return BlockInfo.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load BlockInfo');
    }
  }
}

class BlockInfo {
  BlockInfo({required this.height, required this.id, required this.supply});

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final block = data['block'];

    return BlockInfo(
      height: block['height'] as int,
      id: block['id'] as String,
      supply: data['supply'] as String,
    );
  }

  final int height;
  final String id;
  final String supply;
}
