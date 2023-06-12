import 'dart:collection' show HashSet;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStyle extends StatefulWidget {
  MapStyle({super.key});
  @override
  State<MapStyle> createState() => _MapStyleState();
}

class _MapStyleState extends State<MapStyle> {
  String style = '';
  bool isStandard = false;
  bool isSliver = false;
  bool isRetro = false;
  bool isnight = false;
  bool isDark = false;
  bool isEmbugene = false;

  final Set<Marker> _Markers = HashSet<Marker>();
  late GoogleMapController _mapController;
  late BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _addMarkerIcon();
    _addMapStyle();
  }

  void _addMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/laptop.png");
  }

  void _addMapStyle() async {
    if (isStandard == true) {
      style = await DefaultAssetBundle.of(context)
          .loadString('assets/images/map_standard.json');
    } else if (isDark == true) {
      style = await DefaultAssetBundle.of(context)
          .loadString('assets/images/map_dark.json');
    } else if (isRetro == true) {
      style = await DefaultAssetBundle.of(context)
          .loadString('assets/images/map_retro.json');
    } else if (isSliver == true) {
      style = await DefaultAssetBundle.of(context)
          .loadString('assets/images/map_sliver.json');
    } else if (isnight == true) {
      style = await DefaultAssetBundle.of(context)
          .loadString('assets/images/map_night.json');
    } else if (isEmbugene == true) {
      style = await DefaultAssetBundle.of(context)
          .loadString('assets/images/map_ambugene.json');
    }
    _mapController.setMapStyle(style);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _Markers.add(Marker(
        markerId: MarkerId("0"),
        position: LatLng(11.56823, 104.89069),
        infoWindow: InfoWindow(
          title: "RUPP",
          snippet: "School place",
        ),
        icon: _markerIcon,
      ));
      _addMapStyle();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Style"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isStandard = true;
                    _addMapStyle();
                     isStandard = false;
                  });
                },
                child: Icon(Icons.shopping_bag_outlined),
              )),
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isDark = true;
                    _addMapStyle();
                    isDark = false;
                  });
                },
                child: Icon(Icons.dark_mode),
              )),
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isRetro = true;
                    _addMapStyle();
                    isRetro = false;
                  });
                },
                child: Icon(Icons.notification_add),
              )),
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSliver = true;
                    _addMapStyle();
                    isSliver = false;
                  });
                },
                child: Icon(Icons.map),
              )),
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isnight = true;
                    _addMapStyle();
                    isnight = false;
                  });
                },
                child: Icon(
                  Icons.mode_night,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isEmbugene = true;
                    _addMapStyle();
                    isEmbugene = false;
                  });
                },
                child: Icon(Icons.apple),
              )),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(11.56823, 104.89069),
          zoom: 14,
        ),
        markers: _Markers,
      ),
    );
  }
}
