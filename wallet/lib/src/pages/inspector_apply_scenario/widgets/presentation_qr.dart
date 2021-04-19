import 'package:flutter/material.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PresentationQr extends StatelessWidget {
  final String _url;
  final ContentId _id;

  const PresentationQr(this._url, this._id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AlertDialog(
      title: const Text('Your Presentation'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            const Text('Presentation ID:'),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(_id.value, style: themeData.textTheme.caption),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Center(child: QrImage(data: _url, size: 200.0)),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(routeDashboard);
          },
          style: TextButton.styleFrom(primary: themeData.primaryColor),
          child: const Text('Back to Dashboard'),
        ),
      ],
    );
  }
}
