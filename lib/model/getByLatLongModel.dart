// To parse this JSON data, do
//
//     final getByLatLong = getByLatLongFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetByLatLongModel getByLatLongFromJson(String str) => GetByLatLongModel.fromJson(json.decode(str));

String getByLatLongToJson(GetByLatLongModel data) => json.encode(data.toJson());

class GetByLatLongModel {
  GetByLatLongModel({
    @required this.centers,
    @required this.ttl,
  });

  List<Center> centers;
  int ttl;

  factory GetByLatLongModel.fromJson(Map<String, dynamic> json) => GetByLatLongModel(
    centers: List<Center>.from(json["centers"].map((x) => Center.fromJson(x))),
    ttl: json["ttl"],
  );

  Map<String, dynamic> toJson() => {
    "centers": List<dynamic>.from(centers.map((x) => x.toJson())),
    "ttl": ttl,
  };
}

class Center {
  Center({
    @required this.centerId,
    @required this.name,
    @required this.districtName,
    @required this.stateName,
    @required this.location,
    @required this.pincode,
    @required this.blockName,
    @required this.lat,
    @required this.long,
  });

  int centerId;
  String name;
  String districtName;
  String stateName;
  String location;
  String pincode;
  String blockName;
  String lat;
  String long;

  factory Center.fromJson(Map<String, dynamic> json) => Center(
    centerId: json["center_id"],
    name: json["name"],
    districtName: json["district_name"],
    stateName: json["state_name"],
    location: json["location"],
    pincode: json["pincode"],
    blockName: json["block_name"],
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "center_id": centerId,
    "name": name,
    "district_name": districtName,
    "state_name": stateName,
    "location": location,
    "pincode": pincode,
    "block_name": blockName,
    "lat": lat,
    "long": long,
  };
}
