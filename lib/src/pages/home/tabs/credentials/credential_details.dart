import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_wallet/src/utils/schema_form/map_as_table.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/utils/status_utils.dart';

class CredentialDetails extends StatelessWidget {
  const CredentialDetails(this._credential, {Key? key}) : super(key: key);

  final Credential _credential;

  @override
  Widget build(BuildContext context) {
    final sections = <Widget>[
      _buildStatusSection(context, _credential.status!),
    ];

    if (_credential.status == Status.approved) {
      sections.add(_buildStatementSection());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_credential.processName),
      ),
      body: SingleChildScrollView(
        child: Column(children: sections),
      ),
    );
  }

  Widget _buildStatusSection(BuildContext context, Status _status) {
    final info = <Widget>[];

    info.add(Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: StatusUtils.buildIcon(_status),
      ),
      Expanded(
        child: Text(
          StatusUtils.asText(_status),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    ]));

    if (_status == Status.rejected && _credential.rejectionReason != null) {
      info.add(Row(children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text('Reason: ${_credential.rejectionReason}'),
        )
      ]));
    }

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: info),
      ),
    );
  }

  Widget _buildStatementSection() {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MapAsTable(
          _credential.witnessStatement!.toJson(),
          'Statement',
        ),
      ),
    );
  }
}
