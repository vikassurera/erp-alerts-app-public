import 'package:get/get.dart';

// Models
import 'package:erpalerts/models/notice_pagination_params.model.dart';
import 'package:erpalerts/models/notice.model.dart';
import 'package:erpalerts/models/notice_filter.model.dart';

// Services
import 'package:erpalerts/service/notice.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Managers
import 'package:erpalerts/managers/storage.manager.dart';

const TAG = '[NoticeController]';

class NoticeController extends GetxController {
  final NoticeService _noticeService = NoticeService();

  final loading = false.obs;
  final refreshing = false.obs;
  final notices = <Notice>[].obs;

  NoticePaginationParams params =
      NoticePaginationParams(type: StorageManager().getString('filterType'));

  // Getters
  String? get filterCategory => params.category;
  String? get filterType => params.type;

  NoticeFilter? get selectedFilter => _selectedFilter.value;
  NoticeFilter get selectedType => _selectedType.value;

  List<NoticeFilter> filters = [];
  List<NoticeFilter> typeFilter = [
    NoticeFilter(key: 'PLACEMENT', value: 'Placement'),
    NoticeFilter(key: 'INTERNSHIP', value: 'Internship'),
  ];

  final Rx<NoticeFilter?> _selectedFilter = Rx<NoticeFilter?>(null);
  final Rx<NoticeFilter> _selectedType = Rx<NoticeFilter>(
    StorageManager().getString('filterType') == 'PLACEMENT'
        ? NoticeFilter(key: 'PLACEMENT', value: 'Placement')
        : NoticeFilter(key: 'INTERNSHIP', value: 'Internship'),
  );

  // Reset
  void reset() {
    notices.clear();
    loading.value = false;
    refreshing.value = false;
    params = NoticePaginationParams();
    _selectedFilter.value = null;
    _selectedType.value = typeFilter[0];
  }

  initFilters() {
    filters = Get.find<UserController>().filters;

    // Check if the 'all' key is present in the filters
    // If not, add it
    if (!filters.any((filter) => filter.key == 'all')) {
      filters.insert(0, NoticeFilter(key: 'all', value: 'All'));
    } else {
      // If present, then move it to the first position
      final allFilter = filters.firstWhere((filter) => filter.key == 'all');
      filters.remove(allFilter);
      filters.insert(0, allFilter);
    }

    // Set the default filter
    if (selectedFilter == null) {
      _selectedFilter.value = filters[0];
    } else {
      // Check if the selected filter 'key' is present in the filters (if not then set the default filter)
      if (!filters.any((filter) => filter.key == selectedFilter?.key)) {
        _selectedFilter.value = filters[0];
      }
    }
  }

  updateFilter(int index) {
    _selectedFilter.value = filters[index];
  }

  updateType(int index) {
    _selectedType.value = typeFilter[index];
    StorageManager().saveString('filterType', _selectedType.value.key);
  }

  applyFilter() {
    final categoryValue =
        selectedFilter?.key == 'all' ? null : selectedFilter?.value;
    final typeValue = selectedType.key;

    if (categoryValue != params.category || typeValue != params.type) {
      params = params.copyWith(category: categoryValue, type: typeValue);
      refreshAll();
    }
  }

  Future<void> fetchAll() async {
    loading.value = true;
    try {
      final response = await _noticeService.fetchNotices(
        params,
      );
      notices.value = response.notices;
    } catch (error) {
      print('$TAG fetchAll(): $error');
    } finally {
      loading.value = false;
    }
  }

  Future<void> refreshAll() async {
    try {
      refreshing.value = true;
      final response = await _noticeService.fetchNotices(
        params,
      );
      notices.value = response.notices;
    } catch (error) {
      print('$TAG refreshAll(): $error');
    } finally {
      refreshing.value = false;
    }
  }
}
