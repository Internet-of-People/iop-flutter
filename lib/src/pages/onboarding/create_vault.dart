import 'package:flutter/material.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_wallet/src/shared_prefs.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:iop_wallet/src/pages/onboarding/mnemonic_model.dart';
import 'package:iop_wallet/src/pages/onboarding/slides/generate_mnemonic_slide.dart';
import 'package:iop_wallet/src/pages/onboarding/slides/password_slide.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_sdk/crypto.dart';

class CreateVault extends StatefulWidget {
  @override
  _CreateVaultState createState() => _CreateVaultState();
}

class _CreateVaultState extends State<CreateVault> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _mnemonicModel = MnemonicModel();

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
              child: Text('Create Your Vault', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: 'The Mnemonic',
          bodyWidget: const Text(
            'The mnemonic is a human readable representation of your master seed. '
            'This seed allows you to derive all the key pairs for your identities.',
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Your Mnemonic',
          bodyWidget: GenerateMnemonicSlide(_mnemonicModel),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Protect Mnemonic',
          bodyWidget: PasswordSlide(_passwordFormKey, _passwordController),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onDoneClick(),
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
  
  Future<void> _onDoneClick() async {
    final unlockPassword = _passwordController.value.text;

    if (!_passwordFormKey.currentState!.validate()) {
      return;
    }

    final vault = Vault.create(
      _mnemonicModel.words.join(' '),
      'Mne7Aj3Tm3mhBAnP',
      unlockPassword,
    );

    MorpheusPlugin.init(vault, unlockPassword);
    HydraPlugin.init(vault, unlockPassword, Network.TestNet, 0);
    HydraPlugin.init(vault, unlockPassword, Network.DevNet, 0);
    HydraPlugin.init(vault, unlockPassword, Network.MainNet, 0);

    final serializedVault = vault.save();

    await AppSharedPrefs.setVault(serializedVault);
    await Navigator
        .of(context)
        .pushNamedAndRemoveUntil(routeHome, (route) => false);
  }
}
