// To parse this JSON data, do
//
//     final getByPinModel = getByPinModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetByPinModel getByPinModelFromJson(String str) => GetByPinModel.fromJson(json.decode(str));

String getByPinModelToJson(GetByPinModel data) => json.encode(data.toJson());

class GetByPinModel {
  GetByPinModel({
    @required this.sessions,
  });

  List<Session> sessions;

  factory GetByPinModel.fromJson(Map<String, dynamic> json) => GetByPinModel(
    sessions: List<Session>.from(json["sessions"].map((x) => Session.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
  };
}

class Session {
  Session({
    @required this.centerId,
    @required this.name,
    @required this.address,
    @required this.stateName,
    @required this.districtName,
    @required this.blockName,
    @required this.pincode,
    @required this.from,
    @required this.to,
    @required this.lat,
    @required this.long,
    @required this.feeType,
    @required this.sessionId,
    @required this.date,
    @required this.availableCapacity,
    @required this.availableCapacityDose1,
    @required this.availableCapacityDose2,
    @required this.fee,
    @required this.minAgeLimit,
    @required this.allowAllAge,
    @required this.vaccine,
    @required this.slots,
  });

  int centerId;
  String name;
  String address;
  String stateName;
  String districtName;
  String blockName;
  int pincode;
  String from;
  String to;
  int lat;
  int long;
  String feeType;
  String sessionId;
  String date;
  int availableCapacity;
  int availableCapacityDose1;
  int availableCapacityDose2;
  String fee;
  int minAgeLimit;
  bool allowAllAge;
  String vaccine;
  List<String> slots;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    centerId: json["center_id"],
    name: json["name"],
    address: json["address"],
    stateName: json["state_name"],
    districtName: json["district_name"],
    blockName: json["block_name"],
    pincode: json["pincode"],
    from: json["from"],
    to: json["to"],
    lat: json["lat"],
    long: json["long"],
    feeType: json["fee_type"],
    sessionId: json["session_id"],
    date: json["date"],
    availableCapacity: json["available_capacity"],
    availableCapacityDose1: json["available_capacity_dose1"],
    availableCapacityDose2: json["available_capacity_dose2"],
    fee: json["fee"],
    minAgeLimit: json["min_age_limit"],
    allowAllAge: json["allow_all_age"],
    vaccine: json["vaccine"],
    slots: List<String>.from(json["slots"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "center_id": centerId,
    "name": name,
    "address": address,
    "state_name": stateName,
    "district_name": districtName,
    "block_name": blockName,
    "pincode": pincode,
    "from": from,
    "to": to,
    "lat": lat,
    "long": long,
    "fee_type": feeType,
    "session_id": sessionId,
    "date": date,
    "available_capacity": availableCapacity,
    "available_capacity_dose1": availableCapacityDose1,
    "available_capacity_dose2": availableCapacityDose2,
    "fee": fee,
    "min_age_limit": minAgeLimit,
    "allow_all_age": allowAllAge,
    "vaccine": vaccine,
    "slots": List<dynamic>.from(slots.map((x) => x)),
  };
}
