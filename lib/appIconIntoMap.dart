import 'package:flutter/material.dart';
import 'package:google_map/polygon.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.map), // Map icon in the AppBar
            onPressed: () {
              // Navigate to the map screen when the icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PolygoneScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Click the map icon to open the Google Map'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          // Navigate to the map screen when the floating action button is clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PolygoneScreen()),
          );
        },
      ),
    );
  }
}
