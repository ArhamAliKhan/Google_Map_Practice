import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerWindowInfo extends StatefulWidget {
  const CustomMarkerWindowInfo({Key? key}) : super(key: key);

  @override
  _CustomMarkerWindowInfoState createState() => _CustomMarkerWindowInfoState();
}

class _CustomMarkerWindowInfoState extends State<CustomMarkerWindowInfo> {
  final Completer<GoogleMapController> _controller = Completer();

  List<String> images = [
    'images/car1.png',
    'images/car2.png',
    'images/car3.png',
    'images/car4.png',
    'images/car5.png',
    'images/car6.png',
  ];

  final List<LatLng> _latLang = <LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785)
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final List<Marker> markers = [];
    for (int i = 0; i < images.length; i++) {
      final BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLang[i],
        icon: markerIcon,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(images[i],
                        width: 100, height: 100), // Display image here
                    SizedBox(height: 10),
                    Text('Marker ${i + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Details about this marker go here.'),
                  ],
                ),
              );
            },
          );
        },
      ));
    }

    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Custom Marker'),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
