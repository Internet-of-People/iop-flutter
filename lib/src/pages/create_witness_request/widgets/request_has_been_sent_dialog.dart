import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';

class RequestHasBeenSentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: const <Widget>[Text('Sent')],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[Text('Your request has been sent.')],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              routeWelcome,
            );
          },
          style: TextButton.styleFrom(primary: themeData.primaryColor),
          child: const Text('BACK TO HOME'),
        ),
      ],
    );
  }
}
