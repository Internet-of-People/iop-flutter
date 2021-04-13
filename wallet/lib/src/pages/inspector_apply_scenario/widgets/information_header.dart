import 'package:flutter/material.dart';

class InformationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Row(children: [
            Expanded(
              child: Text(
                'Information',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Row(children: const [
            Expanded(
              child: Text('''You are about to share a subset of your data that is enough to apply this scenario.'''),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Row(children: const [
            Expanded(
              child: Text(
                'Only the data shown below will be shared.',
              ),
            )
          ]),
        ),
      ],
    );
  }
}
