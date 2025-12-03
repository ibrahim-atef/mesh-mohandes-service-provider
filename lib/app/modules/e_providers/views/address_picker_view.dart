import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../services/settings_service.dart';
import '../controllers/e_provider_addresses_form_controller.dart';

// ignore: must_be_immutable
class AddressPickerView extends GetView<EProviderAddressesFormController> {
  AddressPickerView({
    Key? key,
  })  : _address = Get.arguments != null
            ? Get.arguments['address'] as Address
            : Address(),
        super(key: key);

  late Address _address;
  PickResult? _currentSelectedPlace;
  LatLng? _currentMapCenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _addCurrentLocation();
        },
        backgroundColor: Get.theme.colorScheme.secondary,
        icon: Icon(
          Icons.add_location_alt,
          color: Get.theme.primaryColor,
          size: 28,
        ),
        label: Text(
          "Add".tr,
          style: Get.textTheme.titleLarge?.merge(
            TextStyle(
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: PlacePicker(
        apiKey: Get.find<SettingsService>().setting.value.googleMapsKey ?? '',
        initialPosition: _address.getLatLng(),
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePlaceDetailSearch: false,
        forceSearchOnZoomChanged: true,
        onCameraMove: (position) {
          // Update current map center position when camera moves
          _currentMapCenter = position.target;
        },
        selectedPlaceWidgetBuilder:
            (_, selectedPlace, state, isSearchBarFocused) {
          // Store selected place for use in floating button
          // This is called whenever user selects a location on the map
          if (selectedPlace != null) {
            _currentSelectedPlace = selectedPlace;
            final geometry = selectedPlace.geometry;
            final location = geometry?.location;
            if (location != null) {
              // Update address with current selected location
              _address.latitude = location.lat;
              _address.longitude = location.lng;
              _address.address =
                  selectedPlace.formattedAddress ?? _address.address ?? '';
              _currentMapCenter = LatLng(location.lat, location.lng);
            }
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _addCurrentLocation() async {
    // Priority 1: Use selected place if available
    if (_currentSelectedPlace != null) {
      final geometry = _currentSelectedPlace?.geometry;
      final location = geometry?.location;

      if (location != null) {
        _address.latitude = location.lat;
        _address.longitude = location.lng;
        _address.address =
            _currentSelectedPlace?.formattedAddress ?? _address.address ?? '';

        // Auto-fill description if empty
        if ((_address.description ?? '').trim().isEmpty) {
          _address.description = _currentSelectedPlace?.name ??
              _currentSelectedPlace?.formattedAddress?.split(',').first ??
              "My Location".tr;
        }
      }
    }
    // Priority 2: Use current map center if no place selected
    else if (_currentMapCenter != null) {
      _address.latitude = _currentMapCenter!.latitude;
      _address.longitude = _currentMapCenter!.longitude;

      if ((_address.address ?? '').trim().isEmpty) {
        _address.address =
            "${_currentMapCenter!.latitude}, ${_currentMapCenter!.longitude}";
      }

      if ((_address.description ?? '').trim().isEmpty) {
        _address.description = "My Location".tr;
      }
    }
    // Priority 3: Use address data if already set
    else if (_address.latitude != null && _address.longitude != null) {
      // Address already has location data
    }
    // No location available
    else {
      Get.showSnackbar(Ui.ErrorSnackBar(
        message: "Please select a location on the map first".tr,
      ));
      return;
    }

    // Validate and save
    if (_address.latitude != null && _address.longitude != null) {
      try {
        final controller = Get.find<EProviderAddressesFormController>();
        if (_address.id != null && _address.id!.isNotEmpty) {
          await controller.updateAddress(_address);
        } else {
          await controller.createAddress(_address);
        }
        // Exit from map immediately after successful save
        Get.back(result: true);
        // Show success message after exiting
        Get.showSnackbar(Ui.SuccessSnackBar(
          message: _address.id != null && _address.id!.isNotEmpty
              ? "Address updated successfully".tr
              : "Address added successfully".tr,
        ));
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(
          message: e.toString(),
        ));
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
        message: "Please select a location on the map first".tr,
      ));
    }
  }
}
