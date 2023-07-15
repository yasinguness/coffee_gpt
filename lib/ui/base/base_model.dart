import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  late BuildContext context; // BuildContext özelliği

  void setContext(BuildContext context) {
    this.context = context;
  }

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
