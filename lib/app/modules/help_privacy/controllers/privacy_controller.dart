import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyController extends GetxController {
  late WebViewController webViewController;

  @override
  void onInit() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.onInit();
  }
}
