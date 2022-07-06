import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/tagihan_model.dart';
import 'package:levelink_guru/providers/pembayaran_provider.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

import 'custom_theme.dart';

class DetailPembayaranPage extends StatefulWidget {
  final int? idPembayaran;
  final String? namaGuru;
  final List<Tagihan>? tagihans;
  final double? totalHarga;
  final bool? statusBayar;
  const DetailPembayaranPage({
    Key? key,
    required this.idPembayaran,
    required this.namaGuru,
    required this.tagihans,
    required this.totalHarga,
    required this.statusBayar,
  }) : super(key: key);

  @override
  State<DetailPembayaranPage> createState() => _DetailPembayaranPageState();
}

class _DetailPembayaranPageState extends State<DetailPembayaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.namaGuru!,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.payments,
        //       color: Colors.white,
        //     ),
        //     splashRadius: 20,
        //   )
        // ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          const PaddedWidget(
            child: SmallerTitleText('TAGIHAN'),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.tagihans!.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                title: Text(
                  widget.tagihans![index].pertemuan!.materi!,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  '${DateFormat('kk:mm').format(
                    widget.tagihans![index].pertemuan!.jamMulai!,
                  )} - ${DateFormat('kk:mm').format(
                    widget.tagihans![index].pertemuan!.jamSelesai!,
                  )}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Text(
                  NumberFormat.simpleCurrency(
                    name: 'Rp. ',
                    locale: 'id',
                  ).format(
                    widget.tagihans![index].hargaKelas,
                  ),
                ),
              );
            },
          ),
          ListTile(
            shape: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
            title: const Text(
              'Total : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            trailing: Text(
              NumberFormat.simpleCurrency(
                name: 'Rp. ',
                locale: 'id',
              ).format(
                widget.totalHarga,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          // PaddedWidget(
          //   child: CustomButton(
          //     onTap: () {},
          //     color: Colour.blue,
          //     text: 'Bayar Tagihan',
          //   ),
          // ),
        ],
      ),
    );
  }
}
