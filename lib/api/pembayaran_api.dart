import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/guru_model.dart';
import 'package:levelink_guru/model/pembayaran_model.dart';
import 'package:levelink_guru/model/pertemuan_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';
import 'package:levelink_guru/model/tagihan_model.dart';

class PembayaranApi {
  tambahPembayaran(
    int idGuru,
    int idSiswa,
    int idPertemuan,
    double hargaKelas,
  ) async {
    var url = Uri.parse('$mainUrl/pembayaran');
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "id_guru": idGuru,
        "id_siswa": idSiswa,
        "id_pertemuan": idPertemuan,
        "harga_kelas": hargaKelas,
        "status_bayar": false
      }),
    );

    if (response.statusCode == 200) {
      log('berhasil membuat tagihan');
    } else {
      log(response.body);
    }
  }

  getPembayaran(int idUser) async {
    var url = Uri.parse('$mainUrl/pembayaran/$idUser');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var listDataBelumBayar = body['belum_bayar'];
    var listDataRiwayatBayar = body['riwayat_bayar'];

    List<Pembayaran> belumBayar = [];
    List<Pembayaran> riwayatBayar = [];
    List<Tagihan> tagihans = [];
    List<Tagihan> riwayatTagihan = [];

    if (response.statusCode == 200) {
      if (listDataBelumBayar != []) {
        for (var data in listDataBelumBayar) {
          for (var tagihan in data['tagihan']) {
            Tagihan t = Tagihan(
              id: tagihan['id'],
              hargaKelas: tagihan['harga_kelas'].runtimeType == int
                  ? double.parse(tagihan['harga_kelas'].toString())
                  : tagihan['harga_kelas'],
              pertemuan: Pertemuan(
                materi: tagihan['pertemuan']['materi'],
              ),
            );

            tagihans.add(t);
          }
          Pembayaran bayar = Pembayaran(
            id: data['id'],
            totalBayar: data['total_bayar'].runtimeType == int
                ? double.parse(data['total_bayar'].toString())
                : data['total_bayar'],
            statusBayar: data['status_bayar'] == 1 ? true : false,
            siswa: Siswa(
              id: data['siswa']['id'],
              nama: data['siswa']['nama_pengguna'],
            ),
            tagihan: tagihans,
          );

          belumBayar.add(bayar);
        }
      } else {
        belumBayar = [];
      }

      if (listDataRiwayatBayar != []) {
        for (var data in listDataRiwayatBayar) {
          for (var tagihan in data['tagihan']) {
            Tagihan t = Tagihan(
              id: tagihan['id'],
              hargaKelas: tagihan['harga_kelas'].runtimeType == int
                  ? double.parse(tagihan['harga_kelas'].toString())
                  : tagihan['harga_kelas'],
              pertemuan: Pertemuan(
                materi: tagihan['pertemuan']['materi'],
              ),
            );

            riwayatTagihan.add(t);
          }
          Pembayaran bayar = Pembayaran(
            id: data['id'],
            totalBayar: data['total_bayar'].runtimeType == int
                ? double.parse(data['total_bayar'].toString())
                : data['total_bayar'],
            statusBayar: data['status_bayar'] == 1 ? true : false,
            siswa: Siswa(
              id: data['siswa']['id'],
              nama: data['siswa']['nama_pengguna'],
            ),
            tagihan: riwayatTagihan,
          );

          riwayatBayar.add(bayar);
        }
      } else {
        riwayatBayar = [];
      }

      return ApiBayar(
        belumBayar: belumBayar,
        riwayatBayar: riwayatBayar,
      );
    }
  }
}
