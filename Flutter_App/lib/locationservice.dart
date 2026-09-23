import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  StreamSubscription<Position>? _positionStreamSubscription;

  // Django server URL to POST location data
  final String serverUrl = "http://192.168.29.140:1234/updatelocation";

  // Start listening to location updates
  Future<void> startLocationUpdates(String userId) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    // Check for permission, request if not granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    // Subscribe to position updates
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // meters - update only if moved 10 meters
      ),
    ).listen((Position position) {

      _sendLocationToServer(position, userId);
    });
  }

  // Stop listening to location updates
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }
  Function(String)? onNotificationMessage;

  // Send location data to Django server via POST
  Future<void> _sendLocationToServer(Position position, String userId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString("latitude", position.latitude.toString());
      sh.setString("longitude", position.longitude.toString());
      final response = await http.post(
        Uri.parse(serverUrl),
        body: {
          'user_id': userId,
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
        },
      );

      if (response.statusCode == 200) {
        onNotificationMessage?.call("📍 Location updated");

        print('Location updated successfully');
      } else {
        print('Failed to update location. Server responded with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
