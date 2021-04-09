import 'package:flutter/material.dart';

class ProcessVersion extends StatelessWidget {
  final int _version;

  const ProcessVersion(this._version, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subheadStyle = Theme.of(context).textTheme.subtitle1;
    final captionStyle = Theme.of(context).textTheme.caption;

    return Container(
      margin: const EdgeInsets.only(
          bottom: 8.0, top: 8.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Text('Version', style: subheadStyle),
          ]),
          Row(children: <Widget>[
            Expanded(
              child: Text(
                _version.toString(),
                style: captionStyle,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
