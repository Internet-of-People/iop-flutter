import 'package:flutter/material.dart';

class PersonasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Personas')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: const Center(
          child: Text(
              'Coming Soon. At the moment, you will be using your default persona'),
        ),
      ),
    );
  }
}
