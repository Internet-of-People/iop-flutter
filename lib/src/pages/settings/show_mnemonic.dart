import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/settings/settings.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:iop_wallet/src/utils.dart';
import 'package:provider/provider.dart';

class showMnemonicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>?>(
      future: _getMnemonicFuture(context),
      builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text('Mnemonic')),
          body: (snapshot.data == null)
              ? Center(child: Text('An error occurred'))
              : _buildPage(snapshot.data!),
        );
      },
    );
  }

  Future<List<String>?> _getMnemonicFuture(BuildContext context) async {
    final settings = context.read<SettingsModel>();
    final mnemonic = await settings.getMnemonic();
    return mnemonic;
  }

  Widget _buildPage(List<String> mnemonicList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Do not share your mnemonic with anyone, since this can result in identity theft! Keep it written down in a safe place!',
            style: textTheme.headline2,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(children: createMnemonicTable(mnemonicList)),
        )
      ],
    );
  }
}
