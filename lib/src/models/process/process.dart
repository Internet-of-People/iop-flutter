import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:iop_wallet/src/models/serializers/serializers.dart';

part 'process.g.dart';

abstract class Process implements Built<Process, ProcessBuilder> {
  Process._();
  factory Process([void Function(ProcessBuilder) updates]) = _$Process;

  int get version;
  String get name;
  String get description;
  String get claimSchema;
  String get evidenceSchema;
  String? get constraintsSchema;

  static Serializer<Process> get serializer => _$processSerializer;
}

Process? jsonToProcess(String jsonProcess) {
  final parsed = jsonDecode(jsonProcess);
  final process = jsonSerializers.deserializeWith(Process.serializer, parsed);
  return process;
}
