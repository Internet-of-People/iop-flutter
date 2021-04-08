import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable(explicitToJson: true)
class Credential {
  Credential(
    this.sentAt,
    this.processName,
    this.capabilityUrl,
    this.status,
    this.witnessStatement,
    this.rejectionReason,
  );

  String sentAt;
  String processName;
  String capabilityUrl;
  Status? status;
  Signed<WitnessStatement>? witnessStatement;
  String? rejectionReason;

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialToJson(this);

  void approved(Signed<WitnessStatement> statement) {
    status = Status.approved;
    witnessStatement = statement;
  }

  void rejected(String reason){
    status = Status.rejected;
    rejectionReason = reason;
  }
}
