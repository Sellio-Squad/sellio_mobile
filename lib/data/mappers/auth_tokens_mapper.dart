import '../../domain/entities/auth_tokens.dart';
import '../models/auth/auth_tokens_response_model.dart';

extension AuthTokensResponseModelMapper on AuthTokensResponseModel {
  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

