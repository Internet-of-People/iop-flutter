import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iop_wallet/src/models/settings/settings.dart';
import 'package:iop_wallet/src/pages/actions/action_page.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  late final Future<BlockInfo> _futureBlockInfo = _fetchBlockheight();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();
    return FutureBuilder<BlockInfo>(
        future: _futureBlockInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return _createScaffold(context, settings, snapshot.data?.height);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _createScaffold(
      BuildContext context, SettingsModel settings, Object? blockInfo) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Settings')),
      body: Center(
        child: Column(
          children: [
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => _buildExportDialog(context, settings)),
              title: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Export Wallet'),
              ),
            ),
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => _buildRemoveDialog(context, settings)),
              title: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Remove Wallet'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('Blockheight: $blockInfo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveDialog(BuildContext context, SettingsModel settings) {
    return AlertDialog(
      title: Text('Remove Wallet'),
      content: Text(
          'Are you sure to delete your wallet? You will lose access to your credentials unless you have a backup of your seed phrase.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('No')),
        TextButton(
            onPressed: () async {
              await settings.setInitialized(false);
              await Navigator.pushNamedAndRemoveUntil(
                  context, routeWelcome, (Route<dynamic> route) => false);
            },
            child: Text('Yes')),
      ],
      elevation: 24.0,
    );
  }

  Widget _buildExportDialog(BuildContext context, SettingsModel settings) {
    return AlertDialog(
      title: Text('Export Wallet'),
      content: Text(
          'Are you sure nobody is looking? Your mnemonic allows anyone to access your identities.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('No')),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, routeShowMnemonic);
            },
            child: Text('Yes')),
      ],
      elevation: 24.0,
    );
  }

  static Future<BlockInfo> _fetchBlockheight() async {
    final resp =
        await http.get(Uri.https('hydra.iop.global:4705', 'api/v2/blockchain'));
    if (resp.statusCode == 200) {
      return BlockInfo.fromJson(jsonDecode(resp.body));
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
      height: block['height'],
      id: block['id'],
      supply: data['supply'],
    );
  }

  final int height;
  final String id;
  final String supply;
}
