import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateMarker extends StatefulWidget {
  @override
  _CreateMarkerState createState() => _CreateMarkerState();
}

class _CreateMarkerState extends State<CreateMarker> {
  List<Marker> allMarkers = [];

  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        infoWindow: InfoWindow( 
          title: 'my first marker',
          snippet: 'My location',
        ),
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(11.57629, 104.92329)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Marker'),
      ),
      body: Stack(
        children: [
          Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(11.562108, 104.888535), zoom: 12.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: moveToPreahSihanouk,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green
                ),
                child: Icon(Icons.forward, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: movetoPhnomPenh,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.red
                  ),
                  child: Icon(Icons.backspace, color: Colors.white),
                ),
              ),
            ),
          ),
        )
        ]
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveToPreahSihanouk() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(10.627543, 103.522141), zoom: 14.0, bearing: 45.0, tilt: 45.0,),
    ));
  }

  movetoPhnomPenh() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(11.562108, 104.888535), zoom: 12.0),
    ));
  }
}