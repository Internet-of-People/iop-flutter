import "package:flutter/material.dart";
import "package:intro_slider/slide_object.dart";

class Slides {
  static final Color backgroundColor = Color(0xff009688);

  static final mnemonicInfoSlide = Slide(
    title: "Your Mnemonic",
    description:
        "The mnemonic is a human readable representation of your master seed. This seed allows you to derive all the key pairs for your identities.",
    pathImage: "lib/src/assets/key_derivation.png",
    backgroundColor: backgroundColor,
  );

  static Slide pickPassword = Slide(
    title: "Pick a Password",
    description:
        "The password encrypts your mnemonic. This adds another layer of security for your personal identities.",
    centerWidget: Column(
      children: [
        Image.asset(
          "lib/src/assets/lock.png",
          width: 250,
          height: 250,
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(child: textField("Enter your password here", true)),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );

  static Slide enterMnemonic = Slide(
      title: "Unlock Your Vault",
      description:
          "Enter your 24-word mnemonic to restore your wallet. Don't forget the spaces between the words and remember that the order of the words is important!",
      centerWidget: Column(
        children: [
          Image.asset(
            "lib/src/assets/unlocked_vault.png",
            width: 250,
            height: 250,
          ),
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: textField("Enter your mnemonic", false)),
        ],
      ),
      backgroundColor: backgroundColor);

  static Slide showMnemonic(List<String> mnemonicList) {
    return Slide(
      title: "Secure Your Mnemonic",
      description:
          "Anybody with access to these 24 words can steal your identity. Write them down and store them in a secure location, in case you lose your device!",
      centerWidget: Column(
        children: [
          Table(children: _createMnemonicTable(mnemonicList)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.cached, color: Colors.white)),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  static List<TableRow> _createMnemonicTable(List<String> mnemonicList) {
    List<TableRow> mnemonicTable = [];
    List<Widget> tableRow = [];

    for (var i = 0; i < mnemonicList.length; i++) {
      Widget tile = _createListTile(i, mnemonicList[i]);
      tableRow.add(tile);

      if (tableRow.length == 4) {
        mnemonicTable.add(TableRow(children: tableRow));
        tableRow = [];
      }
    }
    return mnemonicTable;
  }

  static ListTile _createListTile(int index, String content) {
    final style = TextStyle(fontSize: 12, color: Colors.white);
    return ListTile(
        dense: true,
        minLeadingWidth: 1,
        horizontalTitleGap: 4,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        leading: Text(
          "${index + 1}.",
          style: style,
        ),
        title: Text(content, style: style));
  }

  static textField(String hintText, bool obscured) {
    return TextField(
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      obscureText: obscured,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
