import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  static final CameraPosition _kMap =
      CameraPosition(target: LatLng(33.768775, 72.824921), zoom: 14);

  Completer<GoogleMapController> _controller = Completer();

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  List<Marker> _marker = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.768775, 72.824921),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kMap,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print('Current Position: ');
            print(value.latitude.toString() + " " + value.longitude.toString());
            _marker.add(Marker(
              markerId: MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
            ));
            CameraPosition newCameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 15,
            );
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(newCameraPosition));
            setState(() {});
          });
        },
        child: const Icon(
          Icons.location_disabled_outlined,
        ),
      ),
    );
  }
}
