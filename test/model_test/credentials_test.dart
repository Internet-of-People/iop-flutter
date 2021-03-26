import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';

// Mock out http client -> https://api.flutter.dev/flutter/dart-io/HttpOverrides-class.html
void main() {
  test('Credential Model', () {
    final _credentialStr =
        '{"name":"Hello","details":{"name":"john","age":22,"class":"mca"}}';
    final _credential = Credential.fromJson(jsonDecode(_credentialStr));
    expect(_credential.toString(), _credentialStr);
  });
}
