class RequestListUrlModel {
  final String reporterClientId;
  final int? reporterBranchNumber;
  final int? reporterAccountNumber;

  const RequestListUrlModel({
    required this.reporterClientId,
    this.reporterBranchNumber,
    this.reporterAccountNumber,
  });

  Map<String, String> toJson() {
    return {
      "reporter_client_id": reporterClientId,
      if (reporterBranchNumber != null)
        "reporter_branch_number": reporterBranchNumber!.toString(),
      if (reporterAccountNumber != null)
        "reporter_account_number": reporterAccountNumber!.toString(),
    };
  }
}
