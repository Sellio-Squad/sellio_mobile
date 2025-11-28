import '../user_model.dart';

class AuthTokensResponseModel {
  final String accessToken;
  final String refreshToken;
  final UserModel? user;

  AuthTokensResponseModel({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  factory AuthTokensResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensResponseModel(
      accessToken: json['accessToken'] as String? ?? 
                   json['access_token'] as String? ?? 
                   json['token'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? 
                    json['refresh_token'] as String? ?? '',
      user: json['user'] != null 
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      if (user != null) 'user': user!.toJson(),
    };
  }
}

