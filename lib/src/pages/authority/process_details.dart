import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/nullable_text.dart';
import 'package:iop_wallet/src/pages/authority/create_witness_request.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:json_schema2/json_schema2.dart';

class ProcessDetailsArgs {
  final ContentId contentId;
  final Process process;
  final ApiConfig authorityConfig;

  ProcessDetailsArgs(this.contentId, this.process, this.authorityConfig);
}

class ResolvedSchemas {
  final JsonSchema claimSchema;
  final JsonSchema evidenceSchema;

  ResolvedSchemas(this.claimSchema, this.evidenceSchema);
}

class ProcessDetails extends StatefulWidget {
  final ProcessDetailsArgs args;

  const ProcessDetails(this.args, {Key? key}) : super(key: key);

  @override
  _ProcessDetailsState createState() => _ProcessDetailsState();
}

class _ProcessDetailsState extends State<ProcessDetails> {
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
        final subheadStyle = Theme.of(context).textTheme.subtitle1;
        final captionStyle = Theme.of(context).textTheme.caption;

        return Scaffold(
            appBar: AppBar(
              title: Text(widget.args.process.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
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
                              text: widget.args.process.description,
                              style: captionStyle,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                  Container(
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
                              widget.args.process.version.toString(),
                              style: captionStyle,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
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
                        _buildClaimPanel(snapshot),
                        _buildEvidencePanel(snapshot),
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

  ExpansionPanel _buildClaimPanel(AsyncSnapshot<ResolvedSchemas> snapshot) {
    var claimDetails = <Widget>[];
    var title = 'Loading...';

    if (snapshot.hasData) {
      final schema = snapshot.data!.claimSchema;
      final requiredData = schema.requiredProperties == null
          ? '-'
          : schema.requiredProperties!.join(', ');
      claimDetails = [
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Description'),
              subtitle: NullableText(text: schema.description),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Required Data'),
              subtitle: NullableText(text: requiredData),
            )
          ],
        )
      ];

      title = 'Required Personal Information';
    }

    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
        body: Column(children: claimDetails),
        isExpanded: _detailsInfoState[0]!);
  }

  ExpansionPanel _buildEvidencePanel(AsyncSnapshot<ResolvedSchemas> snapshot) {
    var evidenceDetails = <Widget>[];
    var title = 'Loading...';

    if (snapshot.hasData) {
      final schema = snapshot.data!.evidenceSchema;
      final requiredData = schema.requiredProperties == null
          ? '-'
          : schema.requiredProperties!.join(', ');
      evidenceDetails = <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Description'),
              subtitle: NullableText(text: schema.description),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ListTile(
                title: const Text('Required Data'),
                subtitle: NullableText(text: requiredData))
          ],
        )
      ];
      title = 'Required Evidence';
    }

    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
        body: Column(children: evidenceDetails),
        isExpanded: _detailsInfoState[1]!);
  }
}
