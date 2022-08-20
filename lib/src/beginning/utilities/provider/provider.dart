// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:phoenix/src/beginning/pages/settings/settings.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

bool usingSeek = false;

//TODO use proper class names for heaven's sake

class Leprovider with ChangeNotifier {
  provideman() {
    notifyListeners();
  }

  changeLoop(bool w) {
    loopSelected = w;
    notifyListeners();
  }

  changeShuffle(bool w) {
    shuffleSelected = w;
    notifyListeners();
  }
}

class MrMan with ChangeNotifier {
  int rotate = 0;

  rotator(update) {
    rotate = update;
    if (!breakRotate) {
      notifyListeners();
    }
  }

  rawNotify() {
    notifyListeners();
  }
}

class Seek with ChangeNotifier {
  double time = 00.0;
  incrementTime(double sent) {
    if (!usingSeek) {
      time = sent;
      notifyListeners();
    }
  }

  seekIncrementTime(double sent) {
    time = sent;
    notifyListeners();
  }
}

class Astronautintheocean with ChangeNotifier {
  List searchen = [];
  thesearch(astranau) {
    searchen = astranau;
    notifyListeners();
  }

  rawNotify() {
    notifyListeners();
  }
}

class SortProvider with ChangeNotifier {
  notify() {
    notifyListeners();
  }
}
