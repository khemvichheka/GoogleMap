import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? markerImage;
  List<String> images = [
    'images/car.png',
    'images/car2.png',
    'images/air-freight.png',
    'images/food-delivery.png',
    'images/scooter.png',
    'images/smart-car.png'
  ];
  final List<Marker> _marker = <Marker>[
    Marker(markerId: MarkerId('12'), position: LatLng(33.6941, 72.9734))
  ];
  final List<LatLng> _latLang = <LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785)
  ];
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.6910, 72.98072), zoom: 15);
  Future<Uint8List> getBytesFoemAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFoemAssets(images[i], 100);
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latLang[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow:
                InfoWindow(title: 'this is title marker :' + i.toString())),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CUSTOM MULTIPLE MARKER')),
        body: SafeArea(
      child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            setState(() {
            _controller.complete(controller);
            });
          }),
    ));
  }
}
