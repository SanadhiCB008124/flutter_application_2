import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/Register.dart';
import 'package:provider/provider.dart';//theme provider class

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => AppSettingsState();
}

class AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return buildLandscapeLayout();
    } else {
      return buildPortraitLayout();
    }
  }

  Widget buildPortraitLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Container(
        
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
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
              ListTile(
                title: const Text("Delete Account"),
                leading: const Icon(Icons.exit_to_app_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLandscapeLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Container(
       
          child: Row(
            children: [
              Expanded(
                child: _SingleSection(
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
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text("Logout"),
                      leading: const Icon(Icons.exit_to_app_rounded),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("Delete Account"),
                      leading: const Icon(Icons.exit_to_app_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    ),
                  ],
                ),
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
         
        ),
       
        Column(
          children: items,
        ),
      ],
    );
  }
}
