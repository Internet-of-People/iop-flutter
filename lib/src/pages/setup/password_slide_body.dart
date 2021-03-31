import 'package:flutter/material.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:iop_wallet/src/utils.dart';

class PasswordSlideBody extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _PasswordSlideBodyState createState() => _PasswordSlideBodyState();
}

class _PasswordSlideBodyState extends State<PasswordSlideBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formattedIcon(Icons.security),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
              child: _buildPasswordForm('Enter your password here', true)),
        ),
      ],
    );
  }

  Widget _buildPasswordForm(String hintText, bool obscured) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: appTheme.primaryColorLight,
            ),
            labelText: 'Enter Your Password',
            labelStyle: textTheme.bodyText2,
          ),
          style: textTheme.bodyText1,
          validator: passwordValidator,
        ),
      ]),
    );
  }

  static String? passwordValidator(String? password) {
    if (password == null) {
      return 'Password is required!';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long!';
    }
    return null;
  }
}
