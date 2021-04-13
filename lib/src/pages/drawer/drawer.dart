import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/drawer/header.dart';
import 'package:iop_wallet/src/router_constants.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Header(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Personas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routePersonas);
            },
          ),
          ListTile(
            leading: const Icon(Icons.wallet_membership),
            title: const Text('Credentials'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeCredentials);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              'Settings',
            ),
            onTap: () async {
              Navigator.pop(context);
              await Navigator
                  .of(context)
                  .pushNamed(routeSettings);
            },
          ),
        ],
      ),
    );
  }
}
