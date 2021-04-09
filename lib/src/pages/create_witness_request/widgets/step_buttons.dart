import 'package:flutter/material.dart';

class StepBackButton extends StatelessWidget {
  final String _text;
  final VoidCallback? _onPressed;

  const StepBackButton(
    this._text,
    this._onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 8.0),
      child: TextButton(
        onPressed: _onPressed,
        style: TextButton.styleFrom(primary: Colors.black54),
        child: Text(_text),
      ),
    );
  }
}

class StepContinueButton extends StatelessWidget {
  final String _text;
  final VoidCallback? _onPressed;

  const StepContinueButton(
    this._text,
    this._onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 8.0),
      child: TextButton(
        onPressed: _onPressed,
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: themeData.primaryColor,
        ),
        child: Text(_text),
      ),
    );
  }
}
