import 'dart:async';

import 'package:charity/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Map extends StatelessWidget {

  Map({this.user});
  final User user;
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
  LatLng pos=new LatLng(user.lat, user.long);
    return  GoogleMap(
      mapType: MapType.hybrid,
      markers: {
        new Marker(
          markerId: new MarkerId(user.firstName+" "+user.lastName),
          position: pos,
          alpha: 1,
        )
      },
      initialCameraPosition: CameraPosition(target: pos,zoom: 17) ,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
