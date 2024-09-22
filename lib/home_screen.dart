// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   static final CameraPosition _kMap = CameraPosition(
//     target: LatLng(33.768775, 72.824921),
//     zoom: 14,
//   );
//   List<Marker> _marker = [];
//
//   Completer<GoogleMapController> _controller = Completer();
//   LatLng _currentPosition = LatLng(33.768775, 72.824931);
//   LatLng _newPosition = LatLng(33.768775, 72.824928);
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _marker.add(
//       Marker(
//         markerId: MarkerId(
//           '_currentPosition',
//         ),
//         position: _currentPosition,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: _kMap,
//         markers: Set<Marker>.of(_marker),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.location_disabled_outlined),
//         onPressed: () async {
//           GoogleMapController controller = await _controller.future;
//           controller.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: _newPosition,
//                 zoom: 15,
//               ),
//             ),
//           );
//           setState(() {
//             _marker.add(
//               Marker(
//                   markerId: MarkerId('_newPosition'),
//                   position: _newPosition,
//                   infoWindow: InfoWindow(
//                     title: 'New Position',
//                   )),
//             );
//           });
//         },
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kMap = CameraPosition(
    target: LatLng(33.768775, 72.824921),
    zoom: 14,
  );

  List<Marker> _markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kMap,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(33.768775, 72.824928),
                zoom: 15,
              ),
            ),
          );
          setState(() {
            _markers.add(Marker(
                markerId: MarkerId('2'),
                position: LatLng(33.768775, 72.824928),
                infoWindow: InfoWindow(
                  title: 'New Position',
                )));
          });
        },
        child: Icon(
          Icons.location_disabled_outlined,
        ),
      ),
    );
  }
}
