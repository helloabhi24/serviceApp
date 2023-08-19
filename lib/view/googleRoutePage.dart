import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers.dart/locationDetailsController.dart';

class GoogleRoutePage extends GetView<LocationAccessController> {
  GoogleRoutePage({super.key});
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final LatLng source =
        LatLng(controller.userLat.value, controller.userLong.value);
    final LatLng destination = LatLng(29.5799055, 77.319700);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        elevation: 2,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: source,
          zoom: 8.0,
        ),
        markers: {
          Marker(markerId: MarkerId("Source"), position: source),
          Marker(markerId: MarkerId("Destination"), position: destination),
        },
      ),
    );
  }
}
