import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_wallet/src/pages/drawer/drawer.dart';
import 'package:iop_wallet/src/router_constants.dart';

class DashboardPage extends StatelessWidget {
  final double boxWidth = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('IOP Wallet')),
      body: Center(child: _getOptions(context)),
      drawer: MainDrawer(),
    );
  }

  Widget _getOptions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Image(
            image: AssetImage('lib/src/assets/iop_logo.png'),
            width: 300,
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () => _scanQr(context),
                child: SizedBox(
                    width: boxWidth,
                    child: const Center(child: Text('Scan QR'))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _scanQr(BuildContext context) async {
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    final uri = Uri.parse(barcodeScanRes);
    final apiConfig = ApiConfig('${uri.scheme}://${uri.host}', uri.port);

    if (await _isAuthorityApi(apiConfig)) {
      await Navigator.pushNamed(context, routeAuthorityProcesses,
          arguments: apiConfig);
    } else if (await _isInspectorApi(apiConfig)) {
      await Navigator.pushNamed(context, routeInspectorScenarios,
          arguments: apiConfig);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not supported QR code'),
        ),
      );
    }
  }

  Future<bool> _isAuthorityApi(ApiConfig apiConfig) async {
    try {
      await AuthorityPublicApi(apiConfig).listProcesses();
      return true;
    } catch (e) {
      // Nothing to do here
    }
    return false;
  }

  Future<bool> _isInspectorApi(ApiConfig apiConfig) async {
    try {
      await InspectorPublicApi(apiConfig).listScenarios();
      return true;
    } catch (e) {
      // Nothing to do here
    }
    return false;
  }
}
