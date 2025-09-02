class RequestListUrlModel {
  final String reporterClientId;

  const RequestListUrlModel({required this.reporterClientId});

  Map<String, String> toJson() {
    return {"reporter_client_id": reporterClientId};
  }
}
