import 'dart:convert';

class CredentialModel {
  final String credentialName;
  final Map<String, dynamic> details;

  CredentialModel({required this.credentialName, required this.details});

  @override
  String toString() {
    final credentialJson = {
      'name': credentialName,
      'details': details,
    };
    return jsonEncode(credentialJson);
  }

  static CredentialModel fromString(String str) {
    final credentialMap = jsonDecode(str);
    return CredentialModel(
        credentialName: credentialMap['name'],
        details: credentialMap['details']);
  }
}
