import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart' as v
    show FormFieldValidator, FieldValidator, RequiredValidator, MultiValidator;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iop_wallet/src/utils/schema_form/form_field_validators_extra.dart';
import 'package:json_schema2/json_schema2.dart';

const _subTypeKey = 'subtype';

abstract class _SubTypes {
  static const String date = 'date';
  static const String photo = 'photo';
  static const String email = 'email';
  static const String nonce = 'nonce';
  static const String contentId = 'contentId';
}

extension JsonSchemaExt on JsonSchema {
  bool isString() {
    return type == SchemaType.string && !schemaMap.containsKey(_subTypeKey);
  }

  bool isNumber() {
    return type == SchemaType.number;
  }

  bool isContentId() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.contentId;
  }

  bool isDate() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.date;
  }

  bool isEmail() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.email;
  }

  bool isNonce() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.nonce;
  }

  bool isPhoto() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.photo;
  }

  bool isObject() {
    return type == SchemaType.object;
  }

  v.FormFieldValidator? getValidators() {
    final validators = <v.FieldValidator>[];
    final debug = <String>[];

    if (parent != null && parent!.requiredProperties!.contains(propertyName)) {
      if (isString() || isDate() || isEmail() || isNonce()) {
        validators.add(v.RequiredValidator(errorText: 'Required'));
        debug.add('required');
      } else if (isPhoto()) {
        validators.add(NotNullOrEmptyValidator<File>(errorText: 'Required'));
        debug.add('required');
      } else {
        debugPrint(
          'Field $propertyName has a type $type, which has no required validator implemented. Schema: $this',
        );
      }
    }

    if (minLength != null) {
      validators.add(MinLengthValidator(
        minLength!,
        errorText: 'Min length is $minLength',
      ));
      debug.add('minLength');
    }

    if (maxLength != null) {
      validators.add(MaxLengthValidator(
        maxLength!,
        errorText: 'Max length is $maxLength',
      ));
      debug.add('maxLength');
    }

    final rangeValidator = _getNumericRangeValidator(this);
    if (rangeValidator != null) {
      validators.add(rangeValidator);
      debug.add('range');
    }

    if (pattern != null) {
      validators.add(PatternValidator(
        pattern!.pattern,
        errorText: 'Invalid pattern',
      ));
      debug.add('pattern');
    }

    // TODO
    /*_log.debug(
        '[Validation] ${propertyName} got validators attached: ${debug.join(', ')}');*/
    if(validators.isEmpty) {
      return null;
    }
    return v.MultiValidator(validators);
  }
}

FieldValidator? _getNumericRangeValidator(JsonSchema schema) {
  if (schema.minimum == null && schema.maximum == null) {
    return null;
  } else if (schema.minimum != null && schema.maximum == null) {
    return MinValidator(
      schema.minimum!,
      errorText: 'Must be greater than or equal to ${schema.minimum}',
    );
  } else if (schema.minimum == null && schema.maximum != null) {
    return MaxValidator(
      schema.maximum!,
      errorText: 'Must be less than or equal to ${schema.maximum}',
    );
  } else {
    return RangeValidator(
      min: schema.minimum!,
      max: schema.maximum!,
      errorText: 'Must be between ${schema.minimum} and ${schema.maximum}',
    );
  }
}
