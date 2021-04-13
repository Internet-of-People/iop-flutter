import 'package:flutter/material.dart';
import 'package:iop_wallet/src/theme.dart';

class PasswordSlide extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const PasswordSlide(this.formKey, this.controller);

  @override
  _PasswordSlideState createState() => _PasswordSlideState();
}

class _PasswordSlideState extends State<PasswordSlide> {
  bool _validationStarted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(child: _buildPasswordForm(true)),
        ),
      ],
    );
  }

  Widget _buildPasswordForm(bool obscured) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        TextFormField(
          controller: widget.controller,
          obscureText: true,
          onChanged: (_) {
            if(_validationStarted) {
              widget.formKey.currentState!.validate();
            }
          },
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: appTheme.primaryColorLight,
            ),
            labelText: 'Enter Your Password',
            labelStyle: textTheme.bodyText2,
          ),
          style: textTheme.bodyText1,
          validator: _passwordValidator,
        ),
      ]),
    );
  }

  String? _passwordValidator(String? password) {
    _validationStarted = true;

    if (password == null) {
      return 'Password is required!';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long!';
    }
    return null;
  }
}
