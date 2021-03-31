import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/intro-slider/slide_object.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:iop_wallet/src/utils.dart';

class OnboardingSlides {
  static Slide mnemonicInfoSlide = Slide(
    title: 'Your Mnemonic',
    styleTitle: textTheme.headline1,
    description:
        'The mnemonic is a human readable representation of your master seed. '
        'This seed allows you to derive all the key pairs for your identities.',
    styleDescription: textTheme.bodyText1,
    centerWidget: Transform.rotate(
      angle: math.pi / 2,
      child: formattedIcon(Icons.account_tree),
    ),
    backgroundColor: appTheme.backgroundColor,
  );

  static Slide showMnemonic(Widget centerWidget) {
    return Slide(
      title: 'Secure Your Mnemonic',
      styleTitle: textTheme.headline1,
      description:
          'Anybody with access to these 24 words can steal your identity. '
          'Write them down and store them in a secure location, '
          'in case you lose your device!',
      styleDescription: textTheme.bodyText1,
      centerWidget: centerWidget,
      marginDescription: const EdgeInsets.all(15),
      backgroundColor: appTheme.backgroundColor,
    );
  }

  static Slide enterMnemonic = Slide(
      title: 'Unlock Your Vault',
      styleTitle: textTheme.headline1,
      description: 'Enter your 24-word mnemonic to restore your wallet. '
          "Don't forget the spaces between the words and "
          'remember that the order of the words is important!',
      styleDescription: textTheme.bodyText1,
      centerWidget: Column(
        children: [
          formattedIcon(Icons.account_balance),
          const Padding(
              padding: EdgeInsets.all(32.0),
              child: TextField(
                  decoration:
                      InputDecoration(labelText: 'Enter your mnemonic'))),
        ],
      ),
      backgroundColor: appTheme.backgroundColor);

  static Slide enterPassword(Widget centerWidget) {
    return Slide(
      title: 'Pick a Password',
      styleTitle: textTheme.headline1,
      description: 'The password encrypts your mnemonic. '
          'This adds another layer of security for your personal identities.',
      styleDescription: textTheme.bodyText1,
      centerWidget: centerWidget,
      backgroundColor: appTheme.backgroundColor,
    );
  }
}
