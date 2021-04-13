import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable(explicitToJson: true)
class Credential {
  Credential(
    this.processId,
    this.processName,
    this.sentAt,
    this.authorityUrl,
    this.capabilityLink,
    this.status,
    this.witnessStatement,
    this.rejectionReason,
  );

  String sentAt;
  ContentId processId;
  String processName;
  String authorityUrl;
  CapabilityLink capabilityLink;
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
