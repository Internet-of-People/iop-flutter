import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils.dart';

class ActionPage extends StatelessWidget {
  final double boxWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _getOptions(context)));
  }

  Widget _getOptions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/src/assets/iop_logo.png'),
            width: 200,
          ),
          ElevatedButton(
            onPressed: () => scanQr(context, listAuthorityProcesses),
            child: SizedBox(
                width: boxWidth, child: Center(child: Text('Scan QR'))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, routeAddCredential),
            child: SizedBox(
                width: boxWidth, child: Center(child: Text('Add Credential'))),
          ),
        ],
      ),
    );
  }

  Future<void> scanQr(BuildContext context, Function executeOnResult) async {
    // TODO replace local authority url with 'await scanQrUntilResult()'
    final barcodeScanRes = 'http://10.0.2.2:8083';
    await executeOnResult(context, barcodeScanRes);
  }

  Future<void> listAuthorityProcesses(BuildContext context, String ip) async {
    final uri = Uri.parse(ip);
    final host = uri.scheme + '://' + uri.host;
    final port = uri.port;
    await Navigator.pushNamed(context, routeAuthorityProcesses,
        arguments: AuthorityUrlArguments(host: host, port: port));
  }
}
