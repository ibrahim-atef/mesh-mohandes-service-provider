import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';
import '../providers/laravel_provider.dart';
import '../services/auth_service.dart';

class UserRepository {
  late LaravelApiClient _laravelApiClient;

  UserRepository() {}

  Future<User> login(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.login(user);
  }

  Future<User> get(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.getUser(user);
  }

  Future<User> update(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.updateUser(user);
  }

  Future<bool> sendResetLinkEmail(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.sendResetLinkEmail(user);
  }

  Future<User> getCurrentUser() {
    return this.get(Get.find<AuthService>().user.value);
  }

  Future<void> deleteCurrentUser() async {
    _laravelApiClient = Get.find<LaravelApiClient>();
    await _laravelApiClient.deleteUser(Get.find<AuthService>().user.value);
    Get.find<AuthService>().user.value = new User();
    GetStorage().remove('current_user');
  }

  Future<User> register(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.register(user);
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    // Firebase removed - method no longer available
    return true;
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    // Firebase removed - method no longer available
    return true;
  }

  Future<void> verifyPhone(String smsCode) async {
    // Firebase removed - method no longer available
  }

  Future<void> sendCodeToPhone() async {
    // Firebase removed - method no longer available
  }

  Future signOut() async {
    // Firebase removed - method no longer available
  }
}
