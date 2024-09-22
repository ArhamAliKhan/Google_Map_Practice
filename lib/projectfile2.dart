// // // // // import 'dart:async';
// // // // //
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:geolocator/geolocator.dart';
// // // // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // // //
// // // // // class ProjectFile2 extends StatefulWidget {
// // // // //   const ProjectFile2({super.key});
// // // // //
// // // // //   @override
// // // // //   State<ProjectFile2> createState() => _ProjectFile2State();
// // // // // }
// // // // //
// // // // // class _ProjectFile2State extends State<ProjectFile2> {
// // // // //   Completer<GoogleMapController> _controller = Completer();
// // // // //
// // // // //   // Bakery location in San Francisco
// // // // //   final LatLng _bakeryLocation = LatLng(37.7749, -122.4194);
// // // // //
// // // // //   // Initial Camera Position
// // // // //   CameraPosition? _kMap;
// // // // //
// // // // //   final Set<Marker> _markers = {};
// // // // //   final Set<Polyline> _polylines = {};
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _kMap = CameraPosition(
// // // // //       target: _bakeryLocation,
// // // // //       zoom: 14,
// // // // //     );
// // // // //
// // // // //     // Add marker for bakery location
// // // // //     _markers.add(Marker(
// // // // //       markerId: MarkerId('bakery'),
// // // // //       position: _bakeryLocation,
// // // // //       infoWindow: InfoWindow(title: 'Bakery Location'),
// // // // //     ));
// // // // //   }
// // // // //
// // // // //   // Get the user's current location
// // // // //   Future<Position> _getUserCurrentLocation() async {
// // // // //     bool serviceEnabled;
// // // // //     LocationPermission permission;
// // // // //
// // // // //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// // // // //     if (!serviceEnabled) {
// // // // //       return Future.error('Location services are disabled.');
// // // // //     }
// // // // //
// // // // //     permission = await Geolocator.checkPermission();
// // // // //     if (permission == LocationPermission.denied) {
// // // // //       permission = await Geolocator.requestPermission();
// // // // //       if (permission == LocationPermission.denied) {
// // // // //         return Future.error('Location permissions are denied');
// // // // //       }
// // // // //     }
// // // // //
// // // // //     if (permission == LocationPermission.deniedForever) {
// // // // //       return Future.error('Location permissions are permanently denied.');
// // // // //     }
// // // // //
// // // // //     return await Geolocator.getCurrentPosition(
// // // // //         desiredAccuracy: LocationAccuracy.high);
// // // // //   }
// // // // //
// // // // //   // Calculate distance and draw route
// // // // //   void _calculateDistanceAndRoute(Position userLocation) {
// // // // //     double distance = Geolocator.distanceBetween(
// // // // //           userLocation.latitude,
// // // // //           userLocation.longitude,
// // // // //           _bakeryLocation.latitude,
// // // // //           _bakeryLocation.longitude,
// // // // //         ) /
// // // // //         1000; // Convert to kilometers
// // // // //
// // // // //     // Add user location marker
// // // // //     setState(() {
// // // // //       _markers.add(Marker(
// // // // //         markerId: MarkerId('userLocation'),
// // // // //         position: LatLng(userLocation.latitude, userLocation.longitude),
// // // // //         infoWindow: InfoWindow(title: 'Your Location'),
// // // // //       ));
// // // // //
// // // // //       // Add polyline for route
// // // // //       _polylines.add(Polyline(
// // // // //         polylineId: PolylineId('route'),
// // // // //         color: Colors.blue,
// // // // //         width: 5,
// // // // //         points: [
// // // // //           LatLng(userLocation.latitude, userLocation.longitude),
// // // // //           _bakeryLocation,
// // // // //         ],
// // // // //       ));
// // // // //     });
// // // // //
// // // // //     // Move the camera to the user's location
// // // // //     _controller.future.then((controller) {
// // // // //       controller.animateCamera(
// // // // //         CameraUpdate.newCameraPosition(
// // // // //           CameraPosition(
// // // // //             target: LatLng(userLocation.latitude, userLocation.longitude),
// // // // //             zoom: 15,
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     });
// // // // //
// // // // //     // Show distance on a snackbar or dialog
// // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // //       SnackBar(
// // // // //         content: Text('Distance to bakery: ${distance.toStringAsFixed(2)} km'),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('User Location'),
// // // // //       ),
// // // // //       body: GoogleMap(
// // // // //         initialCameraPosition: _kMap!,
// // // // //         markers: _markers,
// // // // //         polylines: _polylines,
// // // // //         onMapCreated: (GoogleMapController controller) {
// // // // //           _controller.complete(controller);
// // // // //         },
// // // // //         myLocationEnabled: true,
// // // // //       ),
// // // // //       floatingActionButton: FloatingActionButton(
// // // // //         onPressed: () {
// // // // //           _getUserCurrentLocation().then((value) {
// // // // //             _calculateDistanceAndRoute(value);
// // // // //           }).catchError((error) {
// // // // //             print("Error fetching location: $error");
// // // // //           });
// // // // //         },
// // // // //         child: const Icon(
// // // // //           Icons.my_location,
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // // import 'dart:async';
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:geolocator/geolocator.dart';
// // // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // //
// // // // class ProjectFile2 extends StatefulWidget {
// // // //   const ProjectFile2({super.key});
// // // //
// // // //   @override
// // // //   State<ProjectFile2> createState() => _ProjectFile2State();
// // // // }
// // // //
// // // // class _ProjectFile2State extends State<ProjectFile2> {
// // // //   Completer<GoogleMapController> _controller = Completer();
// // // //
// // // //   // Bakery location in San Francisco
// // // //   final LatLng _bakeryLocation = LatLng(37.7749, -122.4194);
// // // //
// // // //   // Initial Camera Position
// // // //   CameraPosition? _kMap;
// // // //
// // // //   final Set<Marker> _markers = {};
// // // //   final Set<Polyline> _polylines = {};
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _kMap = CameraPosition(
// // // //       target: _bakeryLocation,
// // // //       zoom: 14,
// // // //     );
// // // //
// // // //     // Add marker for bakery location
// // // //     _markers.add(Marker(
// // // //       markerId: MarkerId('bakery'),
// // // //       position: _bakeryLocation,
// // // //       infoWindow: InfoWindow(title: 'Bakery Location'),
// // // //     ));
// // // //   }
// // // //
// // // //   // Get the user's current location
// // // //   Future<Position> _getUserCurrentLocation() async {
// // // //     bool serviceEnabled;
// // // //     LocationPermission permission;
// // // //
// // // //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// // // //     if (!serviceEnabled) {
// // // //       return Future.error('Location services are disabled.');
// // // //     }
// // // //
// // // //     permission = await Geolocator.checkPermission();
// // // //     if (permission == LocationPermission.denied) {
// // // //       permission = await Geolocator.requestPermission();
// // // //       if (permission == LocationPermission.denied) {
// // // //         return Future.error('Location permissions are denied');
// // // //       }
// // // //     }
// // // //
// // // //     if (permission == LocationPermission.deniedForever) {
// // // //       return Future.error('Location permissions are permanently denied.');
// // // //     }
// // // //
// // // //     return await Geolocator.getCurrentPosition(
// // // //         desiredAccuracy: LocationAccuracy.high);
// // // //   }
// // // //
// // // //   // Calculate distance and draw route
// // // //   void _calculateDistanceAndRoute(Position userLocation) {
// // // //     double distance = Geolocator.distanceBetween(
// // // //           userLocation.latitude,
// // // //           userLocation.longitude,
// // // //           _bakeryLocation.latitude,
// // // //           _bakeryLocation.longitude,
// // // //         ) /
// // // //         1000; // Convert to kilometers
// // // //
// // // //     // Add user location marker
// // // //     setState(() {
// // // //       _markers.add(Marker(
// // // //         markerId: MarkerId('userLocation'),
// // // //         position: LatLng(userLocation.latitude, userLocation.longitude),
// // // //         infoWindow: InfoWindow(title: 'Your Location'),
// // // //       ));
// // // //
// // // //       // Add polyline for route
// // // //       _polylines.add(Polyline(
// // // //         polylineId: PolylineId('route'),
// // // //         color: Colors.blue,
// // // //         width: 5,
// // // //         points: [
// // // //           LatLng(userLocation.latitude, userLocation.longitude),
// // // //           _bakeryLocation,
// // // //         ],
// // // //       ));
// // // //     });
// // // //
// // // //     // Move the camera to the user's location
// // // //     _controller.future.then((controller) {
// // // //       controller.animateCamera(
// // // //         CameraUpdate.newCameraPosition(
// // // //           CameraPosition(
// // // //             target: LatLng(userLocation.latitude, userLocation.longitude),
// // // //             zoom: 15,
// // // //           ),
// // // //         ),
// // // //       );
// // // //     });
// // // //
// // // //     // Show distance on a snackbar or dialog
// // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // //       SnackBar(
// // // //         content: Text('Distance to bakery: ${distance.toStringAsFixed(2)} km'),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('User Location'),
// // // //       ),
// // // //       body: GoogleMap(
// // // //         initialCameraPosition: _kMap!,
// // // //         markers: _markers,
// // // //         polylines: _polylines,
// // // //         onMapCreated: (GoogleMapController controller) {
// // // //           _controller.complete(controller);
// // // //         },
// // // //         myLocationEnabled: true,
// // // //       ),
// // // //       floatingActionButton: FloatingActionButton(
// // // //         onPressed: () {
// // // //           _getUserCurrentLocation().then((value) {
// // // //             _calculateDistanceAndRoute(value);
// // // //           }).catchError((error) {
// // // //             print("Error fetching location: $error");
// // // //           });
// // // //         },
// // // //         child: const Icon(
// // // //           Icons.my_location,
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'dart:async';
// // // import 'dart:convert';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:geolocator/geolocator.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:http/http.dart' as http;
// // //
// // // class ProjectFile2 extends StatefulWidget {
// // //   const ProjectFile2({super.key});
// // //
// // //   @override
// // //   State<ProjectFile2> createState() => _ProjectFile2State();
// // // }
// // //
// // // class _ProjectFile2State extends State<ProjectFile2> {
// // //   Completer<GoogleMapController> _controller = Completer();
// // //   final LatLng _bakeryLocation = LatLng(37.7749, -122.4194); // Bakery Location
// // //
// // //   CameraPosition? _kMap;
// // //   final Set<Marker> _markers = {};
// // //   final Set<Polyline> _polylines = {};
// // //   final String _apiKey =
// // //       "AIzaSyADc-hgN47Q1JXNHEkz76XYOczRqmqGplQ"; // Add your API Key here
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _kMap = CameraPosition(
// // //       target: _bakeryLocation,
// // //       zoom: 14,
// // //     );
// // //
// // //     // Add marker for bakery location
// // //     _markers.add(Marker(
// // //       markerId: MarkerId('bakery'),
// // //       position: _bakeryLocation,
// // //       infoWindow: InfoWindow(title: 'Bakery Location'),
// // //     ));
// // //   }
// // //
// // //   // Get the user's current location
// // //   Future<Position> _getUserCurrentLocation() async {
// // //     bool serviceEnabled;
// // //     LocationPermission permission;
// // //
// // //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// // //     if (!serviceEnabled) {
// // //       return Future.error('Location services are disabled.');
// // //     }
// // //
// // //     permission = await Geolocator.checkPermission();
// // //     if (permission == LocationPermission.denied) {
// // //       permission = await Geolocator.requestPermission();
// // //       if (permission == LocationPermission.denied) {
// // //         return Future.error('Location permissions are denied');
// // //       }
// // //     }
// // //
// // //     if (permission == LocationPermission.deniedForever) {
// // //       return Future.error('Location permissions are permanently denied.');
// // //     }
// // //
// // //     return await Geolocator.getCurrentPosition(
// // //         desiredAccuracy: LocationAccuracy.high);
// // //   }
// // //
// // //   // Fetch Directions from Google Directions API
// // //   Future<void> _getDirections(Position userLocation) async {
// // //     final String url =
// // //         'https://maps.googleapis.com/maps/api/directions/json?origin=${userLocation.latitude},${userLocation.longitude}&destination=${_bakeryLocation.latitude},${_bakeryLocation.longitude}&key=$_apiKey';
// // //
// // //     final response = await http.get(Uri.parse(url));
// // //
// // //     if (response.statusCode == 200) {
// // //       final data = json.decode(response.body);
// // //
// // //       if (data['status'] == 'OK') {
// // //         List<LatLng> polylineCoordinates = [];
// // //
// // //         var steps = data['routes'][0]['legs'][0]['steps'];
// // //         for (var step in steps) {
// // //           polylineCoordinates.add(LatLng(
// // //             step['start_location']['lat'],
// // //             step['start_location']['lng'],
// // //           ));
// // //           polylineCoordinates.add(LatLng(
// // //             step['end_location']['lat'],
// // //             step['end_location']['lng'],
// // //           ));
// // //         }
// // //
// // //         setState(() {
// // //           _polylines.add(Polyline(
// // //             polylineId: PolylineId('route'),
// // //             color: Colors.blue,
// // //             width: 5,
// // //             points: polylineCoordinates,
// // //           ));
// // //         });
// // //
// // //         // Move the camera to the user's location
// // //         _controller.future.then((controller) {
// // //           controller.animateCamera(
// // //             CameraUpdate.newCameraPosition(
// // //               CameraPosition(
// // //                 target: LatLng(userLocation.latitude, userLocation.longitude),
// // //                 zoom: 15,
// // //               ),
// // //             ),
// // //           );
// // //         });
// // //       } else {
// // //         print("Directions API error: ${data['status']}");
// // //       }
// // //     } else {
// // //       print("Failed to fetch directions: ${response.statusCode}");
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('User Location & Directions'),
// // //       ),
// // //       body: GoogleMap(
// // //         initialCameraPosition: _kMap!,
// // //         markers: _markers,
// // //         polylines: _polylines,
// // //         onMapCreated: (GoogleMapController controller) {
// // //           _controller.complete(controller);
// // //         },
// // //         myLocationEnabled: true,
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () {
// // //           _getUserCurrentLocation().then((value) {
// // //             _getDirections(value);
// // //           }).catchError((error) {
// // //             print("Error fetching location: $error");
// // //           });
// // //         },
// // //         child: const Icon(
// // //           Icons.directions,
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'dart:async';
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:http/http.dart' as http;
// //
// // class ProjectFile2 extends StatefulWidget {
// //   const ProjectFile2({super.key});
// //
// //   @override
// //   State<ProjectFile2> createState() => _ProjectFile2State();
// // }
// //
// // class _ProjectFile2State extends State<ProjectFile2> {
// //   Completer<GoogleMapController> _controller = Completer();
// //   final LatLng _bakeryLocation = LatLng(37.7749, -122.4194); // Bakery Location
// //   CameraPosition? _kMap;
// //   final Set<Marker> _markers = {};
// //   final Set<Polyline> _polylines = {};
// //   final String _apiKey =
// //       "AIzaSyADc-hgN47Q1JXNHEkz76XYOczRqmqGplQ"; // Add your API Key here
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _kMap = CameraPosition(
// //       target: _bakeryLocation,
// //       zoom: 14,
// //     );
// //
// //     // Add marker for bakery location
// //     _markers.add(Marker(
// //       markerId: MarkerId('bakery'),
// //       position: _bakeryLocation,
// //       infoWindow: InfoWindow(title: 'Bakery Location'),
// //     ));
// //   }
// //
// //   // Get the user's current location
// //   Future<Position> _getUserCurrentLocation() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;
// //
// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       return Future.error('Location services are disabled.');
// //     }
// //
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         return Future.error('Location permissions are denied');
// //       }
// //     }
// //
// //     if (permission == LocationPermission.deniedForever) {
// //       return Future.error('Location permissions are permanently denied.');
// //     }
// //
// //     return await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high);
// //   }
// //
// //   // Fetch Directions from Google Directions API
// //   Future<void> _getDirections(Position userLocation) async {
// //     final String url =
// //         'https://maps.googleapis.com/maps/api/directions/json?origin=${userLocation.latitude},${userLocation.longitude}&destination=${_bakeryLocation.latitude},${_bakeryLocation.longitude}&key=$_apiKey';
// //
// //     final response = await http.get(Uri.parse(url));
// //
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //
// //       if (data['status'] == 'OK') {
// //         List<LatLng> polylineCoordinates = [];
// //
// //         var steps = data['routes'][0]['legs'][0]['steps'];
// //         for (var step in steps) {
// //           polylineCoordinates.add(LatLng(
// //             step['start_location']['lat'],
// //             step['start_location']['lng'],
// //           ));
// //           polylineCoordinates.add(LatLng(
// //             step['end_location']['lat'],
// //             step['end_location']['lng'],
// //           ));
// //         }
// //
// //         setState(() {
// //           _polylines.add(Polyline(
// //             polylineId: PolylineId('route'),
// //             color: Colors.blue,
// //             width: 5,
// //             points: polylineCoordinates,
// //           ));
// //         });
// //       }
// //     } else {
// //       throw Exception('Failed to load directions');
// //     }
// //   }
// //
// //   // Calculate distance and draw route
// //   void _calculateDistanceAndRoute(Position userLocation) async {
// //     double distance = Geolocator.distanceBetween(
// //           userLocation.latitude,
// //           userLocation.longitude,
// //           _bakeryLocation.latitude,
// //           _bakeryLocation.longitude,
// //         ) /
// //         1000; // Convert to kilometers
// //
// //     // Add user location marker
// //     setState(() {
// //       _markers.add(Marker(
// //         markerId: MarkerId('userLocation'),
// //         position: LatLng(userLocation.latitude, userLocation.longitude),
// //         infoWindow: InfoWindow(title: 'Your Location'),
// //       ));
// //     });
// //
// //     // Fetch directions and draw the route
// //     await _getDirections(userLocation);
// //
// //     // Move the camera to the user's location
// //     _controller.future.then((controller) {
// //       controller.animateCamera(
// //         CameraUpdate.newCameraPosition(
// //           CameraPosition(
// //             target: LatLng(userLocation.latitude, userLocation.longitude),
// //             zoom: 15,
// //           ),
// //         ),
// //       );
// //     });
// //
// //     // Show distance on a snackbar
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('Distance to bakery: ${distance.toStringAsFixed(2)} km'),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('User Location'),
// //       ),
// //       body: GoogleMap(
// //         initialCameraPosition: _kMap!,
// //         markers: _markers,
// //         polylines: _polylines,
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller.complete(controller);
// //         },
// //         myLocationEnabled: true,
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           _getUserCurrentLocation().then((value) {
// //             _calculateDistanceAndRoute(value);
// //           }).catchError((error) {
// //             print("Error fetching location: $error");
// //           });
// //         },
// //         child: const Icon(
// //           Icons.my_location,
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http; // For API requests
//
// class ProjectFile2 extends StatefulWidget {
//   @override
//   State<ProjectFile2> createState() => ProjectFile2State();
// }
//
// class ProjectFile2State extends State<ProjectFile2> {
//   late GoogleMapController mapController;
//   final LatLng _origin =
//       LatLng(37.77483, -122.41942); // Example origin (San Francisco)
//   final LatLng _destination =
//       LatLng(34.05223, -118.24368); // Example destination (Los Angeles)
//
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   bool _showDistanceOnMap = false; // Control visibility of distance on the map
//   String _distance = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _setMarkersAndPolylines();
//   }
//
//   void _setMarkersAndPolylines() {
//     // Set the markers for origin and destination
//     _markers.add(Marker(
//       markerId: MarkerId('origin'),
//       position: _origin,
//     ));
//     _markers.add(Marker(
//       markerId: MarkerId('destination'),
//       position: _destination,
//     ));
//
//     // Fetch the route and set polylines
//     _fetchRoute();
//   }
//
//   Future<void> _fetchRoute() async {
//     String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.latitude},${_origin.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$apiKey';
//
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       List<dynamic> routes = data['routes'];
//       if (routes.isNotEmpty) {
//         // Extract the polyline points from the API response
//         String polylinePoints = routes[0]['overview_polyline']['points'];
//         List<LatLng> polylineCoordinates = _decodePolyline(polylinePoints);
//
//         setState(() {
//           _polylines.add(Polyline(
//             polylineId: PolylineId('route'),
//             points: polylineCoordinates,
//             color: Colors.blue,
//             width: 5,
//           ));
//
//           // Calculate the distance
//           _distance = routes[0]['legs'][0]['distance']['text'];
//         });
//       }
//     } else {
//       throw Exception('Failed to fetch route');
//     }
//   }
//
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> polyline = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;
//
//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//       lat += dlat;
//
//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//       lng += dlng;
//
//       polyline.add(LatLng(lat / 1E5, lng / 1E5));
//     }
//
//     return polyline;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps with Directions'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _origin,
//               zoom: 6, // Zoom level to show both points
//             ),
//             markers: _markers,
//             polylines: _polylines,
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//           ),
//           if (_showDistanceOnMap)
//             Positioned(
//               bottom: 50,
//               left: 10,
//               child: Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.all(8),
//                 child: Text(
//                   'Distance: $_distance',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _showDistanceOnMap = true;
//           });
//         },
//         child: Icon(Icons.directions),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProjectFile2 extends StatefulWidget {
  @override
  _ProjectFile2State createState() => _ProjectFile2State();
}

class _ProjectFile2State extends State<ProjectFile2> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Map Example'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.77483, -122.41942), // San Francisco
          zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
