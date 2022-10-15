import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/social/social_repository.dart';
import '../../repositories/social/social_repository_impl.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../services/user/user_service.dart';
import '../../services/user/user_service_impl.dart';
import '../core/core_module.dart';
import 'home/auth_home_page.dart';
import 'login/login_module.dart';
import 'register/register_module.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<SocialRepository>((_) => SocialRepositoryImpl()),
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryImpl(logger: i(), restClient: i(), auth: i()),
        ),
        Bind.lazySingleton<UserService>(
          (i) => UserServiceImpl(
            logger: i(),
            repository: i(),
            localStorage: i(),
            localSecureStorage: i(),
            socialRepository: i(),
          ),
        ),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const AuthHomePage()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
  ];
}
