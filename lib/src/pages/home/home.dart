import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/drawer/drawer.dart';
import 'package:iop_wallet/src/pages/home/tabs/credentials.dart';
import 'package:iop_wallet/src/pages/home/tabs/dashboard.dart';

class HomePage extends StatelessWidget {
  final _tabs = <Tab>[Tab(child: DashboardTab()), Tab(child: CredentialsTab())];

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
        drawer: MainDrawer()
      ),
    );
  }
}
