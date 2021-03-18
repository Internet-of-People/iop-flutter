import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iop_wallet/src/models/settings.dart';
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
            ElevatedButton(
              onPressed: () async {
                await settings.setInitialized(false);
                await Navigator.pushNamedAndRemoveUntil(
                    context, routeWelcome, (Route<dynamic> route) => false);
              },
              child: Text('Remove your vault'),
            ),
            Text('Show Blockheight: $blockInfo'),
          ],
        ),
      ),
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
