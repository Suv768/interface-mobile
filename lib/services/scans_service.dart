import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/utils/map_constants.dart';

class MapService extends ChangeNotifier {
  final Geolocator _geolocator = Geolocator();

  Future<List<Scan>> getScansFromAllPets(List<Pet> allPets) async {
    List<Scan> allScans = new List<Scan>();
    for (int i = 0; i < allPets.length; i++) {
      if (allPets[i].scans != null) {
        for (int j = 0; j < allPets[i].scans.length; j++) {
          Scan currentScan = allPets[i].scans[j];
          currentScan.petName = allPets[i].name;
          currentScan.petIndex = i;
          currentScan.address = await getLocationAddress(currentScan.location);
          allScans.add(currentScan);
        }
      }
    }
    return allScans;
  }

  Set<Marker> createMarkers(List<Scan> allScans) {
    List<Marker> allMarkers = new List<Marker>();

    if (allScans != null) {
      for (int i = 0; i < allScans.length; i++) {
        Scan currentScan = allScans[i];
        allMarkers.add(
          new Marker(
            markerId: MarkerId(currentScan.date.toString()),
            position: LatLng(
                currentScan.location.latitude, currentScan.location.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                MapConstants.bitmapDescriptorHues[currentScan.petIndex]),
          ),
        );
      }
    }
    return allMarkers.toSet();
  }

  Future<String> getLocationAddress(GeoPoint coordinates) async {
    List<Placemark> placemarks = await _geolocator.placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
    if (placemarks.length > 0) {
      return placemarkToAddressName(placemarks[0]);
    } else {
      return 'Address Not Found';
    }
  }

  String placemarkToAddressName(Placemark placemark) {
    print(placemark.thoroughfare.length);
    return getName(placemark.name) +
        getName(placemark.thoroughfare) +
        getName(placemark.subLocality) +
        getName(placemark.locality) +
        getName(placemark.administrativeArea) +
        getName(placemark.postalCode) +
        getName(placemark.isoCountryCode);
  }

  String getName(String name) {
    if (name == null || name.trim().isEmpty) {
      return '';
    } else {
      return name + ' ';
    }
  }
}
