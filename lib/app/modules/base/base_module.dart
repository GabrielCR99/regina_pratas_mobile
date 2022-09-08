import 'package:provider/provider.dart';

import '../../core/modules/app_routes_bindings_module.dart';
import 'base_controller.dart';
import 'base_page.dart';

class BaseModule extends AppRoutesBindingsModule {
  BaseModule()
      : super(
          routes: {
            '/home': (_) => const BasePage(),
          },
          bindings: [
            ChangeNotifierProvider(create: (_) => BaseController()),
          ],
        );
}
