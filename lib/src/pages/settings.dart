import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final Future<BlockInfo> blockInfo;

  @override
  void initState() {
    super.initState();
    blockInfo = fetchBlockheight();
  }

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();
    return FutureBuilder<BlockInfo>(
        future: blockInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return scaffold(settings, snapshot.data!.height);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget scaffold(SettingsModel settings, Object? blockInfo) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Settings")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: Text('Remove your vault'),
                onPressed: () {
                  settings.setInitialized(false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, routeWelcome, (Route<dynamic> route) => false);
                }),
            Text('Show Blockheight: $blockInfo'),
          ],
        ),
      ),
    );
  }

  Future<BlockInfo> fetchBlockheight() async {
    final resp =
        await http.get(Uri.https('hydra.iop.global:4705', 'api/v2/blockchain'));
    print("Inside Fetch!");

    if (resp.statusCode == 200) {
      return BlockInfo.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load BlockInfo');
    }
  }
}

class BlockInfo {
  final int? height;
  final String? id;
  final String? supply;

  BlockInfo({this.height, this.id, this.supply});

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final block = data['block'];

    return BlockInfo(
      height: block['height'],
      id: block['id'],
      supply: data['supply'],
    );
  }
}
