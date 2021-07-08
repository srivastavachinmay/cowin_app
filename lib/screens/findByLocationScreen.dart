import 'package:cowin_app/widgets/findbyLatLong.dart';
import 'package:flutter/material.dart';

class FindByLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Find By Location",style: TextStyle(color: Theme.of(context).accentColor),),
      ),
      body: SafeArea(
        child: FindByLatLong(),
      ),
    );
  }
}
