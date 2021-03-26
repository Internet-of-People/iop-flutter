import 'package:json_annotation/json_annotation.dart';

part 'process.g.dart';

@JsonSerializable()
class Process {
  Process(this.version, this.name, this.description, this.claimSchema,
      this.evidenceSchema, this.constraintsSchema);

  factory Process.fromJson(Map<String, dynamic> json) =>
      _$ProcessFromJson(json);
  Map<String, dynamic> toJson() => _$ProcessToJson(this);

  int version;
  String name;
  String description;
  String claimSchema;
  String evidenceSchema;
  String? constraintsSchema;
}
