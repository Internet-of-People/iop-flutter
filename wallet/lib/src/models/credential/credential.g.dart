// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credential _$CredentialFromJson(Map<String, dynamic> json) {
  return Credential(
    ContentId.fromJson(json['processId'] as String),
    json['processName'] as String,
    json['sentAt'] as String,
    json['authorityUrl'] as String,
    CapabilityLink.fromJson(json['capabilityLink'] as String),
    _$enumDecodeNullable(_$StatusEnumMap, json['status']),
    json['witnessStatement'] == null
        ? null
        : Signed.fromJson(json['witnessStatement'] as Map<String, dynamic>),
    json['rejectionReason'] as String?,
  );
}

Map<String, dynamic> _$CredentialToJson(Credential instance) =>
    <String, dynamic>{
      'sentAt': instance.sentAt,
      'processId': instance.processId.toJson(),
      'processName': instance.processName,
      'authorityUrl': instance.authorityUrl,
      'capabilityLink': instance.capabilityLink.toJson(),
      'status': _$StatusEnumMap[instance.status],
      'witnessStatement': instance.witnessStatement?.toJson(),
      'rejectionReason': instance.rejectionReason,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$StatusEnumMap = {
  Status.pending: 'pending',
  Status.approved: 'approved',
  Status.rejected: 'rejected',
};
