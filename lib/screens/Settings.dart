import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/Register.dart';
import 'package:provider/provider.dart';//theme provider class

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: 'Settings',
                items: [
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) {
                      return ListTile(
                        title: const Text("Dark Mode"),
                        leading: const Icon(Icons.dark_mode_outlined),
                        trailing: Switch(
                          value: themeProvider.isDark,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          },
                        ),
                      );
                    },
                  ),
                  const ListTile(
                    title: Text("Notifications"),
                    leading: Icon(Icons.notifications_none_rounded),
                  ),
                  const ListTile(
                    title: Text("Privacy"),
                    leading: Icon(Icons.help_outline_rounded),
                  ),
                  const ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.info_outline_rounded),
                  ),
                ],
              ),
              ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.exit_to_app_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Login()),
                  );
                },
              ),
              ListTile(
                title: const Text("Delete Account"),
                leading: const Icon(Icons.exit_to_app_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Register()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SingleSection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: items,
        ),
      ],
    );
  }
}
