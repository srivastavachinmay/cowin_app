import 'package:cowin_app/model/getByLatLong.dart';
import 'package:cowin_app/model/getByLatLongModel.dart' as model;
import 'package:cowin_app/model/getByPin.dart';
import 'package:cowin_app/model/getByPinModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';


class FindByLatLong extends StatefulWidget {
  @override
  _FindByLatLongState createState() => _FindByLatLongState();
}

class _FindByLatLongState extends State<FindByLatLong> {
  TextEditingController _controllerLat = TextEditingController();
  TextEditingController _controllerLong = TextEditingController();

  FocusNode _nodeLat = FocusNode();
  FocusNode _nodeLong = FocusNode();

  String lat = "";
  String long = "";
  // bool _submitted = false;
  Future<List<Session>> future;

  @override
  void dispose() {
    // TODO: implement dispose
    _nodeLong.dispose();
    _nodeLat.dispose();
    _controllerLong.dispose();
    _controllerLat.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    future = _listofSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listofSession(),

      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            print("///////////////////////////////////////");
            print(dataSnapshot.error);
            print("///////////////////////////////////////");
            return Column(
              children: [
                // Center(
                //   child: Text('An error occurred! \n ${dataSnapshot.error}'),
                  ElevatedButton(
                    child: Text("Give Permission"),
                    onPressed: (){
                      _givePermission();
                    },
                  ),
              ],
            );
          } else {
            print(dataSnapshot.data.length);
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: dataSnapshot.data.length,
              itemBuilder: (ctx, i) {
                Session session = dataSnapshot.data[i];
                // print(center.name);
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(session.name),
                    subtitle: Text("Address: ${session.pincode}"),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
  Future _givePermission()async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    print("Permission $permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.checkPermission();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.checkPermission();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // final coordinates = new Coordinates(26.874980, 81.011701);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print("Address : ${addresses}");
    // print("Postal Code : ${first.postalCode}");
    // print("${first.featureName} : ${first.addressLine}");
    // print("${addresses.first.locality}");

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<List<model.Center>> _listOfCenters() async {
    Position position = await _determinePosition();
    // print(position);
    return await Provider.of<GetByLatLong>(context, listen: false).fetchCenters(
        position.latitude.toString(), position.longitude.toString());
  }
  Future<List<Session>> _listofSession() async {
    Position position = await _determinePosition();
    // print(position);
    print(position);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.addressLine);
    return await Provider.of<GetByPin>(context, listen: false).fetchCenters(first.postalCode);
  }
}

// 81.011701
// 26.874980

// return SizedBox.expand(
//   child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// mainAxisSize: MainAxisSize.min,
// children: [
//   Container(
// height: 400,
// height: MediaQuery.of(context).size.height * .9,
// child:
// DropdownButton(items: []),
// Padding(
//   padding: const EdgeInsets.all(20),
//   child: Card(
//     elevation: 4,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Text(
//                   "Latitude   : ",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               Flexible(
//                 // width: 100,
//                 flex: 1,
//                 child: TextField(
//                     focusNode: _nodeLat,
//                     controller: _controllerLat,
//                     cursorColor: Theme.of(context).accentColor,
//                     keyboardType: TextInputType.number,
//                     autofocus: true,
//                     textInputAction: TextInputAction.next,
//                     onChanged: (val) {
//                       setState(() {
//                         lat = val;
//                       });
//                       print(lat);
//                     },
//                     onEditingComplete: () {
//                       setState(() {
//                         lat = _controllerLat.text;
//                       });
//                       print(lat);
//                     },
//                     onSubmitted: (_) {
//                       setState(() {
//                         lat = _controllerLat.text;
//                       });
//                       print(lat);
//                       FocusScope.of(context).requestFocus(_nodeLong);
//                     }),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Text(
//                   "Longitude : ",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               Flexible(
//                 // width: 100,
//                 flex: 1,
//                 child: TextField(
//                     focusNode: _nodeLong,
//                     controller: _controllerLong,
//                     cursorColor: Theme.of(context).accentColor,
//                     keyboardType: TextInputType.number,
//                     textInputAction: TextInputAction.done,
//                     onEditingComplete: () {
//                       setState(() {
//                         long = _controllerLong.text;
//                       });
//                       print(long);
//                     },
//                     onChanged: (val) {
//                       setState(() {
//                         long = val;
//                       });
//                       print(long);
//                     },
//                     onSubmitted: (_) {
//                       setState(() {
//                         long = _controllerLong.text;
//                       });
//                       print(long);
//                       FocusScope.of(context).unfocus();
//                     }),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               onPrimary: Theme.of(context).accentColor,
//               primary: Theme.of(context).primaryColor,
//               shadowColor: Colors.teal,
//               elevation: 5,
//             ),
//             onPressed: () {
//               setState(() {
//                 _submitted = true;
//                 long = _controllerLong.text;
//                 lat = _controllerLat.text;
//                 _controllerLong.text = "";
//                 _controllerLat.text = "";
//               });
//               future = Provider.of<GetByLatLong>(context, listen: false)
//                   .fetchCenters(lat, long);
//             },
//             child: Text("Confirm"),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),

// if (_submitted)
