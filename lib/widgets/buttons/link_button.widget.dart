import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  final String text, url;
  final void Function()? onClick;
  final double fontSize;
  final bool disableUnderline;

  const LinkButton({
    Key? key,
    required this.text,
    required this.url,
    this.fontSize = 18,
    this.onClick,
    this.disableUnderline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onClick?.call();
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.blue,
          decoration: !disableUnderline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}
