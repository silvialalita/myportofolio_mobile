import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // tanya: const
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home_outlined),
            title: const Text('Home'),
            textColor: Theme.of(context).colorScheme.surface,
            iconColor: Theme.of(context).colorScheme.surface,

            // Navigasi ke halaman utama portofolio
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ), 
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            textColor: Theme.of(context).colorScheme.surface,
            iconColor: Theme.of(context).colorScheme.surface,

            // Navigasi ke halaman tambah proyek
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectFormPage(),
                ),
              );

            },
          ),

          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: const Text('Add Experience'),
            textColor: Theme.of(context).colorScheme.surface,
            iconColor: Theme.of(context).colorScheme.surface,

            // Navigasi ke halaman tambah pengalaman
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExperienceFormPage(),
                ),
              );

            },
          ),
        ],
      ),
    );
  }
}