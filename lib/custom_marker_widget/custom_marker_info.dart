import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfo extends StatefulWidget {
  const CustomMarkerInfo({super.key});

  @override
  State<CustomMarkerInfo> createState() => _CustomMarkerInfoState();
}

class _CustomMarkerInfoState extends State<CustomMarkerInfo> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(1.35, 103.8), zoom: 12.0);
  @override
  Widget build(BuildContext context) {
    var markers = {
      const Marker(markerId: MarkerId('1'), position: LatLng(1.35, 103.8)),
      Marker(
          markerId: const MarkerId('2'),
          position: const LatLng(1.32, 103.82),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
      Marker(
          markerId: const MarkerId('3'),
          position: const LatLng(1.33, 103.78),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange))
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Standart Marker'),
      ),
      body: GoogleMap(
          myLocationButtonEnabled: false,
          initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers,
          ),
    );
  }
}
