import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineTwoScreen extends StatefulWidget {
  const PolylineTwoScreen({Key? key}) : super(key: key);

  @override
  _PolylineTwoScreenState createState() => _PolylineTwoScreenState();
}

class _PolylineTwoScreenState extends State<PolylineTwoScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(33.738045, 73.084488),
    LatLng(33.567997728, 72.635997456)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < latlng.length; i++) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: 'Really cool place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
        _polyline.add(Polyline(
          polylineId: PolylineId(i.toString()),
          visible: true,
          points: latlng,
          color: Colors.blue,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: GoogleMap(

            polylines: _polyline,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,

            mapType: MapType.normal,
          )),
    );
  }
}
