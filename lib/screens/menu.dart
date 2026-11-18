import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';  
import 'package:myportofolio_mobile/widgets/project_card.dart';

/// Model data untuk satu tombol aksi pada halaman utama.
///
/// Warna disimpan di dalam model ([color]) sehingga [ItemCard] cukup membaca
/// `item.color` tanpa percabangan if-else untuk setiap tombol.
class ItemHomepage {
  /// Teks pada tombol, sekaligus dipakai pada pesan SnackBar.
  final String name;

  /// Ikon yang tampil di atas teks tombol.
  final IconData icon;

  /// Warna latar tombol (dibuat unik antartombol).
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

/// Halaman utama aplikasi: kartu identitas, sambutan, dan menu aksi portofolio.
///
/// Bersifat [StatelessWidget] karena seluruh datanya tetap (tidak berubah
/// akibat interaksi pengguna).
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Identitas pemilik portofolio.
  static const String _npm = '2506621863';
  static const String _nama = 'Silvia Lalita Damayanti';
  static const String _kelas = 'PBP D';

  /// Daftar tombol aksi beserta warna uniknya.
  static const List<ItemHomepage> _items = [
    ItemHomepage('Lihat Proyek', Icons.code, Colors.pink), 
    ItemHomepage('Tambah Proyek', Icons.add_circle, Colors.orange), 
    ItemHomepage('Lihat Education', Icons.school, Colors.yellow), 
    ItemHomepage('Tambah Education', Icons.add_circle, Colors.green), 
    ItemHomepage('Lihat Pengalaman', Icons.folder, Colors.blue), 
    ItemHomepage('Tambah Pengalaman', Icons.add_circle, Colors.purpleAccent), 
    ItemHomepage('Logout', Icons.logout, Color(0xFFC62828)), // merah
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan kerangka halaman (AppBar, body, tempat SnackBar).
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white)
      ),

      drawer: const LeftDrawer(),

      // SafeArea menjauhkan konten dari notch/tepi layar.
      body: SafeArea(
        // Center + ConstrainedBox: batasi lebar agar rapi di layar lebar
        // (Chrome/desktop), tanpa mengubah tampilan di HP.
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            // SingleCvhildScrollView: halaman bisa di-scroll sehingga tidak
            // overflow pada layar kecil.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 3 InfoCard sejajar. IntrinsicHeight + stretch membuat
                  // ketiga kartu sama tinggi; flex mengatur lebar relatif.
                  const IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: InfoCard(title: 'NPM', content: _npm),
                        ),
                        Expanded(
                          flex: 4,
                          child: InfoCard(title: 'Name', content: _nama),
                        ),
                        Expanded(
                          flex: 2,
                          child: InfoCard(title: 'Class', content: _kelas),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Kartu sambutan.
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Selamat datang di MyPortfolio Mobile!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Pilih salah satu menu di bawah untuk '
                            'mengelola portofolio kamu.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Kisi 3 kolom berisi tombol aksi.
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    // shrinkWrap: tinggi kisi mengikuti isinya.
                    shrinkWrap: true,
                    // Scroll ditangani SingleChildScrollView di atasnya.
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (final item in _items) ItemCard(item),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Kartu informasi sederhana: [title] (tebal) di atas [content].
class InfoCard extends StatelessWidget {
  /// Judul kartu, misalnya "NPM".
  final String title;

  /// Isi kartu, misalnya nilai NPM.
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

