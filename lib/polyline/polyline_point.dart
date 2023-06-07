import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_2/polyline/maps_repo.dart' as mapsRepo;

class DrawPolyline extends StatefulWidget {
  const DrawPolyline({super.key});

  @override
  State<DrawPolyline> createState() => _DrawPolylineState();
}

class _DrawPolylineState extends State<DrawPolyline> {
  final Completer<GoogleMapController> _completer = Completer();
  Set<Marker> _markers = <Marker>{};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCN4MAbenq2HNxGOyLVGtXbeTrTz90ytVA";


  List<Map<String, dynamic>> dataMap = [
    {
      "pointLatLng": PointLatLng(11.56823, 104.89069),
      "name": "Royal University of PhnomPenh"
    },
    {
      "pointLatLng": PointLatLng(11.57419, 104.87749),
      "name": "International University"
    },
  ];
  _getPolyline() async {
    // Position pos = await mapsRepo.getCurrentPosition();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        dataMap[0]['pointLatLng'] as PointLatLng,
        dataMap[1]['pointLatLng'] as PointLatLng,
        travelMode: TravelMode.driving);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.green, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  Future<Set<Marker>> _initMarkers() async {
    final Uint8List byteIcon =
        await mapsRepo.getBytesFromAsset('images/car.png', 100);
    final icon = BitmapDescriptor.fromBytes(byteIcon);
    List<Marker> markers = <Marker>[];

    for (final location in dataMap) {
      final latlong = location['pointLatLng'] as PointLatLng;
      final marker = Marker(
        markerId: MarkerId(location.toString()),
        infoWindow: InfoWindow(
            title: "${location['name']}",
            snippet: "${location['pointLatLng']}",
            onTap: () {
              log("tapped ${location['name']}");
            }),
        position: LatLng(
          latlong.latitude,
          latlong.longitude,
        ),
        icon: icon,
      );
      markers.add(marker);
    }
    return markers.toSet();
  }

  @override
  void initState() {
    _initMarkers().then((markers) {
      setState(() {
        _markers = markers;
        _getPolyline();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps Polyline"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                _getPolyline();
              },
              icon: Icon(Icons.map))
        ],
      ),
      body: _buildBody(),
      // floatingActionButton: _buildCurrentLocationButton(),
    );
  }

  _buildBody() {
    return Container(
      child: _buildMap(),
    );
  }

  _buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markers,
      polylines: Set<Polyline>.of(polylines.values),
      initialCameraPosition:
          CameraPosition(target: LatLng(11.57235, 104.88399), zoom: 15),
      onMapCreated: (GoogleMapController controller) =>
          _completer.complete(controller),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
    );
  }

  bool _cameraLoading = false;
  _buildCurrentLocationButton() {
    return IgnorePointer(
      ignoring: _cameraLoading,
      child: FloatingActionButton(
        child: _cameraLoading ? Icon(Icons.refresh) : Icon(Icons.person_pin),
        onPressed: () async {
          setState(() => _cameraLoading = true);
          final GoogleMapController controller = await _completer.future;
          mapsRepo.getCurrentCameraPosition().then((CameraPosition) {
            controller
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition));
            setState(() => _cameraLoading = false);
          });
        },
      ),
    );
  }
}
