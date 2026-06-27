enum AppRoutes {
  login(
    name: 'login',
    path: '/login',
  ),
  register(
    name: 'register',
    path: '/register',
  ),
  otp(
    name: 'otp',
    path: '/otp',
  ),
  forgotPassword(
    name: 'forgot_password',
    path: '/forgot_password',
  ),
  resetPassword(
    name: 'resetPassword',
    path: '/resetPassword',
  ),
  home(
    name: 'home',
    path: '/home',
  ),
  ;

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  @override
  String toString() => name;
}
