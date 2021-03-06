import 'getByLatLongModel.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetByLatLong with ChangeNotifier {
  List<Center> _centers;


  Future<List<Center>> fetchCenters(String lat, String long) async {
    try {
      var url = Uri.parse(
          "https://cdn-api.co-vin.in/api/v2/appointment/centers/public/findByLatLong?lat=$lat&long=$long");
      final response = await http.get(url);
      GetByLatLongModel model = GetByLatLongModel.fromJson(json.decode(response.body));
      _centers = model.centers;
    }on Exception catch(e){
      //TODO
      print(e.toString());
    }
    return _centers;
  }
}
