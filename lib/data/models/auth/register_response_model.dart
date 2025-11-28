class RegisterResponseModel {
  final String sessionId;

  RegisterResponseModel({
    required this.sessionId,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      sessionId: json['sessionId'] as String? ?? json['session_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
    };
  }
}

