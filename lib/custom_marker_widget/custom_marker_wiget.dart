import 'package:flutter/material.dart';

class CustomMarkerWidget extends StatelessWidget {
  final double latlong;
  final String title;
  const CustomMarkerWidget({super.key, required this.latlong, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.arrow_drop_down,
              color: Color.fromARGB(255, 22, 97, 158),
              size: 75,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:Color.fromARGB(255, 22, 97, 158),
            ),
            width: 50,
            height: 25,
            margin: const EdgeInsets.only(top: 5),
            // padding: const EdgeInsets.all(5),
            child: Center(
              child: Column(children: <Widget>[
                Row(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1,top: 1),
                      child: Container(
                        child: Icon(
                          Icons.bolt,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:2.0),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          child: Center(
                            child: Text(
                              '$title',
                              style: TextStyle(color: Colors.white, fontSize: 6),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:1.0),
                        child: Container(
                          child: Center(
                            child: Text(
                              '$latlong',
                              style: TextStyle(color: Colors.white, fontSize: 5),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                ]),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
