import 'package:flutter/material.dart';
import 'package:iop_wallet/src/utils.dart';

import '../router_constants.dart';

class CreateVaultPage extends StatefulWidget {
  @override
  _CreateVaultPageState createState() => _CreateVaultPageState();
}

class _CreateVaultPageState extends State<CreateVaultPage> {
  static final mnemonic =
      'helmet loop diesel nephew birth word spring erosion bitter ugly orbit festival cake armed worth orchard immense hunt crime nominee nominee nominee nominee nominee';
  final List<String> mnemonicList = mnemonic.split(' ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Your Mnemonmic'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'The mnemonic is a human readable representation of your master seed. This seed allows you to derive all the key pairs for your identities.'),
          ),
          Table(children: this._createMnemonicTable()),
          IconButton(onPressed: () {}, icon: Icon(Icons.cached)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'DO NOT FORGET to write down your mnemonic to a secure place! You will need this to restore your wallet in case you lose access to your device.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: ElevatedButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.pushNamed(context, routeSetupEnterPassword);
                    }),
                width: buttonWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<TableRow> _createMnemonicTable() {
    List<TableRow> mnemonicTable = [];
    List<Widget> tableRow = [];

    for (var i = 0; i < mnemonicList.length; i++) {
      Widget tile = this._createListTile(i, mnemonicList[i]);
      tableRow.add(tile);

      if (tableRow.length == 4) {
        mnemonicTable.add(TableRow(children: tableRow));
        tableRow = [];
      }
    }
    return mnemonicTable;
  }

  ListTile _createListTile(int index, String content) {
    final style = TextStyle(fontSize: 12);
    return ListTile(
        dense: true,
        minLeadingWidth: 1,
        horizontalTitleGap: 4,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        leading: Text(
          '${index + 1}.',
          style: style,
        ),
        title: Text(content, style: style));
  }
}
