import 'dart:convert';

import 'package:first_app/core/const/app_constant.dart';
import 'package:first_app/feature/details_popular/data/model/popular_people_details_model.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<PopularModel?> getData() async {
    Map<String, String> getPopularPeopleHeaders = {
      "Accept": "application/json"
    };
    var response = await http.get(
      Uri.parse(AppConsts.popularPeopleAPI),
      headers: getPopularPeopleHeaders,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);
      PopularModel popularModel = PopularModel.fromJson(decoded);
      return popularModel;
    } else {
      return null;
    }
  }

  static Future<PopularPeopleDetailsModel?> getPersonDetails(num id) async {
    Map<String, String> getPersonDetailsHeaders = {
      "Accept": "application/json"
    };
    var response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/person/$id?api_key=2dfe23358236069710a379edd4c65a6b",
      ),
      headers: getPersonDetailsHeaders,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);
      PopularPeopleDetailsModel peopleDetailsModel =
          PopularPeopleDetailsModel.fromJson(decoded);
      return peopleDetailsModel;
    } else {
      return null;
    }
  }
}
