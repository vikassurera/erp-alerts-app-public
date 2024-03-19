import 'package:dio/dio.dart';
import 'package:erpalerts/service/notice.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import Models
import 'package:erpalerts/models/update.dart';

// Import Utils
import 'package:erpalerts/utils/snackbar.dart';

class UpdatesController extends GetxController {
  final NoticeService _noticeService = NoticeService();
  BuildContext? _context;

  // MARK: - state
  var loading = false.obs;
  var updates = <Update>[].obs;

  // MARK: - Lifecycle
  void init(BuildContext context) async {
    _context = context;
    if (updates.isNotEmpty) return;
    fetchAll();
  }

  void reset() {
    updates.clear();
    loading.value = false;
  }

  // MARK: - Fetching
  Future<void> fetchAll() async {
    loading.toggle();
    try {
      final list = await _noticeService.fetchAppUpdates();
      updates.value = list;
    } on DioError catch (error) {
      final message = error.response?.data['message'] ?? 'Error';
      showSnackBar(_context!, message, color: Colors.red);
    } catch (error) {
      print(error);
      showSnackBar(_context!, 'Error', color: Colors.red);
    }
    loading.toggle();
  }

  Future<void> refetchAll() async {
    try {
      final list = await _noticeService.fetchAppUpdates();
      updates.value = list;
      showSuccessBar(_context!, 'Refreshed');
    } on DioError catch (error) {
      final message = error.response?.data['message'] ?? 'Error';
      showSnackBar(_context!, message, color: Colors.red);
    } catch (error) {
      showSnackBar(_context!, 'Error', color: Colors.red);
    }
  }
}
