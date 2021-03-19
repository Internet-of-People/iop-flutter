import 'dart:convert';

class CredentialModel {
  CredentialModel({required this.credentialName, required this.details});

  final String credentialName;
  final Map<String, dynamic> details;

  @override
  String toString() {
    final credentialJson = <String, dynamic>{
      'name': credentialName,
      'details': details,
    };
    return jsonEncode(credentialJson);
  }

  static CredentialModel fromString(String str) {
    final Map<String, dynamic> credentialMap = jsonDecode(str);
    return CredentialModel(
        credentialName: credentialMap['name'],
        details: credentialMap['details']);
  }
}
