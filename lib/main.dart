// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_map_2/createmarker.dart';
import 'package:google_map_2/custom_marker.dart';
import 'package:google_map_2/darg_drop_map.dart';
import 'package:google_map_2/drawpolyline.dart';
import 'package:google_map_2/homepage.dart';
import 'package:google_map_2/multiple_marker.dart';
import 'package:google_map_2/search_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       initialRoute: '/',
       routes: {
        '/':(context) => HomePageMap(),
        '/CreateMarker':(context) => CreateMarker(),
        '/DrawPolyline':(context) => DrawPolyline(),
        '/MultipleMarker':(context) => MultipleMarker(),
        '/DragAndDrop':(context) => DragAndDrop(), 
        '/CustomMarker':(context) => CustomMarker(),
        '/SearchLocation':(context)=> SearchLocation(),
       },
    );
  }
}







