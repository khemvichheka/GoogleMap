import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

const kGoogleApiKey = '';

class _SearchLocationState extends State<SearchLocation> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  // final Mode _mode=Mode.overlay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Location on Google map'),
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          // ElevatedButton(
          //     onPressed: _handlePressButton, child: Text('Search Place'))
        ],
      ),
    );
  }

  // Future<void> _handlePressButton() async {
  //   Prediction? p =
  //       PlaceAutocomplete.show(context: context, apiKey: kGoogleApiKey,onError:onError,mode:_mode);
  // }
}
