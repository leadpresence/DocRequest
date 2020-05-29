import 'package:flutter/foundation.dart';
import 'package:mobiledoc/ui/viewmodels/base_model.dart';

class WalkthroughProvider extends BaseModel {
  int _currentPage = 0;
  void onPageChange(int newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  int get currentPageValue => _currentPage;
}
