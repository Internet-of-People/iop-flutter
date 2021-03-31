import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/pages/setup/password_slide_body.dart';
import 'package:provider/provider.dart';
import 'package:iop_wallet/src/intro-slider/intro_slider.dart';
import 'package:iop_wallet/src/intro-slider/slide_object.dart';
import 'package:iop_wallet/src/models/settings/settings.dart';
import 'package:iop_wallet/src/pages/setup/onboarding_slides.dart';
import 'package:iop_wallet/src/router_constants.dart';

class RestoreVaultSlider extends StatefulWidget {
  @override
  _RestoreVaultSliderState createState() => _RestoreVaultSliderState();
}

class _RestoreVaultSliderState extends State<RestoreVaultSlider> {
  final _slides = <Slide>[];
  final _passwordSlideBody = PasswordSlideBody();

  @override
  void initState() {
    super.initState();
    _slides.addAll(<Slide>[
      OnboardingSlides.mnemonicInfoSlide,
      OnboardingSlides.enterMnemonic,
      OnboardingSlides.enterPassword(_passwordSlideBody),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    return IntroSlider(
        slides: _slides,
        onDonePress: () async {
          if (!_passwordSlideBody.formKey.currentState!.validate()) {
            return;
          }
          await settings.setInitialized(true);
          await Navigator.of(context)
              .pushNamedAndRemoveUntil(routeWelcome, (route) => false);
        });
  }
}
