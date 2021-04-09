import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:iop_sdk/authority.dart';
import 'package:iop_wallet/src/utils/nullable_text.dart';
import 'package:iop_wallet/src/utils/schema_form/map_as_table.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/utils/status_utils.dart';
import 'package:iop_wallet/src/widgets/qr_dialog.dart';

class CredentialDetails extends StatelessWidget {
  const CredentialDetails(this._credential, {Key? key}) : super(key: key);

  final Credential _credential;
  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(context);

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

  List<Widget> _buildSections(BuildContext context) {
    final sections = <Widget>[
      _buildStatusSection(context, _credential.status!),
    ];

    if (_credential.status == Status.approved) {
      sections.add(_buildStatementSection());
      sections.add(_buildSignatureSection(context));
    }

    if (_credential.status == Status.pending) {
      sections.add(_buildMetaSection());
    }

    if (_credential.status == Status.rejected &&
        _credential.rejectionReason != null) {
      sections.add(_buildRejectionSection(context));
    }
    return sections;
  }

  Widget _buildStatusSection(BuildContext context, Status _status) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: StatusUtils.buildIcon(_status),
                ),
                Text(
                  StatusUtils.asText(_status),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatementSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MapAsTable(
        _credential.witnessStatement!.content.toJson() as Map<String, dynamic>,
        'Statement',
      ),
    );
  }

  Widget _buildMetaSection() {
    return Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: MapAsTable(_credential.toJson(), 'Meta'));
  }

  Widget _buildSignatureSection(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => QrDialog(
              'Credential Signature',
              _credential.witnessStatement!.signature.toString(),
            ),
          ),
        ),
        child: const Text('Signature'),
      ),
    );
  }

  Widget _buildRejectionSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Reason',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: NullableText(text: _credential.rejectionReason),
          ),
        ],
      ),
    );
  }
}
