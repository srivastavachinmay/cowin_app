import 'package:cowin_app/model/getByLatLong.dart';
import 'package:cowin_app/screens/findByLocationScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetByLatLong(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // primaryColor: Color(0xff1e3770),
          // accentColor: Color(0xffFF8400),
          primaryColor: Color(0xff1e3770),
          accentColor: Color(0xffffc947),
        ),
        home: FindByLocation(),
      ),
    );
  }
}
// 81.011701
// 26.874980