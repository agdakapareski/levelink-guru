/// File: dashboard_page.dart
///
/// File ini berisi UI untuk halaman dashboard.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:levelink_guru/account_page.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/providers/jadwal_provider.dart';
import 'package:levelink_guru/providers/tab_provider.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    final jadwalProvider = Provider.of<JadwalProvider>(context, listen: false);
    jadwalProvider.getJadwal(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final tabProvider = Provider.of<TabProvider>(context);
    final jadwalProvider = Provider.of<JadwalProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'Levelink-guru.png',
          height: 35,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: GestureDetector(
              child: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: jadwalProvider.isLoading == true
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('memuat')
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                // horizontal: screenWidth * 0.04,
                vertical: 10,
              ),
              children: [
                // PaddedWidget(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text('Selamat Datang, '),
                //       Text(
                //         currentnama ?? '',
                //         style: const TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colour.blue,
                //             width: 0.5,
                //           ),
                //         ),
                //         height: 88,
                //         child: const Center(
                //           child: Text('belum ada kelas aktif'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                // const CustomDivider(),
                // const SizedBox(
                //   height: 16,
                // ),
                const PaddedWidget(
                  child: Text(
                    'Jadwal Mengajar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: jadwalProvider.jadwals.isEmpty
                          ? const BorderSide(
                              color: Color(0xFFEEEEEE),
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: jadwalProvider.jadwals.isEmpty
                      ? const ListTile(
                          title: Text(
                            'Tidak Ada Jadwal',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Column(
                          children: jadwalProvider.jadwals
                              .map(
                                (jadwal) => ListTile(
                                  shape: const Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFEEEEEE),
                                    ),
                                  ),
                                  title: Text(
                                    '${jadwal.kelas!.hari!.toUpperCase()}, ${jadwal.kelas!.jam!}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    jadwal.kelas!.mataPelajaran!.mataPelajaran!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  trailing: Text(
                                    jadwal.siswa!.nama!,
                                    style: TextStyle(
                                      color: Colour.blue,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ],
            ),
    );
  }
}
