import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MultipleMarker extends StatefulWidget {
  const MultipleMarker({super.key});

  @override
  State<MultipleMarker> createState() => _MultipleMarkerState();
}

class _MultipleMarkerState extends State<MultipleMarker> {
    late GoogleMapController mapController;
  final Set<Marker> markers = new Set(); 
  static const LatLng showLocation = const LatLng(11.56906,104.89321); 
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Multiple Markers in Google Map"),
             backgroundColor: Colors.deepOrangeAccent,
          ),
          body: GoogleMap( 
                    zoomGesturesEnabled: true, 
                    initialCameraPosition: CameraPosition( 
                      target: showLocation,
                      zoom: 16.0, 
                    ),
                    markers: getmarkers(), 
                    mapType: MapType.normal, 
                    onMapCreated: (controller) { 
                      setState(() {
                        mapController = controller; 
                      });
                    },
                ),
       );
  }

  Set<Marker> getmarkers() { 
    setState(() {
      markers.add(Marker( 
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, 
        infoWindow: InfoWindow( 
          title: 'IFL ',
          snippet: 'My location',
          
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));

      markers.add(Marker( 
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(11.56854,104.89073), 
        infoWindow: InfoWindow(
          title: 'RUPP ',
          snippet: 'My location',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));

      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(11.56838,104.89477), 
        infoWindow: InfoWindow( 
          title: 'SETEC',
          snippet: 'My location',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));
    });

    return markers;
  }
}