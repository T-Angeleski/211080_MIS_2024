import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:lab4_211080/models/event.dart";

class EventMapScreen extends StatelessWidget {
  final List<Event> events;

  const EventMapScreen({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = events.map((event) {
      return Marker(
        markerId: MarkerId(event.name),
        position: LatLng(event.latitude, event.longitude),
        infoWindow: InfoWindow(title: event.name),
      );
    }).toSet();

    return Scaffold(
      appBar: AppBar(title: const Text('Event Locations')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(42.00485471128647, 21.40979237419658),
          zoom: 10,
        ),
        markers: markers,
      ),
    );
  }
}
