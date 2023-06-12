// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_map_2/calculate_distance.dart';
import 'package:google_map_2/createmarker.dart';
import 'package:google_map_2/custom_marker_widget/widget_marker_screen.dart';
import 'package:google_map_2/custom_marker.dart';
import 'package:google_map_2/Info_window_marker/custom_marker_infowindow.dart';
import 'package:google_map_2/darg_drop_map.dart';
import 'package:google_map_2/homepage.dart';
import 'package:google_map_2/map_style.dart';
import 'package:google_map_2/multiple_marker.dart';
import 'package:google_map_2/polyline/polyline_point.dart';
// import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageMap(),
        '/CreateMarker': (context) => CreateMarker(),
        '/DrawPolyline': (context) => DrawPolyline(),
        '/MultipleMarker': (context) => MultipleMarker(),
        '/DragAndDrop': (context) => DragAndDrop(),
        '/CustomMarker': (context) => CustomMarker(),
        '/CustomWindowMarker': (context) => CustomWindowMarker(),
        '/CustomMarkerWidget': (context) => WidgetMarkerScreen(),
        '/MapStyle': (context)=>MapStyle(),
        '/Calculate': (context)=>CalculateDistanceTwoDirection(),
      },
    );
  }
}
   