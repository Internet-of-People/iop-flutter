import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/onboarding/slides/enter_mnemonic_slide.dart';
import 'package:provider/provider.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:iop_wallet/src/models/settings/settings.dart';
import 'package:iop_wallet/src/pages/onboarding/mnemonic_model.dart';
import 'package:iop_wallet/src/pages/onboarding/slides/generate_mnemonic_slide.dart';
import 'package:iop_wallet/src/pages/onboarding/slides/password_slide.dart';
import 'package:iop_wallet/src/router_constants.dart';

class RestoreVault extends StatefulWidget {
  @override
  _RestoreVaultState createState() => _RestoreVaultState();
}

class _RestoreVaultState extends State<RestoreVault> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _mnemonicKey = GlobalKey<FormState>();
  final _mnemonicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      contentMargin: EdgeInsets.all(0.0),
      titlePadding: EdgeInsets.fromLTRB(0.0, 128.0, 0.0, 0.0),
      imagePadding: EdgeInsets.all(0.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: Colors.white,
    );

    return IntroductionScreen(
      key: _introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: const Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 32),
            child: Center(
              child: Text('Restore Your Vault', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: 'Enter Mnemonic',
          bodyWidget: EnterMnemonicSlide(_mnemonicKey, _mnemonicController),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Protect Mnemonic',
          bodyWidget: PasswordSlide(_passwordFormKey, _passwordController),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onDoneClick(context),
      skipFlex: 0,
      nextFlex: 0,
      next: const Text('Next'),
      done: const Text('Done'),
      curve: Curves.easeInToLinear,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding:const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.teal,
        size: Size(10.0, 10.0),
        color: Colors.black45,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
  
  Future<void> _onDoneClick(BuildContext context) async {
    // TODO: use these to create the vault
    print(_passwordController.value.text);
    print(_mnemonicController.value.text);

    if (
      !_mnemonicKey.currentState!.validate() ||
      !_passwordFormKey.currentState!.validate()
    ) {
      return;
    }

    final settings = context.watch<SettingsModel>();
    await settings.setInitialized(true);
    await Navigator
        .of(context)
        .pushNamedAndRemoveUntil(routeWelcome, (route) => false);
  }
}
