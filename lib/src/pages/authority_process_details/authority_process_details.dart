import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/pages/authority_process_details/widgets/description.dart';
import 'package:iop_wallet/src/pages/authority_process_details/widgets/schema_panel.dart';
import 'package:iop_wallet/src/pages/authority_process_details/widgets/version.dart';
import 'package:iop_wallet/src/pages/create_witness_request/create_witness_request.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:json_schema2/json_schema2.dart';

class AuthorityProcessDetailsArgs {
  final ContentId contentId;
  final Process process;
  final ApiConfig authorityConfig;

  AuthorityProcessDetailsArgs(
    this.contentId,
    this.process,
    this.authorityConfig,
  );
}

class ResolvedSchemas {
  final JsonSchema claimSchema;
  final JsonSchema evidenceSchema;

  ResolvedSchemas(this.claimSchema, this.evidenceSchema);
}

class AuthorityProcessDetailsPage extends StatefulWidget {
  final AuthorityProcessDetailsArgs args;

  const AuthorityProcessDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  _AuthorityProcessDetailsPageState createState() =>
      _AuthorityProcessDetailsPageState();
}

class _AuthorityProcessDetailsPageState
    extends State<AuthorityProcessDetailsPage> {
  late AuthorityPublicApi _authorityApi;
  late Future<dynamic> _fetchClaimSchemaFut;
  late Future<dynamic> _fetchEvidenceSchemaFut;
  final _detailsInfoState = <int, bool>{
    0: false,
    1: false,
  };

  @override
  void initState() {
    super.initState();
    _authorityApi = AuthorityPublicApi(widget.args.authorityConfig);

    // TODO: later we need something in the SDK, an extended ContentResolver
    // which eats both ContentId and Content<DynamicContent>. Until then,
    // we expect contentId's in these schemas.
    _fetchClaimSchemaFut =
        _authorityApi.getPublicBlob(widget.args.process.claimSchema.contentId!);
    _fetchEvidenceSchemaFut = _authorityApi
        .getPublicBlob(widget.args.process.evidenceSchema!.contentId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_fetchClaimSchemaFut, _fetchEvidenceSchemaFut]).then(
        (responses) => ResolvedSchemas(JsonSchema.createSchema(responses[0]),
            JsonSchema.createSchema(responses[1])),
      ),
      builder: (BuildContext context, AsyncSnapshot<ResolvedSchemas> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.args.process.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ProcessDescription(widget.args.process.description),
                  ProcessVersion(widget.args.process.version),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: ExpansionPanelList(
                      expansionCallback: (index, isExpanded) {
                        setState(() {
                          _detailsInfoState[index] = !isExpanded;
                          _detailsInfoState[(index - 1).abs()] =
                              false; // yes, hacky. Closes the other one
                        });
                      },
                      children: <ExpansionPanel>[
                        SchemaPanel.build(
                          _getClaimSchema(snapshot),
                          'Required Personal Information',
                          _detailsInfoState[0]!,
                        ),
                        SchemaPanel.build(
                          _getEvidenceSchema(snapshot),
                          'Required Evidence',
                          _detailsInfoState[1]!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: _buildButton(snapshot));
      },
    );
  }

  FloatingActionButton _buildButton(AsyncSnapshot<ResolvedSchemas> snapshot) {
    if (snapshot.hasData) {
      return FloatingActionButton.extended(
          label: const Text('Create Witness Request'),
          icon: const Icon(Icons.assignment),
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              routeAuthorityCreateWitnessRequest,
              arguments: CreateWitnessRequestArgs(
                widget.args.process.name,
                widget.args.contentId,
                snapshot.data!.claimSchema,
                snapshot.data!.evidenceSchema,
                widget.args.authorityConfig,
              ),
            );
          });
    }

    return FloatingActionButton.extended(
      label: const Text('Loading...'),
      icon: const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      ),
      onPressed: () {},
    );
  }

  JsonSchema? _getClaimSchema(AsyncSnapshot<ResolvedSchemas> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data!.claimSchema;
    }

    return null;
  }

  JsonSchema? _getEvidenceSchema(AsyncSnapshot<ResolvedSchemas> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data!.evidenceSchema;
    }

    return null;
  }
}
