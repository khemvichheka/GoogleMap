import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// bool isSelected = false;
// double underlineWith = 0;
// bool _isLoaded = false;
//

class CustomWindowMarker extends StatefulWidget {
  const CustomWindowMarker({Key? key}) : super(key: key);

  @override
  _CustomWindowMarkerState createState() => _CustomWindowMarkerState();
}

class _CustomWindowMarkerState extends State<CustomWindowMarker> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> _markers = {};
  List<Map<String, dynamic>> dataMap = [
    {
      'latlong': LatLng(11.56855, 104.89068),
      "title": "Royal University of Phnom Penh",
      "description":"Russian Federation Blvd (110), Phnom Penh, Cambodia"
    },
    {
      'latlong': LatLng(11.56831, 104.89473),
      "title": "Setec Institude",
      "description":
          "No. 86A, Street 110, Russian Federation Blvd (110), Phnom Penh, Cambodia"
    },
    {
      'latlong': LatLng(11.56911, 104.89318),
      "title": "Institute of foriegn langues",
      "description": "Russian Federation Blvd (110), Phnom Penh, Cambodia"
    },

  ];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < dataMap.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: dataMap[i]['latlong'],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 200.0, top: 3),
                                  child: InkWell(
                                    onTap: () => _customInfoWindowController
                                        .hideInfoWindow!(),
                                    child: Icon(
                                      Icons.clear,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  dataMap[i]['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children:  [
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.person_pin_circle,
                                    size: 15,
                                    color: Colors.blue,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text( dataMap[i]['title']))
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(Icons.phone,
                                      size: 15, color: Colors.blue),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text(
                                    '+1 212-873-3400',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children:  [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text(
                                      dataMap[i]['description'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 25, top: 5),
                                    child: Container(
                                      width: 100,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border:
                                              Border.all(color: Colors.blue)),
                                      child: Center(
                                          child: Text(
                                        'Directions',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  dataMap[i]['latlong']);
            }),
      );
      setState(() {
        // _isLoaded:true;
      });
    }

    @override
    Widget build(BuildContext context) {
      throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Custom Marker InfoWindow '),
          backgroundColor: Colors.red,
        ),
        body: Stack(children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(11.56911, 104.8918), zoom: 16),
            markers: _markers,
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 170,
            width: 240,
            offset: 35,
          )
        ]));
  }
}
