import 'package:flutter/material.dart';

class ProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Profiles')),
      body: const Center(
        child: Text('Profiles'),
      ),
    );
  }
}
