import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/actions/action_page.dart';
import 'package:iop_wallet/src/pages/home/header.dart';
import 'package:iop_wallet/src/pages/wallet/wallet_page.dart';
import 'package:iop_wallet/src/router_constants.dart';

class HomePage extends StatelessWidget {
  final _tabs = <Tab>[Tab(child: ActionPage()), Tab(child: WalletPage())];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('IOP Wallet')),
        body: TabBarView(children: _tabs),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home_outlined)),
            Tab(icon: Icon(Icons.wallet_membership)),
          ],
          labelColor: Colors.teal,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Header(),
              ListTile(
                title: const Text('Profiles'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeProfiles);
                },
              ),
              ListTile(
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
              const ListTile(title: Text('History')),
            ],
          ),
        ),
      ),
    );
  }
}
