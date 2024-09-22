// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class ConvertorAddress extends StatefulWidget {
//   const ConvertorAddress({super.key});
//
//   @override
//   State<ConvertorAddress> createState() => _ConvertorAddressState();
// }
//
// class _ConvertorAddressState extends State<ConvertorAddress> {
//   String _address = 'Tap to get address';
//   Future<void> getAddress() async {
//     try {
//       final Coordinates = LatLng(33.768775, 72.824921);
//       List<Placemark> placeMark = await placemarkFromCoordinates(
//           Coordinates.latitude, Coordinates.longitude);
//       if (placeMark.isNotEmpty) {
//         Placemark place = placeMark.first;
//         setState(() {
//           _address =
//               "${place.name ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}";
//         });
//       } else {
//         setState(() {
//           _address = "No address found";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _address = "Error which fetching address: ${e}";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 getAddress();
//               },
//               child: Container(
//                 height: 50,
//                 width: 250,
//                 color: Colors.yellow,
//                 child: Center(
//                   child: Text(
//                     'Convert',
//                     style: TextStyle(color: Colors.black45),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: Text(_address),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertorAddress extends StatefulWidget {
  const ConvertorAddress({super.key});

  @override
  State<ConvertorAddress> createState() => _ConvertorAddressState();
}

class _ConvertorAddressState extends State<ConvertorAddress> {
  String _address = 'Tap to get Address';

  Future<void> getAddress() async {
    try {
      final coordinates = LatLng(33.768775, 72.824921);
      List<Placemark> placeMark = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      if (placeMark.isNotEmpty) {
        Placemark place = placeMark.first;
        setState(() {
          _address =
              '${place.name} + ${place.country} + ${place.administrativeArea} ';
        });
      } else {
        setState(() {
          _address = 'No address found';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Error while fetching data ${e}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: getAddress,
              child: Container(
                height: 50,
                width: 250,
                color: Colors.blue,
                child: Center(child: Text('Convert: ')),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(_address),
          )
        ],
      ),
    );
  }
}
