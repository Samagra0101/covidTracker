import 'package:http/http.dart' as http;
import 'package:covid_app/models/WorldStatsModel.dart';
import 'package:covid_app/services/utilities/app_url.dart';
import 'dart:convert';
class StatsServices {

  Future<WorldStatsModel> getApi() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    if(response.statusCode==200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    }
      else{
        throw Exception('Error');
    }
    }

  Future<List<dynamic>> countryListApi() async{
    final response = await http.get(Uri.parse(AppUrl.countryList));
    if(response.statusCode==200) {
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }

}

