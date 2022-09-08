import 'package:provider/provider.dart';

import '../../core/modules/app_routes_bindings_module.dart';
import '../../repositories/social/social_repository.dart';
import '../../repositories/social/social_repository_impl.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../services/user/user_service.dart';
import '../../services/user/user_service_impl.dart';
import 'home/auth_home_page.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';

class AuthModule extends AppRoutesBindingsModule {
  AuthModule()
      : super(
          routes: {
            '/': (_) => const AuthHomePage(),
            '/login': (_) => const LoginPage(),
            '/register': (_) => const RegisterPage(),
          },
          bindings: [
            Provider<SocialRepository>(
              create: (context) => SocialRepositoryImpl(),
            ),
            Provider<UserRepository>(
              create: (context) => UserRepositoryImpl(
                restClient: context.read(),
                logger: context.read(),
                auth: context.read(),
              ),
            ),
            Provider<UserService>(
              create: (context) => UserServiceImpl(
                logger: context.read(),
                repository: context.read(),
                socialRepository: context.read(),
                localStorage: context.read(),
                localSecureStorage: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => LoginController(
                userService: context.read(),
                logger: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterController(service: context.read()),
            ),
          ],
        );
}
