import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:mobbdeep/locationmodel.dart';
import 'package:mobbdeep/geolocation.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location detection permissions are prohibited.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently banned, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

Future<LocationModel> getLocation() async {
  var coords = await determinePosition();
  var data = {"lat": coords.latitude, "lon": coords.longitude};
  Map<String, dynamic> address = json.decode(await getAddress(data));

  return LocationModel(
      coords.latitude, coords.longitude, address['suggestions'][0]["value"]);
}
