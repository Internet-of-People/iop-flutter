import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PresentationQr extends StatelessWidget {
  final String _url;

  const PresentationQr(this._url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: QrImage(data: _url, size: 200.0),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(routeHome);
          },
          style: TextButton.styleFrom(primary: Colors.black54),
          child: const Text('Back to Dashboard'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(primary: themeData.primaryColor),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
