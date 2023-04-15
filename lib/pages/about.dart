import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? appVersion;

  Future<void> infoVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  void initState() {
    infoVersion();
    super.initState();
  }

  static const Color _lightColor = Color(0xFFECEFF1);
  static const Color _darkColor = Color.fromARGB(255, 28, 30, 31);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkColor,
      appBar: AppBar(
        foregroundColor: _lightColor,
        backgroundColor: _darkColor.withOpacity(0.75),
        elevation: 0,
        centerTitle: true,
        title: RichText(
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.end,
            text: const TextSpan(
                text: 'About',
                style: TextStyle(fontSize: 20),
                children: [
                  TextSpan(
                    text: 'Us',
                    style: TextStyle(fontSize: 20, color: Colors.amber),
                  ),
                ]
            )
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                const Text(
                  'BlackBoard',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12,),
                const Text(
                  'A very simple blackboard in Flutter which will run on all the platforms, and that too without using any Third Party dependencies.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 5,),
                const Text(
                  'A functional blackboard, where we can write, draw, clear, undo and redo the contents with the press of a button.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 65,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text('This is an open source project.\nIf you like our work put some 🌟 and ❤ on the repository.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(0.0),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final Uri url =
                      Uri.parse('https://github.com/VikramadityaDev/');

                      if (!await launchUrl(url,
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF83D475),
                            Color(0xFF57C84D),
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 45.0,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Source Code',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
              child: Text(
                'Created By Vikramaditya',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}