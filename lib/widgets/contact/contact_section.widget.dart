import 'package:erpalerts/config/prod.config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);
  final String contactEmail = Config.supportEmail;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'For any quries or issues contact',
        style: DefaultTextStyle.of(context).style,
      ),
      InkWell(
        onTap: () {
          final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: contactEmail,
              query: encodeQueryParameters(<String, String>{
                'subject': 'Queries | ERP Alerts App',
                'body': 'Hi there,\n  I have queries regarding ',
              }));

          launchUrl(emailLaunchUri);
        },
        child: Text(
          contactEmail,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ]);
  }
}

class FeebackButton extends StatelessWidget {
  const FeebackButton({Key? key}) : super(key: key);
  final String contactEmail = Config.supportEmail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: contactEmail,
            query: encodeQueryParameters(<String, String>{
              'subject': 'Feedback | ERP Alerts App',
              'body': 'Hi there,\n  ',
            }));

        launchUrl(emailLaunchUri);
      },
      child: const Text(
        'Send Feedback',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
