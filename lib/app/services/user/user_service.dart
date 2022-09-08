import '../../models/social_login_type.dart';

abstract class UserService {
  const UserService();

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String document,
    required String password,
  });
  Future<void> login({required String email, required String password});
  Future<void> socialLogin(SocialLoginType type);
  Future<void> forgotPassword({required String email});
}
