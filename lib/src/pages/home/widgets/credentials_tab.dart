import 'package:flutter/material.dart';

import 'widgets/credential_list.dart';

class CredentialsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
