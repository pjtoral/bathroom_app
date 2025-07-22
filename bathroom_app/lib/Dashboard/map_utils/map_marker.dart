import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
}
