class RequestUrlModel {
  final String transactionId;
  final double transactionAmount;
  final String transactionTime;
  final String? transactionDescription;
  final String reporterClientName;
  final String reporterClientId;
  final String contestedParticipantId;
  final String counterpartyClientName;
  final String counterpartyClientId;
  final String? counterpartyClientKey;
  final String? protocolId;
  final bool pixAuto;
  final String? clientId;
  final String? clientSince;
  final String? clientBirth;
  final bool autofraudRisk;
  final int? reporterBranchNumber;
  final int? reporterAccountNumber;

  const RequestUrlModel({
    required this.transactionId,
    required this.transactionAmount,
    required this.transactionTime,
    required this.reporterClientName,
    required this.reporterClientId,
    required this.contestedParticipantId,
    required this.counterpartyClientName,
    required this.counterpartyClientId,
    this.transactionDescription,
    this.reporterBranchNumber,
    this.reporterAccountNumber,
    this.counterpartyClientKey,
    this.protocolId,
    this.pixAuto = false,
    this.clientId,
    this.clientSince,
    this.clientBirth,
    this.autofraudRisk = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "transaction_id": transactionId,
      "transaction_amount": transactionAmount,
      "transaction_time": transactionTime,
      if (transactionDescription != null)
        "transaction_description": transactionDescription!,
      "reporter_client_name": reporterClientName,
      "reporter_client_id": reporterClientId,
      "contested_participant_id": contestedParticipantId,
      "counterparty_client_name": counterpartyClientName,
      "counterparty_client_id": counterpartyClientId,
      if (counterpartyClientKey != null)
        "counterparty_client_key": counterpartyClientKey!,
      if (protocolId != null) "protocol_id": protocolId!,
      "pix_auto": pixAuto,
      if (clientId != null) "client_id": clientId!,
      if (clientSince != null) "client_since": clientSince!,
      if (clientBirth != null) "client_birth": clientBirth!,
      "autofraud_risk": autofraudRisk,
      if (reporterBranchNumber != null)
        "reporter_branch_number": reporterBranchNumber!,
      if (reporterAccountNumber != null)
        "reporter_account_number": reporterAccountNumber!,
    };
  }
}
