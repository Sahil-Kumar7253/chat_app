import 'package:chat_app1/Screens/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/auth/auth_service.dart';
import '../themes/theme_provider.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.message,
                      color: isDarkMode? Colors.white : Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                      color: isDarkMode? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: isDarkMode? Colors.white : Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "S E T T I N G",
                    style: TextStyle(
                      color: isDarkMode? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: isDarkMode? Colors.white : Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Settingpage())
                    );
                  },
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle(
                  color: isDarkMode? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: isDarkMode? Colors.white : Theme.of(context).colorScheme.primary,
              ),
              onTap: () async {
                final authService = AuthService();
                await authService.signOut();
              },
            ),
          ),
        ],
      )
    );
  }
}
