import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:levelink_guru/list_data.dart';
// import 'package:levelink_guru/model/guru_model.dart';
import 'package:levelink_guru/model/jadwal_model.dart';
import 'package:levelink_guru/model/kelas_model.dart';
import 'package:levelink_guru/model/mata_pelajaran_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';
import 'package:levelink_guru/model/transaksi_model.dart';

class JadwalApi {
  getJadwal(int id) async {
    var url = Uri.parse('$mainUrl/jadwal-guru/$id');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<Jadwal> jadwals = [];

    if (response.statusCode == 200) {
      for (var jadwal in data) {
        Jadwal j = Jadwal(
          id: jadwal['id'],
          siswa: Siswa(
            nama: jadwal['siswa']['nama_pengguna'],
            jenjang: jadwal['siswa']['jenjang'],
            kelas: jadwal['siswa']['kelas'],
          ),
          kelas: Kelas(
            mataPelajaran: MataPelajaran(
              mataPelajaran: jadwal['kelas']['mata_pelajaran_kelas']
                  ['nama_mata_pelajaran'],
              jenjangMataPelajaran: jadwal['kelas']['mata_pelajaran_kelas']
                  ['jenjang_mata_pelajaran'],
            ),
            hari: jadwal['kelas']['hari'],
            jam: jadwal['kelas']['jam'],
          ),
        );

        jadwals.add(j);
      }
      return jadwals;
    }
  }

  storeJadwal(Transaksi transaksi) async {
    var url = Uri.parse('$mainUrl/store-jadwal');
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "id_siswa": transaksi.cart!.siswa!.id,
        "id_kelas": transaksi.kelas!.map((kelas) {
          return {
            "id_kelas": kelas.id,
            "is_aktif": true,
          };
        }).toList(),
        "cart_id": transaksi.cart!.id
      }),
    );

    if (response.statusCode == 200) {
      log('acc sukses');
    } else {
      log(response.body);
    }
  }

  rejectJadwal(Transaksi transaksi) async {
    var url = Uri.parse('$mainUrl/reject-jadwal');
    var response = await http.put(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "cart_id": transaksi.cart!.id,
        "id_kelas": transaksi.kelas!.map((kelas) {
          return {
            "id_kelas": kelas.id,
          };
        }).toList(),
      }),
    );

    if (response.statusCode == 200) {
      log('reject sukses');
    } else {
      log(response.body);
    }
  }
}
