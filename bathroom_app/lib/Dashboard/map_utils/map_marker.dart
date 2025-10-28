import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class MapMarkerUtils {
  static BitmapDescriptor? _customIcon;

  static Future<void> loadCustomIcon() async {
    _customIcon ??= await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/images/default_marker.png',
    );
  }

  static Marker createMarker({
    required String id,
    required LatLng position,
    String? title,
    Function()? onTap,
    BitmapDescriptor? icon,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(title: title),
      icon: icon ?? _customIcon ?? BitmapDescriptor.defaultMarker,
      onTap: onTap,
    );
  }

  /// Positions the camera so the marker appears in the upper portion of the visible map
  /// above a bottom panel
  static Future<void> positionMarkerAbovePanel({
    required GoogleMapController controller,
    required LatLng markerPosition,
    required BuildContext context,
    double bottomPanelHeightPercent = 0.7,
  }) async {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPanelHeight = screenHeight * bottomPanelHeightPercent;
    final visibleMapHeight = screenHeight - bottomPanelHeight;

    // Position marker at 1/3 of the visible map area (upper portion)
    final targetY = visibleMapHeight * 0.66;

    // Calculate how much to offset the center to position marker at targetY
    final centerY = screenHeight / 2;
    final offsetPixels = centerY - targetY;

    // Convert pixel offset to latitude degrees
    final zoom = await controller.getZoomLevel();
    final scale =
        156543.03392 *
        math.cos(markerPosition.latitude * math.pi / 180) /
        math.pow(2, zoom);
    final latOffset = (offsetPixels * scale) / 111320;

    await controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(markerPosition.latitude - latOffset, markerPosition.longitude),
      ),
    );
  }
}
