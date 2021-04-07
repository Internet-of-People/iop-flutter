import 'package:form_field_validator/form_field_validator.dart';

class MinValidator extends TextFieldValidator {
  final num min;

  MinValidator(this.min, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) return false;

    try {
      return num.parse(value) >= min;
    } catch (_) {
      return false;
    }
  }
}

class MaxValidator extends TextFieldValidator {
  final num max;

  MaxValidator(this.max, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) return false;

    try {
      return num.parse(value) <= max;
    } catch (_) {
      return false;
    }
  }
}

class NotNullOrEmptyValidator<T> extends FieldValidator<T> {
  NotNullOrEmptyValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(T value) {
    return value != null;
  }

  @override
  String? call(T value) {
    return isValid(value) ? '' : errorText;
  }
}
