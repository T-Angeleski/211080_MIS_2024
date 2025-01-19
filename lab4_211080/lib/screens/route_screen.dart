import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteScreen extends StatefulWidget {
  final double startLatitude;
  final double startLongitude;
  final double destinationLatitude;
  final double destinationLongitude;

  const RouteScreen({
    super.key,
    required this.startLatitude,
    required this.startLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
  });

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shortest Route')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.startLatitude, widget.startLongitude),
          zoom: 12,
        ),
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) async {
          await _drawRoute();
        },
      ),
    );
  }

  Future<void> _drawRoute() async {
    final polylinePoints = PolylinePoints();

    final apiKey = dotenv.env['MAPS_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      debugPrint('Google Maps API key is missing!');
      return;
    }

    final result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
            origin: PointLatLng(widget.startLatitude, widget.startLongitude),
            destination: PointLatLng(
                widget.destinationLatitude, widget.destinationLongitude),
            mode: TravelMode.walking),
        googleApiKey: apiKey);

    if (result.points.isNotEmpty) {
      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: result.points
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            color: Colors.blue,
            width: 3,
          ),
        );
      });
    }
  }
}
