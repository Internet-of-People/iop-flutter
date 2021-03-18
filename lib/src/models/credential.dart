import 'dart:convert';

class CredentialModel {
  String? credentialName;
  Map<String, dynamic>? details;

  CredentialModel(String credentialName, Map<String, dynamic> detailsJson) {
    this.credentialName = credentialName;
    this.details = detailsJson;
  }

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
    return CredentialModel(credentialMap['name'], credentialMap['details']);
  }
}
