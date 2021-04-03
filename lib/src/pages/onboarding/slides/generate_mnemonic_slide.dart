import 'package:flutter/material.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:flutter/services.dart';
import 'package:iop_wallet/src/pages/onboarding/mnemonic_model.dart';
import 'package:iop_wallet/src/theme.dart';

class GenerateMnemonicSlide extends StatefulWidget {
  final MnemonicModel model;

  const GenerateMnemonicSlide(this.model);

  @override
  _GenerateMnemonicSlideState createState() =>
      _GenerateMnemonicSlideState();
}

class _GenerateMnemonicSlideState extends State<GenerateMnemonicSlide> {
  final Bip39 _bip39 = Bip39('en');
  late List<String> _mnemonic;

  @override
  void initState() {
    super.initState();
    _generatePhrase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Table(children: _buildMnemonicTable()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStyledTextButton('Copy', Icons.content_copy, _copy),
              _buildStyledTextButton('Generate', Icons.cached, _generatePhrase),
            ],
          ),
        ),
      ],
    );
  }

  void _copy() {
    final clipboard = _mnemonic.join(' ');
    Clipboard.setData(ClipboardData(text: clipboard));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard.'),
      ),
    );
  }

  void _generatePhrase() {
    setState(() {
      _mnemonic = _bip39.generatePhrase().split(' ');
      widget.model.words = _mnemonic;
    });
  }

  List<TableRow> _buildMnemonicTable() {
    final mnemonicTable = <TableRow>[];
    var tableRow = <Widget>[];

    for (var i = 0; i < _mnemonic.length; i++) {
      final tile = _buildListTile(i, _mnemonic[i]);
      tableRow.add(tile);

      if (tableRow.length == 4) {
        mnemonicTable.add(TableRow(children: tableRow));
        tableRow = [];
      }
    }
    return mnemonicTable;
  }

  Widget _buildListTile(int index, String content) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: Alignment.center,
        height: 44,
        decoration: BoxDecoration(
            color: appTheme.primaryColorLight,
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          title: Text(
            '${index + 1}: $content',
            style: textTheme.headline3,
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextButton(
      String label, IconData iconData, void Function()? onPressed) =>
      SizedBox(
        width: 120,
        child: TextButton.icon(
          style: TextButton.styleFrom(backgroundColor: appTheme.primaryColor),
          label: Text(label, style: textTheme.button),
          icon: Icon(iconData, color: appTheme.backgroundColor),
          onPressed: onPressed,
        ),
      );
}
