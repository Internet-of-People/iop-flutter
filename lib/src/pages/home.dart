import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';

import 'add_credential.dart';
import 'wallet_page.dart';

class HomePage extends StatelessWidget {
  final _tabs = <Tab>[Tab(child: Scanner()), Tab(child: WalletPage())];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('IOP Wallet')),
        body: TabBarView(children: _tabs),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home_outlined)),
            Tab(icon: Icon(Icons.wallet_membership)),
          ],
          labelColor: Colors.teal,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Center(child: Text('IOP Wallet'))),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeSettings);
                },
              ),
              ListTile(title: Text('History')),
              ListTile(title: Text('List Processes')),
            ],
          ),
        ),
      ),
    );
  }
}
