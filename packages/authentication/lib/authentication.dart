library authentication;

// DI
export 'core/di/auth_di.dart';

// Domain
export 'domain/entities/user.dart';
export 'domain/entities/address.dart';
export 'domain/repositories/auth_repository.dart';
export 'domain/repositories/user_repository.dart';

// Data
export 'data/datasource/remote/auth_endpoints.dart';

// Presentation - Cubits
export 'presentation/cubits/auth/authentication_cubit.dart';
export 'presentation/cubits/auth/authentication_state.dart';
export 'presentation/screens/login/cubit/login_cubit.dart';
export 'presentation/screens/login/cubit/login_state.dart';
export 'presentation/screens/create_account/cubit/registration_cubit.dart';
export 'presentation/screens/create_account/cubit/registration_state.dart';
export 'presentation/screens/forgot_password/cubit/forgot_password_cubit.dart';
export 'presentation/screens/forgot_password/cubit/forgot_password_state.dart';
export 'presentation/shared/otp/cubit/otp_cubit.dart';
export 'presentation/shared/otp/cubit/otp_state.dart';

// Presentation - Screens
export 'presentation/screens/login/login_screen.dart';
export 'presentation/screens/create_account/create_account_screen.dart';
export 'presentation/screens/forgot_password/forgot_password_screen.dart';
export 'presentation/screens/forgot_password/reset_password_screen.dart';
export 'presentation/shared/otp/otp_screen.dart';

// Navigation
export 'presentation/navigation/auth_navigator.dart';

// Localization
export 'core/localization/auth_localization_service.dart';
export 'l10n/auth_localizations.dart';
