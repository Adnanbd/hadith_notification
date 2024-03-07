import 'dart:convert';
import 'dart:developer';

import 'package:hadith_notification/models/single.hadith.details.dart';
import 'package:hadith_notification/utils/constants.dart';
import 'package:http/http.dart' as http;

class HadithService {
  Future<SingleHadithDetailModel?> fetchSingleHadith(int no) async {
    var url = Uri.parse(bukhariHadith(no));
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = response.body;
      log('Single Hadith Response: $jsonData');
      SingleHadithDetailModel data = SingleHadithDetailModel.fromJson(json.decode(jsonData)['hadith']);
      return data;
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }
}
