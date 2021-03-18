import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:intro_slider/intro_slider.dart";
import "package:intro_slider/slide_object.dart";
import "package:iop_wallet/src/models/settings.dart";
import "package:iop_wallet/src/pages/slides.dart";
import "package:provider/provider.dart";

import "../router_constants.dart";

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
        slides: this.slides,
        onDonePress: () async {
          if (true) {
            await settings.setInitialized(true);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(routeWelcome, (route) => false);
          }
        });
  }
}
