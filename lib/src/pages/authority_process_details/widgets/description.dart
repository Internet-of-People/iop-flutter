import 'package:flutter/material.dart';
import 'package:iop_wallet/src/utils/nullable_text.dart';

class ProcessDescription extends StatelessWidget {
  final String _description;

  const ProcessDescription(this._description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subheadStyle = Theme.of(context).textTheme.subtitle1;
    final captionStyle = Theme.of(context).textTheme.caption;

    return Container(
      margin: const EdgeInsets.only(
          bottom: 8.0, top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [Text('Description', style: subheadStyle)],
          ),
          Row(children: <Widget>[
            Expanded(
              child: NullableText(
                text: _description,
                style: captionStyle,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
