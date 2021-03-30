import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/intro-slider/intro_slider.dart';
import 'package:iop_wallet/src/intro-slider/slide_object.dart';
import 'package:iop_wallet/src/models/settings/settings.dart';
import 'package:iop_wallet/src/pages/setup/onboarding_slides.dart';
import 'package:iop_wallet/src/pages/setup/mnemonic_slide_body.dart';
import 'package:iop_wallet/src/pages/setup/password_slide_body.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:provider/provider.dart';

class CreateVaultSlider extends StatefulWidget {
  @override
  _CreateVaultSliderState createState() => _CreateVaultSliderState();
}

class _CreateVaultSliderState extends State<CreateVaultSlider> {
  final List<Slide> _slides = [];
  final MnemonicSlideBody _mnemonicSlideBody = MnemonicSlideBody();
  final PasswordSlideBody _passwordSlideBody = PasswordSlideBody();

  @override
  void initState() {
    super.initState();
    _slides.addAll(<Slide>[
      OnboardingSlides.mnemonicInfoSlide,
      OnboardingSlides.showMnemonic(_mnemonicSlideBody),
      OnboardingSlides.enterPassword(_passwordSlideBody),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    return Scaffold(
      body: IntroSlider(
        slides: _slides,
        onDonePress: () async {
          if (!_passwordSlideBody.formKey.currentState!.validate()) {
            return;
          }
          await settings.setInitialized(true);
          await Navigator.of(context)
              .pushNamedAndRemoveUntil(routeWelcome, (route) => false);
        },
      ),
    );
  }
}
