import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intro_slider/intro_slider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';

import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/pages/slides.dart';
import 'package:iop_wallet/src/router_constants.dart';

class RestoreVaultSlider extends StatefulWidget {
  @override
  _RestoreVaultSliderState createState() => _RestoreVaultSliderState();
}

class _RestoreVaultSliderState extends State<RestoreVaultSlider> {
  List<Slide> slides = <Slide>[];

  @override
  void initState() {
    super.initState();
    slides.add(Slides.mnemonicInfoSlide);

    slides.add(Slides.enterMnemonic);

    slides.add(Slides.pickPassword);
  }

  void onDonePress() {}

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();

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
