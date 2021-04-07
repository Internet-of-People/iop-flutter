import 'package:flutter/material.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_wallet/src/pages/drawer/did_selector.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late Future<MorpheusPlugin> _fut;

  @override
  void initState() {
    super.initState();
    _fut = _loadMorpheus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fut,
      builder: (BuildContext context, AsyncSnapshot<MorpheusPlugin> snapshot) {
        if(!snapshot.hasData) {
          return const Text('Loading...');
        }

        final header = <Widget>[
          const Expanded(
              child: Text('Active Persona',
                  style: TextStyle(color: Colors.white, fontSize: 24)))
        ];

        final defaultDid = snapshot
            .data!
            .public
            .personas
            .did(0).defaultKeyId().toString();

        final dids = <String>[
          'Default (${defaultDid.substring(0,15)}...)'
        ];

        return DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            margin: EdgeInsets.zero,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(children: header),
              DidsDropdown(
                dids,
                dids[0],
                    (did) {
                  //TODO: ;
                },
              ),
            ]));
      }
    );
  }

  Future<MorpheusPlugin> _loadMorpheus() async {
    final serializedVault = await AppSharedPrefs.getVault();
    final vault = Vault.load(serializedVault!);
    return MorpheusPlugin.get(vault);
  }
}
