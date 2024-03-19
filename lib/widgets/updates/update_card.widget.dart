import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import 'package:erpalerts/models/update.dart';

// Widgets
import 'package:erpalerts/widgets/updates/update_tile.widget.dart';

class UpdateCard extends StatelessWidget {
  final Update update;

  const UpdateCard({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        leading: update.logo != null
            ? CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                imageUrl: update.logo!,
                placeholder: (context, url) => const SizedBox(
                    height: 60, width: 60, child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : null,
        title: Text(update.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update.description.replaceAll('\\n', '\n'),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            ...update.data
                .map((item) => Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: UpdateCardData(data: item),
                    ))
                .toList(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMd().add_jm().format(update.updateDate),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
