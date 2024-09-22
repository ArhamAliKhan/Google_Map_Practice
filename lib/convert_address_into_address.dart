import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertAddressIntoAddress extends StatefulWidget {
  const ConvertAddressIntoAddress({super.key});

  @override
  State<ConvertAddressIntoAddress> createState() =>
      _ConvertAddressIntoAddressState();
}

class _ConvertAddressIntoAddressState extends State<ConvertAddressIntoAddress> {
  String coordinates = 'Tap to get Coordinates';
  Future<void> getCoordinates(String address) async {
    try {
      List<Location> _location = await locationFromAddress(address);
      print('Location: $_location'); // Debug print statement
      if (_location.isNotEmpty) {
        Location location = _location.first;
        setState(() {
          coordinates =
              "Latitude: ${location.latitude}, Longitude: ${location.longitude}";
        });
      } else {
        setState(() {
          coordinates = "No coordinates found";
        });
      }
    } catch (e) {
      print('Error: $e'); // Debug print statement
      setState(() {
        coordinates = "Error while fetching coordinates: ${e.toString()}";
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // print(coordinates),
          Center(
            child: GestureDetector(
              onTap: () {
                getCoordinates('Gronausestraat 710, Enschede');
              },
              child: Container(
                height: 50,
                width: 250,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    'Convert',
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(coordinates),
          )
        ],
      ),
    );
  }
}
