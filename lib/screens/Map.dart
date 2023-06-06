import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Settings.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  LatLng _markerPosition = const LatLng(45.521563, -122.677433); // Updated marker position
  final Set<Marker> _markers = {}; // Set to store the markers

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarker(); // Add the marker when the map is created
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_1'),
          position: _markerPosition,
          draggable: true, // Make the marker draggable
          onDragEnd: (LatLng newPosition) {
            // Update the marker position when dragged
            setState(() {
              _markerPosition = newPosition;
            });
          },
          infoWindow: const InfoWindow(
            title: 'Marker Title',
            snippet: 'Marker Snippet',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(0.0), // Red marker icon
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
        elevation: 2,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: _markers, // Set the markers on the map
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location Details:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Latitude: ${_markerPosition.latitude.toStringAsFixed(6)}',
                  ),
                  Text(
                    'Longitude: ${_markerPosition.longitude.toStringAsFixed(6)}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
