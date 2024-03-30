import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugsuyoo/login/login.dart';
// Import your login screen

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? Name = user?.displayName;
    final String? email = user?.email;
    final String? photoURL = user?.photoURL;

    return Container(
      width: 200, // Adjust the width as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (user != null)
            ListTile(
              leading: CircleAvatar(
                backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
                child: photoURL == null ? const Icon(Icons.person) : null,
              ),
              title: Text(Name ?? email ?? 'User'),
              subtitle: Text(email ?? ''),
            ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle settings action
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              // Navigate to login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
            },
          ),
        ],
      ),
    );
  }
}
