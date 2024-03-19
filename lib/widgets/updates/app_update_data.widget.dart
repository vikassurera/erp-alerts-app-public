import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

// Import Models
import 'package:erpalerts/models/app_update_data.model.dart';

class AppUpdateLinkWidget extends StatelessWidget {
  const AppUpdateLinkWidget({super.key, required this.item});
  final AppUpdateDataLinkModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(item.url)) {
          await launch(item.url);
        }
      },
      child: Text(
        item.text.replaceAll('\\n', '\n'),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class AppUpdateImageWidget extends StatelessWidget {
  const AppUpdateImageWidget({super.key, required this.item});
  final AppUpdateDataImageModel item;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: item.height.toDouble(),
      imageUrl: item.url,
      placeholder: (context, url) => Container(
        height: 100,
        width: 100,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

class AppUpdateTextWidget extends StatelessWidget {
  const AppUpdateTextWidget({super.key, required this.item});
  final AppUpdateDataTextModel item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.text.replaceAll('\\n', '\n'),
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
