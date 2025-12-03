import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/confirm_dialog.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/e_provider_addresses_form_controller.dart';
import '../widgets/horizontal_stepper_widget.dart';
import '../widgets/step_widget.dart';

class EProviderAddressesFormView
    extends GetView<EProviderAddressesFormController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Provider Addresses".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () async {
              controller.isCreateForm()
                  ? await Get.offAndToNamed(Routes.E_PROVIDERS)
                  : await Get.offAndToNamed(Routes.E_PROVIDER, arguments: {
                      'eProvider': controller.eProvider.value,
                      'heroTag': 'e_provider_addresses_form_back'
                    });
            },
          ),
          elevation: 0,
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add, size: 32, color: Get.theme.primaryColor),
          onPressed: () async {
            await Get.toNamed(Routes.E_PROVIDER_ADDRESS_PICKER,
                arguments: {'address': new Address()});
            // Always refresh addresses after returning from map
            await controller.getAddresses();
          },
          backgroundColor: Get.theme.colorScheme.secondary,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Get.theme.focusColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(() {
                  return MaterialButton(
                    onPressed: controller.eProvider.value.addresses.isEmpty
                        ? null
                        : () async {
                            await Get.toNamed(Routes.E_PROVIDER_FORM,
                                arguments: {
                                  'eProvider': controller.eProvider.value
                                });
                          },
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledElevation: 0,
                    disabledColor: Get.theme.focusColor,
                    color: Get.theme.colorScheme.secondary,
                    child: Text("Save & Next".tr,
                        style: Get.textTheme.bodyMedium
                            ?.merge(TextStyle(color: Get.theme.primaryColor))),
                    elevation: 0,
                  );
                }),
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          primary: true,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 60),
          children: [
            HorizontalStepperWidget(
              controller: new ScrollController(initialScrollOffset: 0),
              steps: [
                StepWidget(
                  title: Text(
                    "Addresses".tr,
                  ),
                  index: Text("1",
                      style: TextStyle(color: Get.theme.primaryColor)),
                ),
                StepWidget(
                  title: Text(
                    "Provider Details".tr,
                  ),
                  color: Get.theme.focusColor,
                  index: Text("2",
                      style: TextStyle(color: Get.theme.primaryColor)),
                ),
                StepWidget(
                  title: Text(
                    "Availability".tr,
                  ),
                  color: Get.theme.focusColor,
                  index: Text("3",
                      style: TextStyle(color: Get.theme.primaryColor)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text("Addresses details".tr,
                      style: Get.textTheme.headlineSmall),
                ),
                MaterialButton(
                  onPressed: () => _showAddAddressDialog(context),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Get.theme.colorScheme.secondary,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 18,
                        color: Get.theme.primaryColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Add Manually".tr,
                        style: Get.textTheme.bodySmall?.merge(
                          TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  elevation: 0,
                ),
              ],
            ).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
            Text("Select from your addresses".tr,
                    style: Get.textTheme.bodySmall)
                .paddingSymmetric(horizontal: 22, vertical: 5),
            Obx(() {
              if (controller.isLoading.value) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: Ui.getBoxDecoration(),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.15),
                    highlightColor:
                        (Colors.grey[200] ?? Colors.grey).withOpacity(0.1),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                );
              }

              if (controller.addresses.isEmpty) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  padding: EdgeInsets.all(40),
                  decoration: Ui.getBoxDecoration(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: 64,
                          color: Get.theme.focusColor.withOpacity(0.5),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "No addresses found".tr,
                          style: Get.textTheme.titleMedium?.merge(
                            TextStyle(
                              color: Get.theme.focusColor.withOpacity(0.7),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Add your first address to get started".tr,
                          style: Get.textTheme.bodySmall?.merge(
                            TextStyle(
                              color: Get.theme.focusColor.withOpacity(0.5),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: Ui.getBoxDecoration(),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children:
                        List.generate(controller.addresses.length, (index) {
                      var _address = controller.addresses.elementAt(index);
                      return Obx(() {
                        final isSelected = controller.eProvider.value.addresses
                            .any((addr) => addr.id == _address.id);
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Get.theme.colorScheme.secondary
                                    .withOpacity(0.1)
                                : Get.theme.focusColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? Get.theme.colorScheme.secondary
                                  : Get.theme.focusColor.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  checkColor: Get.theme.colorScheme.secondary,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Get.theme.colorScheme.secondary
                                          .withOpacity(0.2);
                                    } else {
                                      return Get.theme.focusColor
                                          .withOpacity(0.2);
                                    }
                                  }),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  value: isSelected,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.toggleAddress(value, _address);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _address.description ?? 'No Description',
                                      style: Get.textTheme.titleMedium?.merge(
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Get.theme.colorScheme.secondary
                                              : Get.theme.textTheme.titleMedium
                                                  ?.color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                          color: Get.theme.focusColor,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            "Latitude: ${_address.latitude?.toStringAsFixed(6) ?? 'N/A'}",
                                            style: Get.textTheme.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                          color: Get.theme.focusColor,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            "Longitude: ${_address.longitude?.toStringAsFixed(6) ?? 'N/A'}",
                                            style: Get.textTheme.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  await Get.toNamed(
                                      Routes.E_PROVIDER_ADDRESS_PICKER,
                                      arguments: {'address': _address});
                                  // Always refresh addresses after returning from map
                                  await controller.getAddresses();
                                },
                                height: 44,
                                minWidth: 44,
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                elevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                              ),
                              SizedBox(width: 5),
                              MaterialButton(
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmDialog(
                                          title: "Delete Address".tr,
                                          content:
                                              "Are you sure you want to delete this address?"
                                                  .tr,
                                          submitText: "Submit".tr,
                                          cancelText: "Cancel".tr);
                                    },
                                  );
                                  if (confirm == true && _address.hasData) {
                                    await controller.deleteAddress(_address);
                                  }
                                },
                                height: 44,
                                minWidth: 44,
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: Colors.redAccent,
                                ),
                                elevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                              ),
                            ],
                          ),
                        );
                      });
                    }),
                  ),
                ),
              );
            }),
          ],
        ));
  }

  void _showAddAddressDialog(BuildContext context) {
    final address = Address();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Add Address Manually".tr,
                            style: Get.textTheme.headlineSmall,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFieldWidget(
                      labelText: "Description".tr,
                      hintText: "My Home".tr,
                      initialValue: address.description,
                      onChanged: (input) => address.description = input,
                      iconData: Icons.description_outlined,
                      validator: (input) => (input?.length ?? 0) < 3
                          ? "Should be more than 3 letters".tr
                          : null,
                      onSaved: (input) => address.description = input,
                      isFirst: true,
                      isLast: false,
                    ),
                    TextFieldWidget(
                      labelText: "Full Address".tr,
                      hintText: "123 Street, City 136, State, Country".tr,
                      initialValue: address.address,
                      onChanged: (input) => address.address = input,
                      onSaved: (input) => address.address = input,
                      iconData: Icons.place_outlined,
                      keyboardType: TextInputType.multiline,
                      isFirst: false,
                      isLast: false,
                    ),
                    TextFieldWidget(
                      labelText: "Latitude".tr,
                      hintText: "24.7136".tr,
                      initialValue: address.latitude?.toString(),
                      onChanged: (input) {
                        address.latitude = double.tryParse(input ?? '');
                      },
                      onSaved: (input) {
                        address.latitude = double.tryParse(input ?? '');
                      },
                      iconData: Icons.location_on_outlined,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (input) {
                        final lat = double.tryParse(input ?? '');
                        if (lat == null) {
                          return "Please enter a valid latitude".tr;
                        }
                        if (lat < -90 || lat > 90) {
                          return "Latitude must be between -90 and 90".tr;
                        }
                        return null;
                      },
                      isFirst: false,
                      isLast: false,
                    ),
                    TextFieldWidget(
                      labelText: "Longitude".tr,
                      hintText: "46.6753".tr,
                      initialValue: address.longitude?.toString(),
                      onChanged: (input) {
                        address.longitude = double.tryParse(input ?? '');
                      },
                      onSaved: (input) {
                        address.longitude = double.tryParse(input ?? '');
                      },
                      iconData: Icons.location_on_outlined,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (input) {
                        final lng = double.tryParse(input ?? '');
                        if (lng == null) {
                          return "Please enter a valid longitude".tr;
                        }
                        if (lng < -180 || lng > 180) {
                          return "Longitude must be between -180 and 180".tr;
                        }
                        return null;
                      },
                      isFirst: false,
                      isLast: true,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () => Get.back(),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Get.theme.focusColor.withOpacity(0.1),
                            child: Text(
                              "Cancel".tr,
                              style: Get.textTheme.bodyMedium?.merge(
                                TextStyle(color: Get.theme.focusColor),
                              ),
                            ),
                            elevation: 0,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (address.latitude == null ||
                                    address.longitude == null) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                    message:
                                        "Please enter valid coordinates".tr,
                                  ));
                                  return;
                                }
                                Get.back();
                                try {
                                  await controller.createAddress(address);
                                  Get.showSnackbar(Ui.SuccessSnackBar(
                                    message: "Address added successfully".tr,
                                  ));
                                  await controller.getAddresses();
                                } catch (e) {
                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                    message: e.toString(),
                                  ));
                                }
                              }
                            },
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Get.theme.colorScheme.secondary,
                            child: Text(
                              "Add".tr,
                              style: Get.textTheme.bodyMedium?.merge(
                                TextStyle(color: Get.theme.primaryColor),
                              ),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
