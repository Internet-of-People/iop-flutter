import 'package:flutter/material.dart';

import 'did_selector.dart';

class Header extends StatefulWidget {
  final List<String>? dids = [
    'ezfNMujcQYRHVVeBJC65ihwG',
    'ezfic35cQYRHVVeBJC65kild'
  ];

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final header = <Widget>[
      const Expanded(
          child: Text('Your Profile',
              style: TextStyle(color: Colors.white, fontSize: 24)))
    ];

    if (widget.dids == null) {
      header.add(const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ));
    }
    return DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.zero,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(children: header),
          DidsDropdown(
            widget.dids,
            widget.dids![1],
            (did) {
              //TODO: ;
            },
          ),
        ]));
  }
}
