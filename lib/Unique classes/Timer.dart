import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends ChangeNotifier {
  int currentValue = 5;
  int counter = 0;
  int minutes = 5;
  int seconds = 0;
  late Timer _timer;
  bool notSet = true;

  void StartTimer(int Counter) {
    if (notSet) {
      counter = minutes * 60;
      minutes = Counter;
      notSet = false;
      notifyListeners();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        if (seconds <= 60) {
          seconds--;
          counter--;
        }
        if (seconds <= 0) {
          seconds = 59;
          minutes--;
        }
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
    notifyListeners();
  }

  void pauseTimer() {
    _timer.cancel();
    notifyListeners();
  }

  void ResetTimer(int Counter) {
    _timer.cancel();
    notSet = true;
    counter = Counter;
    minutes = Counter;
    seconds = 0;
    notifyListeners();
  }
}
