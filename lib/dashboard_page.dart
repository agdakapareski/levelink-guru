/// File: dashboard_page.dart
///
/// File ini berisi UI untuk halaman dashboard.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:levelink_guru/model/jadwal_model.dart';
import 'package:levelink_guru/mulai_kelas_page.dart';
import 'package:levelink_guru/providers/pertemuan_provider.dart';
import 'package:levelink_guru/providers/tab_provider.dart';
import 'package:levelink_guru/widget/confirm_dialog.dart';
import 'package:provider/provider.dart';
import 'package:levelink_guru/account_page.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/providers/jadwal_provider.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hours = hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hours:$min";
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String jamSekarang = TimeOfDay.now().to24hours();
  @override
  void initState() {
    initializeDateFormatting();
    final jadwalProvider = Provider.of<JadwalProvider>(context, listen: false);
    jadwalProvider.getJadwal(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context);
    final jadwalProvider = Provider.of<JadwalProvider>(context);
    final pertemuanProvider = Provider.of<PertemuanProvider>(context);

    String hariIni = DateFormat('EEEE', 'id').format(
      DateTime.parse(DateTime.now().toString()),
    );

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
                  child: SmallerTitleText('JADWAL MENGAJAR'),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: jadwalProvider.jadwals.length,
                          itemBuilder: (context, index) {
                            Jadwal jadwal = jadwalProvider.jadwals[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.7,
                                children: [
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      if (jadwal.kelas!.hari == hariIni &&
                                          jadwal.kelas!.jam == jamSekarang) {
                                        log('jadwal: ${jadwal.kelas!.hari}, ${jadwal.kelas!.jam}\nhari ini: $hariIni, $jamSekarang\nhari dan jam sama');
                                      } else {
                                        if (pertemuanProvider
                                                .viewPertemuan.pertemuanAktif ==
                                            null) {
                                          confirmDialog(
                                            title: 'Konfirmasi Beda Jadwal',
                                            confirmation:
                                                'Apakah anda yakin ingin memulai kelas sekarang?',
                                            context: context,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Route route =
                                                        MaterialPageRoute(
                                                      builder: (context) =>
                                                          MulaiKelasPage(
                                                        jadwal: jadwal,
                                                      ),
                                                    );

                                                    Navigator.push(
                                                      context,
                                                      route,
                                                    );
                                                    tabProvider.changeScreen(1);
                                                  },
                                                  // Navigator.pop(context);
                                                  // Slidable.of(context)!.close();

                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colour.blue,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'mulai',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Slidable.of(context)!
                                                        .close();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colour.red,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'batal',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          var snackBar = SnackBar(
                                            content: const Text(
                                                'Sedang ada pertemuan aktif!'),
                                            action: SnackBarAction(
                                              textColor: Colors.blue,
                                              label: 'dismiss',
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    backgroundColor: Colour.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.done,
                                    label: 'Mulai Kelas',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {},
                                    backgroundColor: Colour.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.clear,
                                    label: 'Akhiri Kelas',
                                  ),
                                ],
                              ),
                              child: ListTile(
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
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
