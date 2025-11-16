import 'package:bathroom_app/Dashboard/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bathroom_app/Dashboard/main_bottom_panel/main_dashboard_widget.dart';
import 'package:bathroom_app/Dashboard/map_utils/map_marker.dart';
import 'package:bathroom_app/Dashboard/map_utils/map_data.dart';
import 'package:bathroom_app/Dashboard/account/mini_account.dart';
import 'package:bathroom_app/Dashboard/map_utils/map_marker_location_info.dart';

class DashboardMap extends StatefulWidget {
  const DashboardMap({super.key});

  @override
  State<DashboardMap> createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMap> {
  static const LatLng tempLocation = LatLng(10.3280, 123.9063);
  bool _showAccountPopup = false;
  bool _showBottomPanel = false;
  String? _mapStyle;
  GoogleMapController? _mapController;
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
        onTap: () => _onMarkerTapped(markerInfo['position']),
      );
      _markers.add(marker);
    }
  }

  void _onMarkerTapped(LatLng position) {
    setState(() {
      _showBottomPanel = true;
    });

    if (_mapController != null) {
      MapMarkerUtils.positionMarkerAbovePanel(
        controller: _mapController!,
        markerPosition: position,
        context: context,
        bottomPanelHeightPercent: 0.7,
      );
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
          // Map layer (bottom)
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
                  _mapController = controller;
                  controller.setMapStyle(_mapStyle);
                },
                onTap: (_) {
                  setState(() {
                    _showBottomPanel = false;
                  });
                },
              ),
            ),
          const MainDashboardWidget(),
          // Bottom panel (middle layer) - NO Positioned wrapper needed
          if (_showBottomPanel)
            const MapMarkerBottomPanel(
              initialChildSize: 0.7,
              minChildSize: 0.3,
              maxChildSize: 0.9,
            ),
          // Dashboard widgets (top layer)
          AccountIcon(),
        ],
      ),
    );
  }
}
