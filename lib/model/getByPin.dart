import 'getByPinModel.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetByPin with ChangeNotifier {
  List<Session> _sessions;


  Future<List<Session>> fetchCenters(String pin) async {
    try {
      var url = Uri.parse(
          "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$pin&date=20-07-2021");
      final response = await http.get(url);
      GetByPinModel model = GetByPinModel.fromJson(json.decode(response.body));
      _sessions = model.sessions;
    }on Exception catch(e){
      //TODO
      print(e.toString());
    }
    return _sessions;
  }
}
