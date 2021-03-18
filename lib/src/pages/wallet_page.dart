import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/wallet.dart';
import 'package:provider/provider.dart';

import 'credential_details.dart';

export 'wallet_page.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: _CredentialList(),
            ),
          )
        ]),
      ),
    );
  }
}

class _CredentialList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wallet = context.watch<WalletModel>();

    return ListView.builder(
      itemCount: wallet.credentials.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.card_membership,
            color: Theme.of(context).primaryColorDark),
        title: ElevatedButton(
          child: Text(wallet.credentials[index]!.credentialName!),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CredentialRoute(wallet.credentials[index]!)));
          },
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Colors.red,
          ),
          onPressed: () {
            wallet.remove(wallet.credentials[index]);
          },
        ),
      ),
    );
  }
}
