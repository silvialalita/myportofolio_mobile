# MyPortfolio Mobile 

Aplikasi mobile portofolio pribadi yang dikembangkan menggunakan Flutter dan bahasa pemrograman Dart. Bagian dari Proyek Individu mata kuliah **Pemrograman Berbasis Platform (PBP)**, Fasilkom UI, Semester Gasal 2026/2027. Aplikasi ini menampilkan portofolio pribadi dan informasi dasar pemilik portofolio.

## Fitur

- **Profile Information:** Menampilkan informasi NPM, nama lengkap, dan kelas pemilik portofolio.
- **Portfolio Menu:** Menyediakan beberapa menu aksi, seperti Lihat Proyek, Tambah Proyek, dan Logout.
- **Interactive Feedback:** Menampilkan SnackBar ketika pengguna menekan salah satu tombol.
- **Custom UI:** Menggunakan ikon dan warna latar yang berbeda untuk setiap tombol menu.


## Cara Menjalankan

1. Pasang [Flutter SDK](https://docs.flutter.dev/get-started/install) dan IDE (Android Studio / VS Code).
2. Clone repositori ini, lalu masuk ke foldernya.
3. Jalankan perintah berikut:

```bash
flutter pub get      # unduh dependensi
flutter run          # jalankan aplikasi (pilih device: Chrome/emulator)
flutter analyze      # analisis kode, hasil: No issues found!
flutter test         # jalankan widget test
```

## Progres Mingguan
### **Tugas 7**
---
#### **AI Disclosure 🤖**
   Saya menggunakan ChatGPT untuk membantu panduan instalasi dan setup Flutter, memahami requirement serta tahapan pengerjaan Tugas 7, mempelajari konsep dan penggunaan widget Flutter, serta membantu debugging ketika menemukan error. Saya juga menggunakan AI untuk mengevaluasi kesesuaian implementasi dengan requirement tugas. Seluruh kode tetap saya pelajari, sesuaikan, dan uji secara mandiri.
   1. **Panduan Tugas 7** https://chatgpt.com/share/6afacbca-e778-83ec-91cc-135fc3bf5a98 
   2. **Memeriksa Tugas 7** https://chatgpt.com/share/6afacb9c-d468-83ec-aaab-1962c36aab65 
---
#### **Refleksi**
1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   Widget tree adalah struktur hierarki yang menggambarkan bagaimana widget-widget disusun dalam aplikasi Flutter. Setiap widget dapat memiliki satu atau lebih widget anak (child) untuk membentuk tampilan dan mengatur perilaku aplikasi.

   Hubungan parent-child berarti widget induk bertanggung jawab untuk mengatur atau membungkus widget anaknya. Widget anak akan menjadi bagian dari struktur widget induk dan dapat menerima pengaturan seperti ukuran, warna, posisi, maupun tata letak dari induknya. Widget tree memungkinkan tampilan aplikasi dibangun secara terstruktur dan modular. Setiap widget memiliki tanggung jawab masing-masing sehingga kode lebih mudah dipahami dan dikembangkan.

   Contohnya, pada proyek MyPortfolio Mobile, MaterialApp menjadi widget utama yang memiliki MyHomePage sebagai halaman awal. Kemudian, MyHomePage menggunakan Scaffold untuk menyusun halaman, yang memiliki AppBar dan SafeArea sebagai bagian dari tampilannya. Di dalam SafeArea, terdapat Center, ConstrainedBox, SingleChildScrollView, dan Column yang menyusun konten halaman.

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

   - `MaterialApp`: root aplikasi, menyediakan tema Material, halaman awal, dan navigasi.
   - `Scaffold`: kerangka dasar halaman (AppBar, body, dan tempat SnackBar).
   - `AppBar`: bar judul di bagian atas halaman.
   - `SafeArea`: menjaga konten tidak tertutup notch atau tepi layar.
   - `Center` dan `ConstrainedBox`: menengahkan konten dan membatasi lebar maksimum (600) agar rapi di layar lebar.
   - `SingleChildScrollView`: membuat konten bisa di-scroll sehingga tidak overflow di layar kecil.
   - `Column` dan `Row`: menyusun anak secara vertikal dan horizontal.
   - `IntrinsicHeight`: membuat ketiga `InfoCard` dalam satu `Row` sama tinggi.
   - `Expanded`: membagi lebar `Row` secara proporsional (`flex`) kepada anak-anaknya.
   - `Card`: kartu dengan sudut membulat dan bayangan (kartu sambutan dan dasar `InfoCard`).
   - `Padding` dan `SizedBox`: memberi jarak di dalam widget dan antarwidget.
   - `Text` dan `Icon`: menampilkan teks dan ikon.
   - `GridView.count`: menyusun tombol dalam kisi 3 kolom.
   - `Material`: permukaan berwarna dengan sudut membulat sebagai latar `ItemCard`.
   - `InkWell`: area yang bisa ditekan dengan efek percikan (*ripple*) dan memicu `onTap`.
   - `SnackBar` (ditampilkan lewat `ScaffoldMessenger`): pesan singkat di bawah layar saat tombol ditekan.
   - Widget buatan sendiri: `MyApp` (root), `MyHomePage` (halaman utama), `InfoCard` (kartu identitas), `ItemCard` (tombol aksi).

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   MaterialApp merupakan widget yang menyediakan konfigurasi dasar untuk aplikasi Flutter yang menggunakan desain Material Design.

   Fungsi MaterialApp antara lain:
   - Mengatur tema aplikasi melalui properti theme.
   - Menentukan halaman awal aplikasi melalui properti home.
   - Menentukan judul aplikasi melalui properti title.
   - Menyediakan konfigurasi navigasi dan pengelolaan halaman.
   - Menyediakan konteks Material yang dibutuhkan oleh widget seperti Scaffold, AppBar, dan SnackBar.
   
   Dengan menaruhnya di root, semua itu tersedia sekali untuk seluruh widget di bawahnya, dan tampilan aplikasi menjadi konsisten.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   - `StatelessWidget` bersifat immutable: tidak memiliki state internal yang berubah, dan tampilannya hanya bergantung pada properti yang diberikan lewat konstruktor. `build` dipanggil ulang hanya ketika parent membangun ulang.
   - `StatefulWidget` memiliki objek `State` terpisah yang bertahan selama widget hidup. Ketika `setState()` dipanggil, Flutter membangun ulang widget tersebut. Ia punya siklus hidup (`initState`, `dispose`, dll.).

   Pilih `StatelessWidget` untuk tampilan yang statis atau hanya bergantung pada input (misalnya, di proyek ini: `MyHomePage`, `InfoCard`, `ItemCard`). Pilih `StatefulWidget` ketika tampilan harus berubah akibat interaksi, waktu, atau data asinkron, misalnya counter, isian form, checkbox, atau animasi. Praktik yang baik: mulai dari Stateless, ubah ke Stateful hanya jika benar-benar ada state yang berubah.

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   `BuildContext` adalah objek yang merepresentasikan posisi suatu widget di dalam widget tree Flutter. `BuildContext` penting karena memungkinkan sebuah widget mengakses informasi dan layanan yang disediakan oleh widget-widget induknya. Melalui `BuildContext`, kita dapat mengakses berbagai fitur Flutter, seperti mengambil tema aplikasi menggunakan `Theme.of(context)`, mendapatkan informasi ukuran layar menggunakan `MediaQuery.of(context)`, menampilkan SnackBar menggunakan `ScaffoldMessenger.of(context)`, dan melakukan navigasi menggunakan `Navigator.of(context)`.
   
   Dalam proyek MyPortfolio Mobile, `BuildContext` digunakan di dalam metode `build()` untuk mengambil warna utama aplikasi yang sudah dikonfigurasi melalui `MaterialApp`, seperti pada kode berikut:

   `backgroundColor: Theme.of(context).colorScheme.primary,`

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   - **Hot reload** fitur Flutter yang memungkinkan developer melihat perubahan kode secara langsung tanpa harus menghentikan dan menjalankan ulang aplikasi. Ketika hot reload dilakukan, Flutter memperbarui kode yang berubah dan membangun ulang tampilan yang terdampak, tetapi tetap mempertahankan state aplikasi yang sedang berjalan. Fitur ini berguna ketika melakukan perubahan kecil, seperti mengubah warna, teks, ukuran font, ikon, atau padding pada widget.
   - **Hot restart** memulai ulang aplikasi Flutter dari awal sehingga state aplikasi kembali ke kondisi awal, tetapi proses development masih berjalan. Hot restart diperlukan ketika perubahan kode membutuhkan inisialisasi ulang aplikasi atau tidak dapat diterapkan melalui hot reload.
   - **Full restart** (stop lalu `flutter run` lagi) dilakukan dengan menghentikan aplikasi yang sedang berjalan, kemudian menjalankannya kembali. Full restart biasanya diperlukan ketika terdapat perubahan konfigurasi native, seperti konfigurasi Android atau iOS, penambahan plugin yang membutuhkan konfigurasi native, atau ketika hot reload dan hot restart belum berhasil menerapkan perubahan.

   Dalam pengembangan MyPortfolio Mobile, hot reload dapat digunakan ketika mengubah warna ItemCard, teks, ikon, atau susunan widget karena perubahan tersebut umumnya dapat langsung diterapkan tanpa mengatur ulang aplikasi. Namun, jika perubahan berkaitan dengan inisialisasi aplikasi atau membutuhkan pemuatan ulang state, developer dapat menggunakan hot restart. Jika perubahan melibatkan konfigurasi native atau penambahan plugin yang memerlukan proses build ulang, developer perlu melakukan full restart.