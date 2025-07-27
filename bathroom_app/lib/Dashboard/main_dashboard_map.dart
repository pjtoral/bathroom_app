import 'package:bathroom_app/Dashboard/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bathroom_app/Dashboard/main_dashboard_widget.dart';
import 'package:bathroom_app/Dashboard/map_utils/map_marker.dart';
import 'package:bathroom_app/Dashboard/map_utils/map_data.dart';
import 'package:bathroom_app/Dashboard/mini_account.dart';

class DashboardMap extends StatefulWidget {
  const DashboardMap({super.key});

  @override
  State<DashboardMap> createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMap> {
  static const LatLng tempLocation = LatLng(10.3280, 123.9063);
  bool _showAccountPopup = false;

  String? _mapStyle;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final style = await rootBundle.loadString('assets/map_config.json');
    setState(() {
      _mapStyle = style;
    });

    await MapMarkerUtils.loadCustomIcon();

    _loadMarkers();

    setState(() {});
  }

  void _loadMarkers() {
    for (var markerInfo in MapData.markerData) {
      final marker = MapMarkerUtils.createMarker(
        id: markerInfo['id'],
        title: markerInfo['title'],
        position: markerInfo['position'],
        onTap: () {
          // TODO: call here the page for displaying place info
        },
      );
      _markers.add(marker);
    }
  }

  void _togglePopup() {
    setState(() {
      _showAccountPopup = !_showAccountPopup;
    });
  }

  void _dismissPopup() {
    if (_showAccountPopup) {
      setState(() {
        _showAccountPopup = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_mapStyle != null)
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: tempLocation,
                  zoom: 16,
                ),
                markers: _markers,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: (controller) {
                  controller.setMapStyle(_mapStyle);
                },
              ),
            ),
          const MainDashboardWidget(),
          AccountIcon(),
        ],
      ),
    );
  }
}
