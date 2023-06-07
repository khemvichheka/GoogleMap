import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Map<String, dynamic>> data = [
  {
    'id': '1',
    'position': const LatLng(1.32, 103.80),
    'assetPath': 'images/car.png',
  },
  {
    'id': '2',
    'position': const LatLng(1.34, 103.84),
    'assetPath': 'images/car2.png',
  },
  {
    'id': '3',
    'position': const LatLng(1.37, 103.76),
    'assetPath': 'images/air-freight.png',
  }
];

class AssetMarkerScreen extends StatefulWidget {
  const AssetMarkerScreen({super.key});

  @override
  State<AssetMarkerScreen> createState() => _AssetMarkerScreenState();
}

class _AssetMarkerScreenState extends State<AssetMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(1.35, 103.8), zoom: 12.0);
  @override
  void initState() {
    // TODO: implement initState
    _gernerateMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markers from Assets'),
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers.values.toSet(),
      ),
    );
  }

  _gernerateMarker() async {
    for (int i = 0; i < data.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), data[i]['assetPath']);
      _markers[i.toString()] = Marker(
        markerId: MarkerId(i.toString()),
        position: data[i]['position'],
        icon: markerIcon,
        infoWindow: InfoWindow(title:  'This is a marker from an asset image')
      );
      setState(() {
        
      });
    }
  }
  _generateMarker() async{
    
  }
}
