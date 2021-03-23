// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Process> _$processSerializer = new _$ProcessSerializer();

class _$ProcessSerializer implements StructuredSerializer<Process> {
  @override
  final Iterable<Type> types = const [Process, _$Process];
  @override
  final String wireName = 'Process';

  @override
  Iterable<Object?> serialize(Serializers serializers, Process object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'version',
      serializers.serialize(object.version, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'claimSchema',
      serializers.serialize(object.claimSchema,
          specifiedType: const FullType(String)),
      'evidenceSchema',
      serializers.serialize(object.evidenceSchema,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.constraintsSchema;
    if (value != null) {
      result
        ..add('constraintsSchema')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Process deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProcessBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'version':
          result.version = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'claimSchema':
          result.claimSchema = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'evidenceSchema':
          result.evidenceSchema = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'constraintsSchema':
          result.constraintsSchema = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Process extends Process {
  @override
  final int version;
  @override
  final String name;
  @override
  final String description;
  @override
  final String claimSchema;
  @override
  final String evidenceSchema;
  @override
  final String? constraintsSchema;

  factory _$Process([void Function(ProcessBuilder)? updates]) =>
      (new ProcessBuilder()..update(updates)).build();

  _$Process._(
      {required this.version,
      required this.name,
      required this.description,
      required this.claimSchema,
      required this.evidenceSchema,
      this.constraintsSchema})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(version, 'Process', 'version');
    BuiltValueNullFieldError.checkNotNull(name, 'Process', 'name');
    BuiltValueNullFieldError.checkNotNull(
        description, 'Process', 'description');
    BuiltValueNullFieldError.checkNotNull(
        claimSchema, 'Process', 'claimSchema');
    BuiltValueNullFieldError.checkNotNull(
        evidenceSchema, 'Process', 'evidenceSchema');
  }

  @override
  Process rebuild(void Function(ProcessBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProcessBuilder toBuilder() => new ProcessBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Process &&
        version == other.version &&
        name == other.name &&
        description == other.description &&
        claimSchema == other.claimSchema &&
        evidenceSchema == other.evidenceSchema &&
        constraintsSchema == other.constraintsSchema;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, version.hashCode), name.hashCode),
                    description.hashCode),
                claimSchema.hashCode),
            evidenceSchema.hashCode),
        constraintsSchema.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Process')
          ..add('version', version)
          ..add('name', name)
          ..add('description', description)
          ..add('claimSchema', claimSchema)
          ..add('evidenceSchema', evidenceSchema)
          ..add('constraintsSchema', constraintsSchema))
        .toString();
  }
}

class ProcessBuilder implements Builder<Process, ProcessBuilder> {
  _$Process? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _claimSchema;
  String? get claimSchema => _$this._claimSchema;
  set claimSchema(String? claimSchema) => _$this._claimSchema = claimSchema;

  String? _evidenceSchema;
  String? get evidenceSchema => _$this._evidenceSchema;
  set evidenceSchema(String? evidenceSchema) =>
      _$this._evidenceSchema = evidenceSchema;

  String? _constraintsSchema;
  String? get constraintsSchema => _$this._constraintsSchema;
  set constraintsSchema(String? constraintsSchema) =>
      _$this._constraintsSchema = constraintsSchema;

  ProcessBuilder();

  ProcessBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _name = $v.name;
      _description = $v.description;
      _claimSchema = $v.claimSchema;
      _evidenceSchema = $v.evidenceSchema;
      _constraintsSchema = $v.constraintsSchema;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Process other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Process;
  }

  @override
  void update(void Function(ProcessBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Process build() {
    final _$result = _$v ??
        new _$Process._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, 'Process', 'version'),
            name:
                BuiltValueNullFieldError.checkNotNull(name, 'Process', 'name'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, 'Process', 'description'),
            claimSchema: BuiltValueNullFieldError.checkNotNull(
                claimSchema, 'Process', 'claimSchema'),
            evidenceSchema: BuiltValueNullFieldError.checkNotNull(
                evidenceSchema, 'Process', 'evidenceSchema'),
            constraintsSchema: constraintsSchema);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
