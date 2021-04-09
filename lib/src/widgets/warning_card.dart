import 'package:flutter/material.dart';

class WarningCard extends StatelessWidget {
  final String _message;

  const WarningCard(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Row(children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const Icon(
              Icons.warning,
              color: Colors.deepOrange,
            ),
          ),
          Expanded(child: Text(_message))
        ]),
      ),
    );
  }
}
