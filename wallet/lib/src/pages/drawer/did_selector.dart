import 'package:flutter/material.dart';
import 'package:iop_wallet/src/theme.dart';

typedef OnDidSelected = void Function(String? newValue);

class DidsSelectorContext {
  String activeDid;
  void Function(String newActiveDid) dispatch;

  DidsSelectorContext(this.activeDid, this.dispatch);

  void setActiveDid(String newActiveDid) {
    activeDid = newActiveDid;
    dispatch(newActiveDid);
  }
}

class DidsDropdown extends StatelessWidget {
  final List<String>? _dids;
  final String _activeDid;
  final OnDidSelected _onChanged;

  const DidsDropdown(this._dids, this._activeDid, this._onChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    if (_dids != null) {
      children = <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton<String>(
            value: _activeDid,
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            underline: Container(height: 0),
            onChanged: _onChanged,
            items: _dids?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, overflow: TextOverflow.fade),
              );
            }).toList(),
          ),
        )
      ];
    }

    return Column(mainAxisSize: MainAxisSize.min, children: children);
  }
}
