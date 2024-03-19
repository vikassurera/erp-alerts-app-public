import 'package:flutter/material.dart';

// Import Models
import 'package:erpalerts/models/app_update_data.model.dart';

// Import Widgets
import 'package:erpalerts/widgets/updates/app_update_data.widget.dart';

class UpdateCardData extends StatelessWidget {
  final AppUpdateDataModel data;
  const UpdateCardData({Key? key, required this.data}) : super(key: key);

  renderDataRow(AppUpdateDataModel item) {
    if (item is AppUpdateDataLinkModel) {
      return AppUpdateLinkWidget(item: item);
    } else if (item is AppUpdateDataImageModel) {
      return AppUpdateImageWidget(item: item);
    } else if (item is AppUpdateDataTextModel) {
      return AppUpdateTextWidget(item: item);
    } else {
      return Container(
        child: Text('Unknown data type'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return renderDataRow(data);
  }
}
