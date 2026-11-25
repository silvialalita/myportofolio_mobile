// import 'package:flutter_test/flutter_test.dart';
// import 'package:myportofolio_mobile/main.dart';
// import 'package:myportofolio_mobile/screens/menu.dart';
// import 'package:myportofolio_mobile/widgets/project_card.dart';

// void main() {
//   testWidgets('menampilkan 3 InfoCard identitas', (tester) async {
//     await tester.pumpWidget(const MyApp());

//     expect(find.byType(InfoCard), findsNWidgets(3));
//     expect(find.text('NPM'), findsOneWidget);
//     expect(find.text('Name'), findsOneWidget);
//     expect(find.text('Class'), findsOneWidget);
//   });

//   testWidgets('menampilkan 7 ItemCard', (tester) async {
//     await tester.pumpWidget(const MyApp());

//     expect(find.byType(ItemCard), findsNWidgets(7));
//   });

//   // Satu tes untuk setiap tombol.
//   for (final nama in [
//     'Lihat Proyek',
//     'Tambah Proyek',
//     'Lihat Education',
//     'Tambah Education',
//     'Lihat Pengalaman',
//     'Tambah Pengalaman',
//     'Logout',
//   ]) {
//     testWidgets('menekan "$nama" memunculkan SnackBar', (tester) async {
//       await tester.pumpWidget(const MyApp());

//       // Scroll sampai tombol terlihat, lalu tekan.
//       await tester.ensureVisible(find.text(nama));
//       await tester.tap(find.text(nama));
//       await tester.pump();

//       expect(find.text('Kamu telah menekan tombol $nama!'), findsOneWidget);
//     });
//   }
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('Aplikasi dapat ditampilkan', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    expect(find.byType(MyApp), findsOneWidget);
  });
}
