import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import 'package:design_system/design_system.dart';

class StoreMapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String storeName;
  final Function() onTap;

  const StoreMapView({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.storeName,
    required this.onTap,
  });

  @override
  State<StoreMapView> createState() => _StoreMapViewState();
}

class _StoreMapViewState extends State<StoreMapView> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _setMarker();
  }

  Future<void> _setMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48), devicePixelRatio: 4.0),
      AppImages.marker,
    );

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(context.local.store_location),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: InfoWindow(title: widget.storeName),
          icon: customIcon,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final LatLng storeLocation = LatLng(widget.latitude, widget.longitude);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.theme.colors.stroke, width: 0.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: IgnorePointer(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: storeLocation,
              zoom: 14.0,
            ),
            markers: markers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
          ),
        ),
      ),
    );
  }
}
