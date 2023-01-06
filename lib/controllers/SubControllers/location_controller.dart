import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  late Position _position;

  Position get position => _position;

  ///
  late Position _pickedPosition;

  Position get pickedPosition => _pickedPosition;

  ///
  Placemark _placemark = Placemark();

  Placemark get placemark => _placemark;

  Placemark _pickePlacemark = Placemark();

  Placemark get pickePlacemark => _pickePlacemark;

  late GoogleMapController _mapController;

  ///
  bool _isUpdate = true;

  ///
  bool _loading = false;

  bool get loading => _loading;

  void setMapController({required GoogleMapController mapController}) {
    _mapController = mapController;
  }

  void updatePosition({required CameraPosition position, required bool isUi}) {
    if (_isUpdate) {
      _loading = true;
      update();
      try {
        if (isUi) {
          _position = _getPosition(position);
        } else {
          _pickedPosition = _getPosition(position);
        }
      } catch (e) {
      }
    }
  }

  Position _getPosition(CameraPosition position) {
    return Position(
      latitude: position.target.latitude,
      longitude: position.target.longitude,
      timestamp: DateTime.now(),
      heading: 1,
      accuracy: 1,
      altitude: 1,
      speedAccuracy: 1,
      speed: 1,
    );
  }
}
