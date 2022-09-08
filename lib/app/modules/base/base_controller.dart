import '../../core/notifier/default_change_notifier.dart';

class BaseController extends DefaultChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
