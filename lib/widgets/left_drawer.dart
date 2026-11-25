import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah pengguna sudah login.
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15),
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
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            textColor: Theme.of(context).colorScheme.surface,
            iconColor: Theme.of(context).colorScheme.surface,

            // Navigasi ke halaman tambah proyek
            onTap: () async {
              // Memastikan pengguna sudah login.
              final allowed = await ensureLoggedIn(context);

              if (!allowed || !context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProjectFormPage()),
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
                MaterialPageRoute(builder: (context) => ExperienceFormPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: const Text('Add Education'),
            textColor: Theme.of(context).colorScheme.surface,
            iconColor: Theme.of(context).colorScheme.surface,

            // Navigasi ke halaman tambah pendidikan
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EducationFormPage(),
                ),
              );
            },
          ),

          // LOGIN: hanya muncul jika belum login.
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              textColor: Theme.of(context).colorScheme.surface,
              iconColor: Theme.of(context).colorScheme.surface,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),

          // LOGOUT: hanya muncul jika sudah login.
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              textColor: Theme.of(context).colorScheme.surface,
              iconColor: Theme.of(context).colorScheme.surface,
              onTap: () async {
                await context.read<AuthState>().logout();

                if (!context.mounted) return;

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You have been logged out.')),
                );
              },
            ),
        ],
      ),
    );
  }
}
