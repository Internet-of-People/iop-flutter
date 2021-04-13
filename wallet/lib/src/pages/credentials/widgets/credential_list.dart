import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:iop_wallet/src/utils/log.dart';
import 'package:iop_wallet/src/utils/status_utils.dart';
import 'package:provider/provider.dart';

export 'credential_list.dart';

class CredentialList extends StatefulWidget {
  @override
  _CredentialListState createState() => _CredentialListState();
}

final _log = Log(CredentialList);

class _CredentialListState extends State<CredentialList> {
  late WalletModel wallet;
  late Future<void> _updateCredentialsFut;

  @override
  void initState() {
    super.initState();
    _updateCredentialsFut = _updateCredentials();
  }

  @override
  Widget build(BuildContext context) {
    wallet = context.watch<WalletModel>();
    return FutureBuilder(
      future: _updateCredentialsFut,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return (wallet.credentials.isEmpty)
              ? _buildEmptyList()
              : _buildList();
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: wallet.credentials.length,
            itemBuilder: (context, index) => _buildItem(context, index),
          ),
        ),
        FloatingActionButton(
          onPressed: () async => _updateCredentials(),
          child: const Icon(Icons.refresh),
        )
      ],
    );
  }

  Widget _buildEmptyList() {
    return Column(
      children: [
        Center(
          child: Text(
            'You have no credentials in your wallet.',
            style: textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final credential = wallet.credentials[index];
    return Column(
      children: [
        const Divider(height: 4),
        ListTile(
          leading: _buildLeadingIcon(credential.status!),
          title: Text(credential.processName),
          subtitle: Text(credential.sentAt),
          onTap: () async {
            Navigator.pushNamed(
              context,
              routeCredentialDetails,
              arguments: wallet.credentials[index],
            );
          },
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildRemoveDialog(context, credential),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _updateCredentials() async {
    final credentialsPending =
        wallet.credentials.where((c) => c.status == Status.pending).toList();

    final futures = credentialsPending.map((c) async {
      final uri = Uri.parse(c.authorityUrl);
      final host = '${uri.scheme}://${uri.host}';
      final port = uri.port;

      final config = ApiConfig(host, port);
      final api = AuthorityPublicApi(config);
      final requestResp = await api.getRequestStatus(c.capabilityLink);

      if (requestResp == null) {
        _log.error('Could not update credentials');
        return;
      }

      if (requestResp.status == Status.approved) {
        c.approved(requestResp.signedStatement!);
      } else if (requestResp.status == Status.rejected) {
        c.rejected(requestResp.rejectionReason!);
      }

      return;
    }).toList();

    await Future.wait(futures);
    wallet.save();
  }

  Widget _buildLeadingIcon(Status status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StatusUtils.buildIcon(status),
    );
  }

  Widget _buildRemoveDialog(BuildContext context, Credential credential) {
    return AlertDialog(
      title: const Text('Remove Credential'),
      content: const Text('Are you sure to delete your credential? '),
      actions: <TextButton>[
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
        TextButton(
            onPressed: () {
              wallet.remove(credential);
              Navigator.pop(context);
            },
            child: const Text('Yes')),
      ],
    );
  }
}
