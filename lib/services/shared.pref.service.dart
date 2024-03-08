import 'dart:convert';
import 'dart:developer';

import 'package:hadith_notification/models/single.hadith.details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Obtain SharedPreferences instance
  Future<SharedPreferences> _getInstance() async => await SharedPreferences.getInstance();
  static const _hadithListKey = 'saved_hadith_list';


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

  Future<void> saveHadithList(List<SingleHadithDetailModel> hadiths) async {
    final prefs = await _getInstance();

    // Convert your list of models into a list of JSON strings
    List<String> hadithJsonList = hadiths.map((hadith) => jsonEncode(hadith.toJson())).toList();

    // Store the encoded JSON list in SharedPreferences
    await prefs.setStringList(_hadithListKey, hadithJsonList);
  }

  // Method to retrieve the list 
  Future<List<SingleHadithDetailModel>> loadHadithList() async {
    final prefs = await _getInstance();

    // Get the stored list as a list of strings
    List<String> hadithJsonList = prefs.getStringList(_hadithListKey) ?? [];

    // Decode each JSON string and create a list of models 
    List<SingleHadithDetailModel> hadiths = hadithJsonList.map((jsonStr) =>
          SingleHadithDetailModel.fromJson(jsonDecode(jsonStr))).toList();

    return hadiths;
  }

  Future<void> addSingleHadith(SingleHadithDetailModel hadith) async {
    // Retrieve existing hadiths
    List<SingleHadithDetailModel> existingHadiths = await loadHadithList();

    // Add the new hadith to the list
    existingHadiths.add(hadith);

    // Save the updated list
    await saveHadithList(existingHadiths);
  }

  // ... methods for bool, double, etc. if needed
}
