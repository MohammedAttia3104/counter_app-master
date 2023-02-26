import 'package:shared_preferences/shared_preferences.dart';

class DataSource {
  final SharedPreferences prefs;

  DataSource(this.prefs);

//static init .....
  void setCounter(int counterValue) async {
    prefs.setInt('counter', counterValue);
  }

  int getCounter() {
    int counterValue = prefs.getInt('counter') ?? 0;
    return counterValue;
  }

  Future<bool> incrementValue() async {
    return prefs.setInt('counter', getCounter() + 1);
  }

  Future<bool> decrementValue() async {
    return prefs.setInt('counter', getCounter() - 1);
  }

  Future<bool> resetValue() async {
    return prefs.setInt('counter', 0);
  }
}
