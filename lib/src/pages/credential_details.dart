import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/credential.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CredentialRoute extends StatelessWidget {
  final CredentialModel _credential;
  CredentialRoute(this._credential);

  @override
  Widget build(BuildContext context) {
    final _details = _credential.details!;
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text(_credential.credentialName!)),
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
        String key = details.keys.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            children: [
              new Text('$key : '),
              new Expanded(
                child: new Text(details[key].toString()),
              )
            ],
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
