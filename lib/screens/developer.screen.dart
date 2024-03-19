import 'package:erpalerts/config/prod.config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Widgets
import 'package:erpalerts/widgets/contact/contact_section.widget.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({Key? key}) : super(key: key);

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  final developerImage = 'assets/wolf.png';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Card(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                subtitle: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(developerImage),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Developer (ERP Alerts)",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Hey there!\nHope you are liking the ERP Alerts App. Feel free to drop your feedbacks on the play store. We are constatnly working on improving the App.",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Made with ❤️",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    InkWell(
                      onTap: () async {
                        const url = Config.websiteUrl;
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      child: const Text(
                        Config.websiteDomain,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ContactSection(),
        ],
      ),
    );
  }
}
