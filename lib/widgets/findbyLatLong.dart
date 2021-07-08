import 'package:cowin_app/model/getByLatLong.dart';
import 'package:cowin_app/model/getByLatLongModel.dart' as model;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

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
  bool _submitted = false;
  Future future;

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
    future = _listOfCenters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox.expand(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
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
        Container(
          height: 400,
          child: FutureBuilder(
            future: _listOfCenters(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  print(dataSnapshot.data.length);
                  return ListView.builder(
                      itemCount: dataSnapshot.data.length,
                      itemBuilder: (ctx, i) {
                        model.Center center = dataSnapshot.data[i];
                        print(center.name);
                        return Card(
                          child: ListTile(title: Text(center.name)),
                        );
                      });
                }
              }
            },
          ),
        ),
      ],
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }


  Future<List<model.Center>> _listOfCenters() async {
    Position position= await _determinePosition();
    print(position);
    return await Provider.of<GetByLatLong>(context,listen:false ).fetchCenters(
        position.latitude.toString(), position.longitude.toString());

  }
}

// 81.011701
// 26.874980
