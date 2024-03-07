import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Obtain SharedPreferences instance
  Future<SharedPreferences> _getInstance() async => await SharedPreferences.getInstance();

  // Create/Save (setString)
  Future<bool> setString(String key, String value) async {
    final prefs = await _getInstance();
    return prefs.setString(key, value);
  }

  // Read (getString)
  Future<String?> getString(String key) async {
    final prefs = await _getInstance();
    return prefs.getString(key);
  }

  // Update (setString - since it overwrites)
  Future<bool> updateString(String key, String value) async {
    return setString(key, value);
  }

  // Delete
  Future<bool> remove(String key) async {
    final prefs = await _getInstance();
    return prefs.remove(key);
  }

  // Additional methods (for other data types)
  Future<bool> setInt(String key, int value) async {
    final prefs = await _getInstance();
    return prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await _getInstance();
    return prefs.getInt(key);
  }

  Future<bool> setIntList(String key, List<int> value) async {
    final prefs = await _getInstance();
    String jsonList = jsonEncode(value); // Convert list to JSON string
    return prefs.setString(key, jsonList);
  }

  // Read a list of integers
  Future<List<int>?> getIntList(String key) async {
    final prefs = await _getInstance();
    String? jsonList = prefs.getString(key);
    if (jsonList != null) {
      List<dynamic> decodedList = jsonDecode(jsonList); // Decode JSON string
      log('getIntList: ${decodedList.toString()}');
      return decodedList.cast<int>(); // Cast elements to integers
    } else {
      return null;
    }
  }

  // ... methods for bool, double, etc. if needed
}
