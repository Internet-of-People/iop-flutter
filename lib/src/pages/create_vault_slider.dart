import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intro_slider/intro_slider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intro_slider/slide_object.dart';
import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/pages/slides.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:provider/provider.dart';

class CreateVaultSlider extends StatefulWidget {
  @override
  _CreateVaultSliderState createState() => _CreateVaultSliderState();
}

class _CreateVaultSliderState extends State<CreateVaultSlider> {
  List<Slide> slides = <Slide>[];

  static final mnemonic =
      'helmet loop diesel nephew birth word spring erosion bitter ugly orbit festival cake armed worth orchard immense hunt crime nominee nominee nominee nominee nominee';
  final List<String> mnemonicList = mnemonic.split(' ');

  @override
  void initState() {
    super.initState();
    slides.add(Slides.mnemonicInfoSlide);

    slides.add(Slides.showMnemonic(mnemonicList));

    slides.add(Slides.pickPassword);
  }

  void onDonePress() {}

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    return IntroSlider(
        isShowSkipBtn: false,
        slides: slides,
        onDonePress: () async {
          if (true) {
            await settings.setInitialized(true);
            await Navigator.of(context)
                .pushNamedAndRemoveUntil(routeWelcome, (route) => false);
          }
        });
  }
}
