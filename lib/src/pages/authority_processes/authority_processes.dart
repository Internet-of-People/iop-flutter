import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';

import 'widgets/process_list.dart';

class AuthorityProcessesPage extends StatefulWidget {
  final ApiConfig cfg;

  const AuthorityProcessesPage(this.cfg, {Key? key}) : super(key: key);

  @override
  _AuthorityProcessesPageState createState() => _AuthorityProcessesPageState();
}

class _AuthorityProcessesPageState extends State<AuthorityProcessesPage> {
  late Future<Map<ContentId, Process>>? _processesFut;

  @override
  void initState() {
    super.initState();
    _processesFut = _createProcessesFut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ContentId, Process>>(
      future: _processesFut,
      builder: (BuildContext context,
          AsyncSnapshot<Map<ContentId, Process>> snapshot) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Available Processes'),
          ),
          body: snapshot.hasData
              ? ProcessList(snapshot.data!, widget.cfg)
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<Map<ContentId, Process>>? _createProcessesFut() async {
    final api = AuthorityPublicApi(widget.cfg);
    final contentIds = await api.listProcesses();

    final resolver = ContentResolver<Process>((id) async {
      final blob = await api.getPublicBlob(id) as String;
      return Process.fromJson(json.decode(blob) as Map<String, dynamic>);
    });
    return resolver.resolveContentIds(contentIds);
  }
}
