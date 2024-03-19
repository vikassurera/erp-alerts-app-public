import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Services
import 'package:erpalerts/service/user.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Utils
import 'package:erpalerts/utils/error.util.dart';

const TAG = '[VerifyEmailController]';

class VerifyEmailController extends GetxController {
  final UserService _userService = UserService();

  // PROPERTIES
  TextEditingController emailCtrl = TextEditingController();

  final _loading = false.obs;
  final _emailSubmitted = false.obs;
  final _errorMessage = Rx<String?>(null);

  bool get isLoading => _loading.value;
  bool get hasError => _errorMessage.value != null;
  String? get errorMessage => _errorMessage.value;

  // LIFE CYCLE METHODS
  @override
  void onInit() {
    super.onInit();
    emailCtrl.text = '';
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    super.onClose();
  }

  // METHODS
  Future<bool> submitEmail() async {
    final String instiEmail = emailCtrl.text.trim().toLowerCase();
    emailCtrl.text = instiEmail;
    if (isLoading) return false;

    // validate email
    if (!validateEmail(instiEmail)) return false;

    try {
      _loading.value = true;
      await _userService.verifyInstiEmail(instiEmail);

      _emailSubmitted.value = true;
      return true;
    } on DioError catch (error) {
      _errorMessage.value = getMessageFromError(error);
    } catch (error) {
      print(error);
    } finally {
      _loading.value = false;
    }

    return false;
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      _errorMessage.value = 'Email is required';
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      _errorMessage.value = 'Invalid email';
      return false;
    }

    // check for the allowed emails by the backend
    final emailDomain = email.split('@').last;
    final allowedDomains = Get.find<UserController>().allowedDomains;
    if (!allowedDomains.contains(emailDomain)) {
      _errorMessage.value = 'Email domain not allowed';
      return false;
    }

    _errorMessage.value = null;
    return true;
  }
}
