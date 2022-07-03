import 'package:flutter/material.dart';
import 'package:levelink_guru/providers/pembayaran_provider.dart';
import 'package:levelink_guru/providers/rating_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:levelink_guru/splash_screen.dart';

import 'package:provider/provider.dart';
import 'package:levelink_guru/providers/pertemuan_provider.dart';
import 'package:levelink_guru/providers/cart_provider.dart';
import 'package:levelink_guru/providers/jadwal_provider.dart';
import 'package:levelink_guru/providers/kelas_provider.dart';
import 'package:levelink_guru/providers/tab_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<KelasProvider>(create: (_) => KelasProvider()),
  ChangeNotifierProvider<TabProvider>(create: (_) => TabProvider()),
  ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
  ChangeNotifierProvider<JadwalProvider>(create: (_) => JadwalProvider()),
  ChangeNotifierProvider<PertemuanProvider>(create: (_) => PertemuanProvider()),
  ChangeNotifierProvider<PembayaranProvider>(
    create: (_) => PembayaranProvider(),
  ),
  ChangeNotifierProvider<RatingProvider>(create: (_) => RatingProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Levelink-guru(alpha)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF',
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(),
      // initialRoute: '/splash',
      // routes: {
      //   '/': (context) => const TabScreen(),
      //   '/login': (context) => const LoginPage(),
      //   '/splash': (context) => const SplashScreen(),
      //   '/dashboard': (context) => const DashboardPage(),
      //   '/find': (context) => const FindPage(),
      //   '/transaction': (context) => const TransactionPage(),
      // },
    );
  }
}
