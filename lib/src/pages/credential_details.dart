import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/credential.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CredentialRoute extends StatelessWidget {
  CredentialRoute(this._credential);
  final CredentialModel _credential;

  @override
  Widget build(BuildContext context) {
    final _details = _credential.details;
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text(_credential.credentialName)),
        body: ListView(children: [
          _listDetails(_details),
          Center(child: QrImage(data: _details.toString(), size: 200.0)),
        ])

        // extendedBody:
        );
  }

  ListView _listDetails(Map<String, dynamic> details) {
    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (context, index) {
        final key = details.keys.elementAt(index);
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('$key : '),
              Expanded(
                child: Text(details[key].toString()),
              )
            ],
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
