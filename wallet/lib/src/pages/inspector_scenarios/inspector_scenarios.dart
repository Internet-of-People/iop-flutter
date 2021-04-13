import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';

import 'widgets/scenarios_list.dart';

class InspectorScenariosPage extends StatefulWidget {
  final ApiConfig _cfg;

  const InspectorScenariosPage(this._cfg, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InspectorScenariosPageState();
}

class _InspectorScenariosPageState extends State<InspectorScenariosPage> {
  late Future<Map<ContentId, Scenario>> _scenariosFut;

  @override
  void initState() {
    super.initState();
    _scenariosFut = _createScenariosFut();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Map<ContentId, Scenario>>(
        future: _scenariosFut,
        builder: (
          BuildContext context,
          AsyncSnapshot<Map<ContentId, Scenario>> snapshot,
        ) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Available Scenarios'),
              ),
              body: snapshot.hasData
                  ? ScenariosList(widget._cfg, snapshot.data!)
                  : const Center(child: CircularProgressIndicator()));
        },
      );

  Future<Map<ContentId, Scenario>> _createScenariosFut() async {
    final api = InspectorPublicApi(widget._cfg);
    final contentIds = await api.listScenarios();

    final resolver = ContentResolver<Scenario>((id) async {
      final blob = await api.getPublicBlob(id) as String;
      return Scenario.fromJson(json.decode(blob) as Map<String, dynamic>);
    });
    return resolver.resolveContentIds(contentIds);
  }
}
