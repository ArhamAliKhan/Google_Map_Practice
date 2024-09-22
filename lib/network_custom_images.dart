import 'dart:async';
import 'dart:typed_data'; // For handling bytes
import 'dart:ui' as ui; // To decode images

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http; // For fetching network images

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({Key? key}) : super(key: key);

  @override
  _NetworkImageCustomMarkerState createState() =>
      _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();

  List<String> images = [
    'https://plus.unsplash.com/premium_photo-1673448391005-d65e815bd026?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1601134991665-a020399422e3?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1529589574731-3c3eb55d8b76?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1712016875004-6a4ad04d53e3?q=80&w=2066&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1540132586218-183f59221b4f?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1648183185045-7a5592e66e9c?q=80&w=2042&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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

  // Helper function to convert network image to BitmapDescriptor
  Future<BitmapDescriptor> _createCustomMarker(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Uint8List markerImageBytes = response.bodyBytes;
      final ui.Codec codec = await ui.instantiateImageCodec(markerImageBytes,
          targetWidth: 100); // Resize the marker image to a desired width
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedMarkerImage = byteData!.buffer.asUint8List();

      return BitmapDescriptor.fromBytes(resizedMarkerImage);
    } else {
      throw Exception('Failed to load network image');
    }
  }

  Future<void> loadData() async {
    final List<Marker> markers = [];
    for (int i = 0; i < images.length; i++) {
      final BitmapDescriptor markerIcon = await _createCustomMarker(images[i]);

      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLang[i],
        icon: markerIcon, // Custom marker icon from network image
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(images[i],
                        width: 100, height: 100), // Display network image
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
