import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:iop_wallet/src/pages/home/tabs/credential_details.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:provider/provider.dart';

export 'credentials.dart';

class CredentialsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: _CredentialList(),
          ),
        )
      ]),
    );
  }
}

class _CredentialList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletModel>();
    return (wallet.credentials.isEmpty)
        ? Center(
            child: Text(
            'You have no credentials in your wallet.',
            style: textTheme.bodyText1,
          ))
        : ListView.builder(
            itemCount: wallet.credentials.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.card_membership,
                  color: Theme.of(context).primaryColorDark),
              title: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CredentialDetails(wallet.credentials[index])));
                },
                child: Text(wallet.credentials[index].credentialName),
              ),
              trailing: IconButton(
                icon: const Icon(
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
