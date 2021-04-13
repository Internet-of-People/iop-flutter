import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/widgets/description_column.dart';
import 'package:iop_wallet/src/widgets/version_column.dart';
import 'package:iop_wallet/src/pages/authority_process_details/widgets/schema_panel.dart';
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
  final JsonSchema? evidenceSchema;

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
  late Future<dynamic?> _fetchEvidenceSchemaFut;
  final _detailsInfoState = <int, bool>{
    0: false,
    1: false,
  };

  @override
  void initState() {
    super.initState();
    _authorityApi = AuthorityPublicApi(widget.args.authorityConfig);

    final resolver = ContentResolver((ContentId id) async {
      return _authorityApi.getPublicBlob(id);
    });

    _fetchClaimSchemaFut = resolver.resolve(widget.args.process.claimSchema);
    if (widget.args.process.evidenceSchema == null) {
      _fetchClaimSchemaFut = Future.value(null);
    } else {
      _fetchEvidenceSchemaFut = resolver.resolve(
        widget.args.process.evidenceSchema!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_fetchClaimSchemaFut, _fetchEvidenceSchemaFut]).then(
        (responses) => ResolvedSchemas(
          JsonSchema.createSchema(responses[0]),
          responses[1] == null ? null : JsonSchema.createSchema(responses[1]),
        ),
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
                  DescriptionColumn(widget.args.process.description),
                  VersionColumn(widget.args.process.version),
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
          label: const Text('Start Process'),
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
