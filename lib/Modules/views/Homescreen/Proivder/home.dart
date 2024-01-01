import 'package:flutter/cupertino.dart';
import 'package:mirror_wall_flutter_project/Modules/views/Homescreen/Model/home.dart';

class WebProvider extends ChangeNotifier {
  static String linkpath = "https://www.google.com/";
  WebModel webModel = WebModel(webLink: linkpath);

  void DuckDuckGo() {
    linkpath = "https://duckduckgo.com/";
    notifyListeners();
  }

  void Bing() {
    linkpath = "https://www.bing.com/";
    notifyListeners();
  }

  void Yahoo() {
    linkpath = "https://in.search.yahoo.com/?fr2=inr";
    notifyListeners();
  }
}
