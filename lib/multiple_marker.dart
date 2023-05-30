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
  static const LatLng showLocation = const LatLng(27.7089427, 85.3086209); 
  
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
                      zoom: 15.0, 
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
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));

      markers.add(Marker( 
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7099116, 85.3132343), 
        infoWindow: InfoWindow(
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));

      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7137735, 85.315626), 
        infoWindow: InfoWindow( 
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));
    });

    return markers;
  }
}