import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

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
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          // Modified biar snackbar warna-warni dan ada icon 🤩
          _showSnackBar(context);

          // Navigate ke halaman yang sesuai
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectFormPage()),
            );
          }

          if (item.name == "Tambah Pengalaman") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
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

