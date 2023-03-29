import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>?> getFavorite() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final myValue = prefs.getStringList('favorite');

  return myValue;
}
