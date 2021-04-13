import 'package:flutter/material.dart';

class NavigationContainer extends StatelessWidget {
  final List<Widget> _buttons;

  const NavigationContainer(this._buttons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buttons,
          ),
        ),
      ),
    );
  }
}
