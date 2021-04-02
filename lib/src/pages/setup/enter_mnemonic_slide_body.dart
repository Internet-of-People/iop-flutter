import 'package:flutter/material.dart';
import 'package:iop_wallet/src/intro-slider/slide_object.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:iop_wallet/src/utils.dart';

class EnterMnemonicSlideBody extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool onNextPress() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  _EnterMnemonicSlideBodyState createState() => _EnterMnemonicSlideBodyState();
}

class _EnterMnemonicSlideBodyState extends State<EnterMnemonicSlideBody> {
  @override
  Widget build(BuildContext context) {
    return Slide(
      title: 'Unlock Your Vault',
      description:
          'Anybody with access to these 24 words can steal your identity. '
          'Write them down and store them in a secure location, '
          'in case you lose your device!',
      centerWidget: Column(
        children: [
          formattedIcon(Icons.account_balance),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildMnemonicForm(),
          )
        ],
      ),
      marginDescription: const EdgeInsets.all(15),
    );
  }

  Widget _buildMnemonicForm() {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter Your Mnemonic',
            labelStyle: textTheme.bodyText2,
          ),
          style: textTheme.bodyText1,
          validator: _mnemonicValidator,
        ),
      ]),
    );
  }

  String? _mnemonicValidator(String? mnemonic) {
    if (mnemonic == null) {
      return 'Mnemonic is required!';
    }
    if (mnemonic.length < 8) {
      return 'Mnemonic must be at least 8 characters long!';
    }
    return null;
  }
}
