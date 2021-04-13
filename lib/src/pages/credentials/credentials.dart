import 'package:flutter/material.dart';

import 'widgets/credential_list.dart';

class CredentialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Credentials')),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CredentialList(),
          ),
        )
      ]),
    );
  }
}
