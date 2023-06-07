import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

double ZOOM = 14;
Future<Position> getCurrentPosition() async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  } else {
    final request = await Geolocator.requestPermission();
    if (request == LocationPermission.always ||
        request == LocationPermission.whileInUse) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      throw Exception("Access to Location permission was denied .");
    }
  }
}

Future<CameraPosition> getCurrentCameraPosition() async {
  Position currentPos = await getCurrentPosition();
  if (currentPos != null) {
    return CameraPosition(
        target: LatLng(currentPos.latitude, currentPos.longitude), zoom: ZOOM);
  } else {
    throw Exception(
        " Error current location because Google Maps permission was denied.");
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo info = await codec.getNextFrame();
  return (await info.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

