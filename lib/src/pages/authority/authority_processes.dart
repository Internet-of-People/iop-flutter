import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iop_sdk/authority.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iop_sdk/entities.dart';
import 'package:iop_wallet/src/models/process/process.dart';
import 'package:iop_wallet/src/pages/authority/processes_view.dart';

class AuthorityProcessesPage extends StatefulWidget {
  AuthorityProcessesPage({required this.authorityUrl});
  final ApiConfig authorityUrl;

  @override
  _AuthorityProcessesPageState createState() => _AuthorityProcessesPageState();
}

class _AuthorityProcessesPageState extends State<AuthorityProcessesPage> {
  var _processesFut;

  @override
  void initState() {
    super.initState();
    _processesFut = _createProcessesFut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Process>>(
      future: _processesFut,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, Process>> snapshot) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Available Processes'),
          ),
          body: snapshot.hasData
              ? ProcessListView(snapshot.data!)
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<Map<String, Process?>> _createProcessesFut() async {
    final api = AuthorityPublicApi(widget.authorityUrl);
    final contentIds = await api.listProcesses();

    final contentFutures = Map.fromIterable(contentIds,
        value: (contentId) async => await api.getPublicBlob(contentId));
    final contents = await Future.wait(contentFutures.values);

    final contentIdContentMap = <String, Process?>{};
    for (var i = 0; i < contents.length; i++) {
      contentIdContentMap[contentIds[i].toJson()] =
          jsonToProcess(contents[i].value);
    }
    return contentIdContentMap;
  }
}
