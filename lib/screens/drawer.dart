import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isLoggedIn = true; // 👈 Change this value when login/logout

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(isLoggedIn ? "Surja Bist" : "Guest User"),
            accountEmail: Text(
              isLoggedIn ? "surja@example.com" : "Please sign in",
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: isLoggedIn
                  ? const AssetImage("assets/images/profile.jpg")
                  : null,
              child: !isLoggedIn ? const Icon(Icons.person, size: 40) : null,
            ),
            decoration: BoxDecoration(color: Colors.blue.shade700),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
              // Navigator.pushReplacementNamed(context, '/search');
              // Navigator.pushReplacementNamed(context, '/booking');
              // Navigate to home if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: const Text("Venue"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/venue');
              // Navigate to venue page if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text("Event Planner"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/event_planner');
              // Navigate to event planner page if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact_us');
              // Navigate to contact us page if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about_us');
              // Navigate to about us page if needed
            },
          ),
          const Divider(),
          if (!isLoggedIn) ...[
            ListTile(
              leading: const Icon(Icons.login, color: Colors.green),
              title: const Text("Sign In"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.blue),
              title: const Text("Sign Up"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ] else ...[
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                setState(() {
                  isLoggedIn = false;
                });
                Navigator.pop(context);
                // After setState, the drawer will rebuild and show Sign In/Sign Up
              },
            ),
          ],
        ],
      ),
    );
  }
}