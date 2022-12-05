import 'package:flutter/cupertino.dart';

class SearchClass extends ChangeNotifier {
  String searchWord = "";

  void updateSearchWord(String searchWord) {
    this.searchWord = searchWord;
    notifyListeners();
  }
}
