import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:levelink_guru/providers/pertemuan_provider.dart';
import 'package:levelink_guru/widget/padded_widget.dart';
import 'package:provider/provider.dart';

import 'custom_theme.dart';

// TODO: implementasi histori pertemuan

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
    final pertemuanProvider = Provider.of<PertemuanProvider>(
      context,
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
      ),
      body: ListView(
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border:
                        pertemuanProvider.viewPertemuan.pertemuanAktif == null
                            ? Border.all(
                                color: Colour.blue,
                                width: 0.5,
                              )
                            : const Border(),
                    color:
                        pertemuanProvider.viewPertemuan.pertemuanAktif == null
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
                                  pertemuanProvider
                                      .viewPertemuan
                                      .pertemuanAktif!
                                      .jadwal!
                                      .kelas!
                                      .mataPelajaran!
                                      .mataPelajaran!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                Text(
                                  pertemuanProvider.viewPertemuan
                                      .pertemuanAktif!.jadwal!.siswa!.nama!,
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
            height: 16,
          ),
          ListView.builder(
            itemCount: pertemuanProvider.viewPertemuan.riwayatPertemuan!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var riwayat =
                  pertemuanProvider.viewPertemuan.riwayatPertemuan![index];

              return PaddedWidget(
                child: Row(
                  children: [
                    Text(riwayat.materi!),
                    const Spacer(),
                    Text(riwayat.jadwal!.siswa!.nama!),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
