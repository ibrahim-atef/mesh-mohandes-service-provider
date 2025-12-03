import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/e_provider_model.dart';
import '../../../repositories/e_provider_repository.dart';
import '../../global_widgets/multi_select_dialog.dart';

class EProviderAddressesFormController extends GetxController {
  final addresses = <Address>[].obs;
  final eProvider = EProvider().obs;
  final isLoading = true.obs;
  GlobalKey<FormState> eProviderAddressesForm = new GlobalKey<FormState>();
  late EProviderRepository _eProviderRepository;

  EProviderAddressesFormController() {
    _eProviderRepository = new EProviderRepository();
  }

  @override
  void onInit() async {
    isLoading.value = true;
    var arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      eProvider.value = arguments['eProvider'] as EProvider;
    }
    addresses.assignAll(eProvider.value.addresses);
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEProvider();
    super.onReady();
  }

  Future refreshEProvider({bool showMessage = false}) async {
    await getEProvider();
    await getAddresses();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: (eProvider.value.name ?? '') +
              " " +
              "page refreshed successfully".tr));
    }
  }

  Future getEProvider() async {
    if (eProvider.value.hasData) {
      try {
        String? id = eProvider.value.id;
        if (id != null) {
          eProvider.value = await _eProviderRepository.get(id);
        }
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    }
  }

  Future getAddresses() async {
    try {
      isLoading.value = true;
      // Store selected address IDs and objects before updating
      final selectedAddressIds = eProvider.value.addresses
          .where((addr) => addr.id != null)
          .map((addr) => addr.id!)
          .toSet();
      
      // Store addresses that don't have IDs yet (newly created but not saved to server)
      final newAddressesWithoutId = eProvider.value.addresses
          .where((addr) => addr.id == null)
          .toList();
      
      // Get fresh addresses from server
      final serverAddresses = await _eProviderRepository.getAddresses();
      
      // Merge server addresses with any local addresses that might not be in server yet
      final allAddresses = <Address>[];
      allAddresses.addAll(serverAddresses);
      
      // Add any local addresses that aren't in server list (shouldn't happen, but just in case)
      for (var localAddr in addresses) {
        if (localAddr.id != null && !allAddresses.any((addr) => addr.id == localAddr.id)) {
          allAddresses.add(localAddr);
        }
      }
      
      addresses.assignAll(allAddresses);
      
      // Update eProvider.addresses with fresh address objects based on IDs
      // Also include newly created addresses that don't have IDs yet
      eProvider.update((val) {
        if (val != null) {
          final freshSelectedAddresses = addresses
              .where((addr) => addr.id != null && selectedAddressIds.contains(addr.id))
              .toList();
          
          // Add newly created addresses that don't have IDs yet
          for (var newAddr in newAddressesWithoutId) {
            if (!freshSelectedAddresses.any((addr) => addr.id == newAddr.id)) {
              freshSelectedAddresses.add(newAddr);
            }
          }
          
          val.addresses = freshSelectedAddresses;
        }
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createAddress(Address address) async {
    try {
      isLoading.value = true;
      address = await _eProviderRepository.createAddress(address);
      // Add to addresses list if not already there
      if (!addresses.any((addr) => addr.id == address.id)) {
        addresses.insert(0, address);
      }
      // Automatically select the newly created address
      toggleAddress(true, address);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress(Address address) async {
    try {
      address = await _eProviderRepository.updateAddress(address);
      final index = addresses.indexWhere((element) => element.id == address.id);
      if (index >= 0) {
        addresses[index] = address;
      }
      // Update address in eProvider.addresses if it exists there
      eProvider.update((val) {
        if (val != null) {
          final providerAddressIndex =
              val.addresses.indexWhere((element) => element.id == address.id);
          if (providerAddressIndex >= 0) {
            val.addresses[providerAddressIndex] = address;
          }
        }
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future<void> deleteAddress(Address address) async {
    try {
      address = await _eProviderRepository.deleteAddress(address);
      addresses.removeWhere((element) => element.id == address.id);
      toggleAddress(false, address);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void toggleAddress(bool value, Address address) {
    eProvider.update((val) {
      if (val != null) {
        if (value) {
          // Check if address is not already in the list
          if (!val.addresses.any((element) => element.id == address.id)) {
            val.addresses.add(address);
          }
        } else {
          val.addresses.removeWhere((element) => element.id == address.id);
        }
      }
    });
  }

  List<MultiSelectDialogItem<Address>> getMultiSelectAddressesItems() {
    return addresses.map((element) {
      return MultiSelectDialogItem(element, element.getDescription);
    }).toList();
  }

  /*
  * Check if the form for create new service or edit
  * */
  bool isCreateForm() {
    return !eProvider.value.hasData;
  }
}
