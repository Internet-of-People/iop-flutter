import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iop_sdk/authority.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/models/process/process.dart';
import 'package:iop_wallet/src/pages/authority/processes_view.dart';

class AuthorityProcessesPage extends StatefulWidget {
  const AuthorityProcessesPage({required this.authorityUrl});
  final ApiConfig authorityUrl;

  @override
  _AuthorityProcessesPageState createState() => _AuthorityProcessesPageState();
}

class _AuthorityProcessesPageState extends State<AuthorityProcessesPage> {
  late Future<Map<String, Process>>? _processesFut;

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
            title: const Text('Available Processes'),
          ),
          body: snapshot.hasData
              ? ProcessListView(snapshot.data!)
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<Map<String, Process>>? _createProcessesFut() async {
    final api = AuthorityPublicApi(widget.authorityUrl);
    final contentIds = await api.listProcesses();

    final contentFutures = Map<ContentId, Future<dynamic>>.fromIterable(
        contentIds,
        value: (contentId) async => api.getPublicBlob(contentId as ContentId));

    final contents = await Future.wait(contentFutures.values);

    final Map<String, Process> contentIdContentMap = <String, Process>{};

    for (int i = 0; i < contents.length; i++) {
      final json = jsonDecode(contents[i].value.toString());
      contentIdContentMap[contentIds[i].toJson()] =
          Process.fromJson(json as Map<String, dynamic>);
    }
    return Future<Map<String, Process>>(() => contentIdContentMap);
  }
}
