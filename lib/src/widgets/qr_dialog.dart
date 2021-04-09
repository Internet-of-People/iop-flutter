import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDialog extends StatelessWidget {
  const QrDialog(this.title, this.data);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: SizedBox(
        width: 250,
        height: 300,
        child: Column(
          children: [
            QrImage(data: data),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK')),
          ],
        ),
      ),
    );
  }
}
