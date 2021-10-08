import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiSupportProvider extends ChangeNotifier {
  int _questionIndex = 0;
  late PageController _controller;

  void setQuestionIndex(int index) {
    _questionIndex = index;
    showPage(_questionIndex);
    notifyListeners();
  }

  void nextQuestion() {
    _questionIndex = _questionIndex + 1;
    showPage(_questionIndex);
    notifyListeners();
  }

  void setController() {
    _questionIndex = 0;
    final controller = PageController(initialPage: _questionIndex);
    _controller = controller;
  }

  void showPage(int index) {
    _controller.animateToPage(index,
        curve: Curves.easeInOut, duration: Duration(milliseconds: 500));
  }

  int get selectedMenuIndex => _questionIndex;
  PageController get pageController => _controller;
}
