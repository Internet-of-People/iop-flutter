import 'package:flutter/material.dart';
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
    return Column(
      children: [
        formattedIcon(Icons.account_balance),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildMnemonicForm(),
        )
      ],
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
