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
 List<Map<String, dynamic>> data = [
    // 'images/car.png',
    // 'images/car2.png',
    // 'images/air-freight.png',
    { 
      "title": "Royal University of Phnom Penh",
      "description":"Russian Federation Blvd (110), Phnom Penh, Cambodia",
      "image":"assets/images/food-delivery.png",
    },
    { 
      "title": "Setec Institude",
      "image": "assets/images/smart-car.png",
      "description":"No. 86A, Street 110, Russian Federation Blvd (110), Phnom Penh, Cambodia"
    },
    { 
      "title": "Institute of foriegn langues",
      "image": "assets/images/scooter.png",     
      "description": "Russian Federation Blvd (110), Phnom Penh, Cambodia"
    }
   
  ];
  final List<Marker> _marker = <Marker>[
    Marker(markerId: MarkerId('12'), position: LatLng(11.56986,104.89162))
  ];
  final List<LatLng> _latLang = <LatLng>[
    LatLng (11.56854,104.89073),
    LatLng (11.56838,104.89477),
    LatLng (11.56906,104.89321),
  ];
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(11.56906,104.89321), zoom:16);
  Future<Uint8List> getBytesFoemAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < data.length; i++) {
      final Uint8List markerIcon = await getBytesFoemAssets(data[i]['image'], 100);
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latLang[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow:
                InfoWindow(title:data[i]['title'])),
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
