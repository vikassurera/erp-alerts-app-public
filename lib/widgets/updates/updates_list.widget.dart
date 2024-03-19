import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import Controllers
import 'package:erpalerts/controllers/updates.controller.dart';

// Import Widgets
import 'package:erpalerts/widgets/updates/update_card.widget.dart';

class UpdateList extends StatefulWidget {
  const UpdateList({Key? key}) : super(key: key);

  @override
  State<UpdateList> createState() => _UpdateListState();
}

class _UpdateListState extends State<UpdateList> {
  final controller = Get.find<UpdatesController>();

  @override
  void initState() {
    controller.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refetchAll,
      child: Obx(() => Stack(
            children: <Widget>[
              ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  itemCount: controller.updates.length,
                  itemBuilder: (ctx, index) {
                    final item = controller.updates[index];
                    return UpdateCard(update: item);
                  }),
              controller.loading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(
                          // color: Colors.white,
                          ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          )),
    );
  }
}
