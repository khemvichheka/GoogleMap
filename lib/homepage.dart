import 'package:flutter/material.dart';
class HomePageMap extends StatefulWidget {
  const HomePageMap({super.key});

  @override
  State<HomePageMap> createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[500],
        title: Center(child: Text('Google Map HomePage')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.red,
              child: ListTile(
                leading: Icon(Icons.car_rental),
                title: Text('Create Marker on Maps'),
                trailing: Icon(Icons.chevron_right),
                 onTap: () {
                  Navigator.pushNamed(context, '/CreateMarker');
                },
              ),
            ),
            Card(
              color: Colors.blue,
              child: ListTile(
                leading: Icon(Icons.flight),
                title: Text('Draw Polyline with 2 direction'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, '/DrawPolyline');
                },
              ),
            ),
            Card(
              color: Colors.orange,
              child: ListTile(
                leading: Icon(Icons.apple),
                title: Text('Show multiple marker on Maps'),
                trailing: Icon(Icons.chevron_right),
                 onTap: () {
                  Navigator.pushNamed(context, '/MultipleMarker');
                },
              ),
            ),
            Card(
              color: Colors.green,
              child: ListTile(
                leading: Icon(Icons.shopping_bag_outlined),
                title: Text('Drag and Drop Google Map'),
                trailing: Icon(Icons.chevron_right),
                 onTap: () {
                  Navigator.pushNamed(context, '/DragAndDrop');
                },
              ),
            ),
            Card(
              color: Colors.grey,
              child: ListTile(
                leading: Icon(Icons.menu),
                title: Text('Custom Marker'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, '/CustomMarker');
                },   
              ),
            ),
            Card(
              color: Colors.cyan,
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text('Search Location'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, '/SearchLocation');
                },   
              ),
            ),
          ],
        ),
      ),
    );
  }
}
