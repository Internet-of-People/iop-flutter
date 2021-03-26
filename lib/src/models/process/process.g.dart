// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Process _$ProcessFromJson(Map<String, dynamic> json) {
  return Process(
    json['version'] as int,
    json['name'] as String,
    json['description'] as String,
    json['claimSchema'] as String,
    json['evidenceSchema'] as String,
    json['constraintsSchema'] as String?,
  );
}

Map<String, dynamic> _$ProcessToJson(Process instance) => <String, dynamic>{
      'version': instance.version,
      'name': instance.name,
      'description': instance.description,
      'claimSchema': instance.claimSchema,
      'evidenceSchema': instance.evidenceSchema,
      'constraintsSchema': instance.constraintsSchema,
    };
