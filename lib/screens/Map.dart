import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Profile.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String nickname = ''; // Nickname for the location

  @override
  void initState() {
    super.initState();
    _getInitialLocation();
    _loadMarkerPosition(); // Load the marker position from SharedPreferences
  }

  Future<void> _getInitialLocation() async {
    // Request location permission
    final PermissionStatus status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle permission denied case
      return;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _markerPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadMarkerPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final double? latitude = prefs.getDouble('markerLatitude');
    final double? longitude = prefs.getDouble('markerLongitude');
    if (latitude != null && longitude != null) {
      setState(() {
        _markerPosition = LatLng(latitude, longitude);
      });
    }
  }

  Future<void> _saveMarkerPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('markerLatitude', _markerPosition.latitude);
    await prefs.setDouble('markerLongitude', _markerPosition.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarker(); // Add the marker when the map is created
  }

  void _addMarker() {
    setState(() {
      _markers.clear(); // Remove any existing markers

      _markers.add(
        Marker(
          markerId: const MarkerId('marker_1'),
          position: _markerPosition,
          draggable: true, // Make the marker draggable
          onDragEnd: (LatLng newPosition) {
            // Update the marker position when dragged
            setState(() {
              _markerPosition = newPosition;
            });
          },
          infoWindow: const InfoWindow(
            title: 'Location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(0.0), // Red marker icon
        ),
      );
    });
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = placemark.street ?? '';
        address += placemark.subLocality != null ? ', ${placemark.subLocality}' : '';
        address += placemark.locality != null ? ', ${placemark.locality}' : '';
        address += placemark.subAdministrativeArea != null ? ', ${placemark.subAdministrativeArea}' : '';
        address += placemark.administrativeArea != null ? ', ${placemark.administrativeArea}' : '';
        address += placemark.postalCode != null ? ', ${placemark.postalCode}' : '';
        address += placemark.country != null ? ', ${placemark.country}' : '';
        return address;
      }
    } catch (e) {
      print(e);
    }

    return ''; // Return an empty string if no address is found or an error occurs
  }

  Future<void> _submitLocation() async {
    await _saveMarkerPosition(); // Save the marker position in SharedPreferences
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location saved')),
    );

    String savedLocations = await _getAddressFromLatLng(_markerPosition);

    // Get the current authenticated user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
    // Get a reference to the MapDetails collection for the user
    final CollectionReference mapDetailsRef =
        FirebaseFirestore.instance.collection('MapDetails');

    // Create a new document in the MapDetails collection
    final DocumentReference newLocationRef = mapDetailsRef.doc();

    // Add the location details to the new document
    await newLocationRef.set({
      'latitude': _markerPosition.latitude,
      'longitude': _markerPosition.longitude,
      'address': savedLocations,
      'nickname': nickname,
      'userId': user.uid,
    });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(
            
          ),
          // Pass the saved location and nickname to the Profile page
        ),
      );
    }
  }
  Widget buildPortraitLayout(ThemeProvider themeProvider) {
    return Scaffold(
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<String>(
                    future: _getAddressFromLatLng(_markerPosition),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ${snapshot.data}',
                          
                              style: const TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: nickname,
                              onChanged: (value) {
                                setState(() {
                                  nickname = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Nickname',
                          
                                hintText: 'Enter a nickname for the location',
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _submitLocation,
                              child: const Text('Submit'),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Failed to get address');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLandscapeLayout(ThemeProvider themeProvider) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers, // Set the markers on the map
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location Details:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<String>(
                    future: _getAddressFromLatLng(_markerPosition),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ${snapshot.data}',
                              style: const TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: nickname,
                              onChanged: (value) {
                                setState(() {
                                  nickname = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Nickname',
                                hintText: 'Enter a nickname for the location',
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _submitLocation,
                              child: const Text('Submit'),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Failed to get address');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? buildPortraitLayout(themeProvider)
            : buildLandscapeLayout(themeProvider);
      },
    );
  }
}


