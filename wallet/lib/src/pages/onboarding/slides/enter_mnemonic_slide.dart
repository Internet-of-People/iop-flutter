import 'package:flutter/material.dart';
import 'package:iop_wallet/src/theme.dart';

class EnterMnemonicSlide extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const EnterMnemonicSlide(this.formKey, this.controller);

  @override
  _EnterMnemonicSlideState createState() => _EnterMnemonicSlideState();
}

class _EnterMnemonicSlideState extends State<EnterMnemonicSlide> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        TextFormField(
          controller: widget.controller,
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
