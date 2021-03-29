import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/intro-slider/slide_object.dart';
import 'package:iop_wallet/src/utils.dart';

class OnboardingSlides {
  static final Color backgroundColor = Color(0xff009688);

  static final mnemonicInfoSlide = Slide(
    title: 'Your Mnemonic',
    description:
        'The mnemonic is a human readable representation of your master seed. This seed allows you to derive all the key pairs for your identities.',
    centerWidget: Transform.rotate(
      angle: math.pi / 2,
      child: formattedIcon(Icons.account_tree),
    ),
    backgroundColor: backgroundColor,
  );

  static Slide pickPassword = Slide(
    title: 'Pick a Password',
    description:
        'The password encrypts your mnemonic. This adds another layer of security for your personal identities.',
    centerWidget: Column(
      children: [
        formattedIcon(Icons.security),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(child: textField('Enter your password here', true)),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );

  static Slide enterMnemonic = Slide(
      title: 'Unlock Your Vault',
      description:
          "Enter your 24-word mnemonic to restore your wallet. Don't forget the spaces between the words and remember that the order of the words is important!",
      centerWidget: Column(
        children: [
          formattedIcon(Icons.account_balance),
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: textField('Enter your mnemonic', false)),
        ],
      ),
      backgroundColor: backgroundColor);

  static Slide showMnemonic(List<String> mnemonicList) {
    return Slide(
      title: 'Secure Your Mnemonic',
      description:
          'Anybody with access to these 24 words can steal your identity. Write them down and store them in a secure location, in case you lose your device!',
      centerWidget: Column(
        children: [
          Table(children: createMnemonicTable(mnemonicList, Colors.white)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.cached, color: Colors.white)),
        ],
      ),
      marginDescription: EdgeInsets.all(15),
      backgroundColor: backgroundColor,
    );
  }

  static Widget textField(String hintText, bool obscured) {
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

  static Icon formattedIcon(IconData iconData) =>
      Icon(iconData, size: 250, color: Colors.amber);
}
