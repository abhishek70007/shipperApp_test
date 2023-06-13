import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIService {
  String RapidApiKey = dotenv.get('rapidKey').toString();

  // List<CityModel> city = [];
  static const _authority = "spott.p.rapidapi.com";
  static const _path = "/places/autocomplete";
  // static const _query = {"q": "city", "type": "CITY","limit":"10"};
  // static const Map<String, String> _headers = {
  //   "x-rapidapi-key": RapidApiKey,
  //   "x-rapidapi-host": "spott.p.rapidapi.com",
  // };

  // Base API request to get response
  Future<List<CityModel>> get(String cityName) async {
    var _query = {"q": cityName, "type": "CITY","limit":"10","country":"IN"};
    Uri uri = Uri.https(_authority, _path, _query);
    final response = await http.get(uri, headers: {"x-rapidapi-key": RapidApiKey,
      "x-rapidapi-host": "spott.p.rapidapi.com"});
    if (response.statusCode == 200) {
      final List city = json.decode(response.body);
      return city.map((json) => CityModel.fromJson(json)).toList();
    } else {
      throw Exception(
          "error");
    }
  }
}

class CityModel {
  String? id;
  int? geonameId;
  String? type;
  String? name;
  int? population;
  int? elevation;
  String? timezoneId;
  Country? country;
  Country? adminDivision1;
  Country? adminDivision2;
  // double? score;
  Coordinates? coordinates;

  CityModel(
      {this.id,
        this.geonameId,
        this.type,
        this.name,
        this.population,
        this.elevation,
        this.timezoneId,
        this.country,
        this.adminDivision1,
        this.adminDivision2,
        // this.score,
        this.coordinates});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    geonameId = json['geonameId'];
    type = json['type'];
    name = json['name'];
    population = json['population'];
    elevation = json['elevation'];
    timezoneId = json['timezoneId'];
    country =
    json['country'] != null ? Country.fromJson(json['country']) : null;
    adminDivision1 = json['adminDivision1'] != null
        ? Country.fromJson(json['adminDivision1'])
        : null;
    adminDivision2 = json['adminDivision2'] != null
        ? Country.fromJson(json['adminDivision2'])
        : null;
    // score = json['score'];
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['geonameId'] = geonameId;
    data['type'] = type;
    data['name'] = name;
    data['population'] = population;
    data['elevation'] = elevation;
    data['timezoneId'] = timezoneId;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (adminDivision1 != null) {
      data['adminDivision1'] = adminDivision1!.toJson();
    }
    if (adminDivision2 != null) {
      data['adminDivision2'] = adminDivision2!.toJson();
    }
    // data['score'] = score;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    return data;
  }
}

class Country {
  String? id;
  int? geonameId;
  String? name;

  Country({this.id, this.geonameId, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    geonameId = json['geonameId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['geonameId'] = geonameId;
    data['name'] = name;
    return data;
  }
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}