import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Parses item.json over a network', () async {
    final res =
        await http.get(Uri.https('hydra.iop.global:4705', 'api/v2/blockchain'));
    late Map blockInfo;
    if (res.statusCode == 200) {
      blockInfo = json.decode(res.body) as Map;
    }
    assert(blockInfo.isNotEmpty, true);
  });
}
