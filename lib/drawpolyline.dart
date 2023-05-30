import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawPolyline extends StatefulWidget {
  const DrawPolyline({super.key});

  @override
  State<DrawPolyline> createState() => _DrawPolylineState();
}

class _DrawPolylineState extends State<DrawPolyline> {
   @override
 final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Google Plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kLakeMarker = Marker(
    markerId: const MarkerId('_kLakeMarker'),
    infoWindow: const InfoWindow(title: 'lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(37.43296265331129, -122.08832357078792),
  );

  static final Polyline _kPolyline = Polyline(
    polylineId: PolylineId('_kPolyline'),
    points: const [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
    ],
    width: 5,
  );
  
  static final Polygon _kPolygon = Polygon(
    polygonId: PolygonId('_kPolygon'),
    points: const [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.418, -122.092),
      LatLng(37.435, -122.092)
    ],
    strokeWidth: 3,
    fillColor: Colors.red,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw Polyline'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                markers: {
                  _kGooglePlexMarker,
                   _kLakeMarker,
                },
                polylines: {
                  _kPolyline,
               
                },
                // polygons: {
                //   _kPolygon
                // },
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}