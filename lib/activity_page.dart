import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:levelink_guru/evaluasi_page.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/providers/pembayaran_provider.dart';
import 'package:levelink_guru/providers/pertemuan_provider.dart';
import 'package:levelink_guru/widget/confirm_dialog.dart';
import 'package:levelink_guru/widget/padded_widget.dart';
import 'package:provider/provider.dart';

import 'custom_theme.dart';
import 'model/pertemuan_model.dart';

// TODO: implementasi evaluasi

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    final pertemuanProvider = Provider.of<PertemuanProvider>(
      context,
      listen: false,
    );
    pertemuanProvider.getPertemuan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pertemuanProvider = Provider.of<PertemuanProvider>(context);
    final pembayaranProvider = Provider.of<PembayaranProvider>(context);

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
      ),
      body: pertemuanProvider.isLoading == true
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
              children: [
                PaddedWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text('Selamat Datang, '),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Aktifitas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          confirmDialog(
                            title: 'Konfirmasi',
                            confirmation:
                                'Apakah anda ingin menyelesaikan pertemuan?',
                            context: context,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Pertemuan pertemuan = pertemuanProvider
                                        .viewPertemuan.pertemuanAktif!;
                                    Pertemuan p = Pertemuan(
                                      evaluasi: pertemuan.evaluasi,
                                      capaian: pertemuan.capaian,
                                      isAktif: 0,
                                    );
                                    int idPertemuan = pertemuan.id!;
                                    pertemuanProvider.updatePertemuan(
                                      p,
                                      idPertemuan,
                                    );

                                    double hargaKelas = pertemuanProvider
                                        .viewPertemuan
                                        .pertemuanAktif!
                                        .jadwal!
                                        .kelas!
                                        .harga!;

                                    int idSiswa = pertemuanProvider
                                        .viewPertemuan
                                        .pertemuanAktif!
                                        .jadwal!
                                        .siswa!
                                        .id!;

                                    pembayaranProvider.postPembayaran(
                                      currentid!,
                                      idSiswa,
                                      idPertemuan,
                                      hargaKelas,
                                      currentid!,
                                    );

                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EvaluasiPage(
                                          idPertemuan: pertemuan.id!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colour.red,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'selesaikan',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(width: 10),
                              // Expanded(
                              //   child: GestureDetector(
                              //     onTap: () {},
                              //     child: Container(
                              //       padding: const EdgeInsets.all(10),
                              //       decoration: BoxDecoration(
                              //         color: Colour.red,
                              //       ),
                              //       child: const Center(
                              //         child: Text(
                              //           'batal',
                              //           style: TextStyle(
                              //             fontSize: 13,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        },
                        child: KotakAktivitas(pertemuanProvider),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 16,
                ),
                const PaddedWidget(
                  child: Text(
                    'Riwayat Aktifitas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  itemCount:
                      pertemuanProvider.viewPertemuan.riwayatPertemuan!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var riwayat = pertemuanProvider
                        .viewPertemuan.riwayatPertemuan![index];

                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Colour.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.list,
                            label: 'Detail',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EvaluasiPage(
                                    idPertemuan: riwayat.id!,
                                  ),
                                ),
                              );
                            },
                            backgroundColor: Colour.red,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Evaluasi',
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  riwayat.jadwal!.siswa!.nama!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  riwayat.jadwal!.kelas!.mataPelajaran!
                                      .mataPelajaran!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Materi :'),
                                const Spacer(),
                                Text(riwayat.materi!),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Durasi :'),
                                const Spacer(),
                                Text(
                                  '${DateFormat('kk:mm').format(
                                    riwayat.jamMulai!,
                                  )} - ${DateFormat('kk:mm').format(
                                    riwayat.jamSelesai!,
                                  )}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class KotakAktivitas extends StatelessWidget {
  final PertemuanProvider pertemuanProvider;
  const KotakAktivitas(this.pertemuanProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: pertemuanProvider.viewPertemuan.pertemuanAktif == null
            ? Border.all(
                color: Colour.blue,
                width: 0.5,
              )
            : const Border(),
        color: pertemuanProvider.viewPertemuan.pertemuanAktif == null
            ? Colors.white
            : Colour.blue,
      ),
      height: 83,
      child: pertemuanProvider.viewPertemuan.pertemuanAktif == null
          ? const Center(
              child: Text(
                'belum ada kelas aktif',
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'PERTEMUAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      pertemuanProvider.viewPertemuan.pertemuanAktif!.jadwal!
                          .kelas!.mataPelajaran!.mataPelajaran!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      pertemuanProvider
                          .viewPertemuan.pertemuanAktif!.jadwal!.siswa!.nama!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Materi : "${pertemuanProvider.viewPertemuan.pertemuanAktif!.materi!}"',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
    );
  }
}
