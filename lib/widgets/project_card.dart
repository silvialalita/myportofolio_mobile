import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

import 'package:provider/provider.dart';

/// Tombol aksi berbentuk kartu berwarna.
///
/// Warna, ikon, dan teks seluruhnya dibaca dari [item]. Saat ditekan,
/// menampilkan SnackBar "Kamu telah menekan tombol [nama]!".
/// Tombol aksi berbentuk kartu berwarna.
///
/// Warna, ikon, dan teks seluruhnya dibaca dari [item]. Saat ditekan,
/// menampilkan SnackBar "Kamu telah menekan tombol [nama]!".
class ItemCard extends StatelessWidget {
  /// Data tombol yang ditampilkan.
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  /// Menampilkan SnackBar berwarna sesuai tombol; SnackBar lama ditutup dulu
  /// agar pesan tidak menumpuk.
  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: item.color,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              Icon(item.icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Kamu telah menekan tombol ${item.name}!',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // Area responsif terhadap sentuhan
        onTap: () async {
          _showSnackBar(context);

          // Tombol Lihat Proyek: langsung membuka daftar proyek.
          if (item.name == "Lihat Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectListScreen(),
              ),
            );
            return;
          }

          // Tombol Logout: menghapus sesi login.
          if (item.name == "Logout") {
            await context.read<AuthState>().logout();

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You have been logged out.')),
            );
            return;
          }

          // Tombol Tambah Proyek: wajib login.
          if (item.name == "Tambah Proyek") {
            final allowed = await ensureLoggedIn(context);

            if (!allowed || !context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectFormPage()),
            );
            return;
          }

          // Education dan Experience tetap menggunakan alur sebelumnya.
          final allowed = await ensureLoggedIn(context);
          if (!allowed || !context.mounted) return;

          if (item.name == "Tambah Pengalaman") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExperienceFormPage(),
              ),
            );
          }

          if (item.name == "Tambah Education") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationFormPage(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 6),
              Text(
                item.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
