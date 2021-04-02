import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/intro-slider/slide_object.dart';
import 'package:iop_wallet/src/utils.dart';

class OnboardingSlides {
  static Slide mnemonicInfoSlide() {
    return Slide(
      title: 'Your Mnemonic',
      description:
          // ignore: lines_longer_than_80_chars
          'The mnemonic is a human readable representation of your master seed. '
          // ignore: lines_longer_than_80_chars
          'This seed allows you to derive all the key pairs for your identities.',
      centerWidget: Transform.rotate(
        angle: math.pi / 2,
        child: formattedIcon(Icons.account_tree),
      ),
    );
  }

  static Slide showMnemonic(Widget centerWidget, Function? onNextPress) {
    return Slide(
      title: 'Secure Your Mnemonic',
      description:
          'Anybody with access to these 24 words can steal your identity. '
          'Write them down and store them in a secure location, '
          'in case you lose your device!',
      centerWidget: centerWidget,
      onNextPress: onNextPress,
      marginDescription: const EdgeInsets.all(15),
    );
  }

  static Slide enterMnemonic(Widget centerWidget, Function? onNextPress) {
    return Slide(
      title: 'Unlock Your Vault',
      description: 'Enter your 24-word mnemonic to restore your wallet. '
          "Don't forget the spaces between the words and "
          'remember that the order of the words is important!',
      centerWidget: centerWidget,
      onNextPress: onNextPress,
    );
  }

  static Slide enterPassword(Widget centerWidget) {
    return Slide(
      title: 'Pick a Password',
      description: 'The password encrypts your mnemonic. '
          'This adds another layer of security for your personal identities.',
      centerWidget: centerWidget,
    );
  }
}
