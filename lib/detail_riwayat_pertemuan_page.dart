import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/evaluasi_page.dart';
import 'package:levelink_guru/model/pertemuan_model.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

class DetailRiwayatPertemuanPage extends StatefulWidget {
  final Pertemuan? riwayat;
  const DetailRiwayatPertemuanPage({
    Key? key,
    required this.riwayat,
  }) : super(key: key);

  @override
  State<DetailRiwayatPertemuanPage> createState() =>
      _DetailRiwayatPertemuanPageState();
}

class _DetailRiwayatPertemuanPageState
    extends State<DetailRiwayatPertemuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.riwayat!.jadwal!.siswa!.nama!,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: Row(
              children: [
                const Text('Materi : '),
                const Spacer(),
                SmallerTitleText(widget.riwayat!.materi!),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: Row(
              children: [
                const Text('Skor Pemahaman : '),
                const Spacer(),
                SmallerTitleText(widget.riwayat!.capaian!.toString()),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Evaluasi Guru : '),
                const SizedBox(
                  height: 14.5,
                ),
                Text(
                  widget.riwayat!.evaluasi!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          widget.riwayat!.capaian! == 0 && widget.riwayat!.evaluasi! == '-'
              ? PaddedWidget(
                  child: CustomButton(
                    color: Colour.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EvaluasiPage(
                            idPertemuan: widget.riwayat!.id!,
                          ),
                        ),
                      );
                    },
                    text: 'Evaluasi',
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
