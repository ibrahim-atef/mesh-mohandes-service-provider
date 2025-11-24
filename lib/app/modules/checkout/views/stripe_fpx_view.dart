import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/stripe_fpx_controller.dart';

class StripeFPXViewWidget extends GetView<StripeFPXController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Stripe FPX Payment".tr,
          style: Get.textTheme.headline6?.merge(TextStyle(letterSpacing: 1.3)) ?? TextStyle(letterSpacing: 1.3),
        ),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Obx(() {
            if (controller.webView != null && controller.url.value.isNotEmpty) {
              controller.webView!.loadRequest(Uri.parse(controller.url.value));
            }
            return controller.webView != null
                ? WebViewWidget(controller: controller.webView!)
                : Center(child: CircularProgressIndicator());
          }),
          Obx(() {
            if (controller.progress.value < 1) {
              return SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.2),
                ),
              );
            } else {
              return SizedBox();
            }
          })
        ],
      ),
    );
  }
}
