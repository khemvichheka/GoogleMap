import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CalculateDistanceTwoDirection extends StatefulWidget {
  const CalculateDistanceTwoDirection({super.key});

  @override
  State<CalculateDistanceTwoDirection> createState() => _CalculateDistanceTwoDirectionState();
}

class _CalculateDistanceTwoDirectionState extends State<CalculateDistanceTwoDirection> {
GoogleMapController? mapController; 
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyCN4MAbenq2HNxGOyLVGtXbeTrTz90ytVA";
  
  Set<Marker> markers = Set(); 
  Map<PolylineId, Polyline> polylines = {}; 

  LatLng startLocation = LatLng (11.56823, 104.89069);  
  LatLng endLocation =  LatLng (11.57419, 104.87749); 
 
  double distance = 0.0;
                
  @override
  void initState() {

     markers.add(Marker( 
        markerId: MarkerId(startLocation.toString()),
        position: startLocation, 
        infoWindow: InfoWindow( 
          title: 'Royal University of Phnom Penh ',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));

      markers.add(Marker( 
        markerId: MarkerId(endLocation.toString()),
        position: endLocation, 
        infoWindow: InfoWindow( 
          title: 'International University',
          snippet: 'Destination Marker',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));
      
      getDirections(); 
      
    super.initState();
  }

  getDirections() async {
      List<LatLng> polylineCoordinates = [];
     
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(startLocation.latitude, startLocation.longitude),
          PointLatLng(endLocation.latitude, endLocation.longitude),
          travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
            result.points.forEach((PointLatLng point) {
                polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            });
      } else {
         print(result.errorMessage);
      }
      double totalDistance = 0;
      for(var i = 0; i < polylineCoordinates.length-1; i++){
           totalDistance += calculateDistance(
                polylineCoordinates[i].latitude, 
                polylineCoordinates[i].longitude, 
                polylineCoordinates[i+1].latitude, 
                polylineCoordinates[i+1].longitude);
      }
      print(' totalDistance $totalDistance');

      setState(() {
         distance = totalDistance;
      });

      addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Calculate Distance in Google Map"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Stack(
            children:[
                GoogleMap( 
                        zoomGesturesEnabled: true, 
                        initialCameraPosition: CameraPosition( 
                          target: LatLng(11.57504, 104.88180), 
                          zoom: 14.5, 
                        ),
                        markers: markers, 
                        polylines: Set<Polyline>.of(polylines.values), 
                        mapType: MapType.normal,
                        onMapCreated: (controller) {
                          setState(() {
                            mapController = controller; 
                          });
                        },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 410,left: 10),
                    child: Positioned(
                      bottom: 200,
                      left: 50,
                      child: Container( 
                       child: Card( 
                           child: Container(
                              padding: EdgeInsets.all(20),
                              child: Text("Total Distance: " + distance.toStringAsFixed(2) + " KM",
                                           style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold))
                           ),
                       )
                      )
                                   ),
                  )
            ]
          )
       );
  }
}