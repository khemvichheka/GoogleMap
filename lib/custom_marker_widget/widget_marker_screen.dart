import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_map_2/custom_marker_widget/custom_marker_wiget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Map<String, dynamic>> data = [
  {
    'id': '1',
    'globalKey': GlobalKey(),
    'position': const LatLng(11.56854,104.89073),
    'widget':  CustomMarkerWidget(latlong: 11.56854,title: 'RUPP',),
  },
  {
    'id': '2',
    'globalKey': GlobalKey(),
    'position': const LatLng(11.56838,104.89477),
    'widget':  CustomMarkerWidget(latlong: 11.56838,title: 'SETEC',),
  },
  {
    'id': '3',
    'globalKey': GlobalKey(),
    'position': const LatLng(11.56906,104.89321),
    'widget':  CustomMarkerWidget(latlong: 11.56906,title: 'IFL'),
  },
];

class WidgetMarkerScreen extends StatefulWidget {
  const WidgetMarkerScreen({super.key});

  @override
  State<WidgetMarkerScreen> createState() => _WidgetMarkerScreenState();
}

class _WidgetMarkerScreenState extends State<WidgetMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(11.56906,104.89321),
    zoom: 16.0,
  );
  bool _isLoaded = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onBuildCompleted());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Markers from Widgets')),
      body: _isLoaded
          ? GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers.values.toSet(),
            )
          : ListView(
              children: [
                for (int i = 0; i < data.length; i++)
                  Transform.translate(
                    offset: Offset(
                      -MediaQuery.of(context).size.width * 5,
                      -MediaQuery.of(context).size.height * 5,
                    ),
                    child: RepaintBoundary(
                      key: data[i]['globalKey'],
                      child: data[i]['widget'],
                    ),
                  )
              ],
            ),
    );
  }
  Future<void> _onBuildCompleted() async {
    await Future.wait(
      data.map((value) async {
        Marker marker = await _generateMarkersFromWidgets(value);
        _markers[marker.markerId.value] = marker;
      }),
    );
    setState(() => _isLoaded = true);
  }
  Future<Marker> _generateMarkersFromWidgets(Map<String, dynamic> data) async => Future.delayed(Duration(milliseconds: 50), () async {   
    RenderRepaintBoundary boundary = data['globalKey']
        .currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 5);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return Marker(
      markerId: MarkerId(data['id']),
      position: data['position'],
      infoWindow: InfoWindow(
        // title: 'university',
        // snippet: 'current location',
      ),
      icon: BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List()),
    );
  });
}
