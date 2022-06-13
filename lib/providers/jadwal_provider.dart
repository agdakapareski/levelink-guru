import 'package:flutter/cupertino.dart';
import 'package:levelink_guru/api/jadwal_api.dart';
import 'package:levelink_guru/model/jadwal_model.dart';
import 'package:levelink_guru/model/transaksi_model.dart';

class JadwalProvider extends ChangeNotifier {
  List<Jadwal> jadwals = [];
  bool isLoading = false;

  getJadwal(int id) async {
    jadwals = [];
    isLoading = true;
    JadwalApi().getJadwal(id).then((value) {
      if (value == null) {
        isLoading = false;
        notifyListeners();
      } else {
        jadwals = value;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  storeJadwal(Transaksi transaksi, int id) async {
    JadwalApi().storeJadwal(transaksi);
    jadwals = await JadwalApi().getJadwal(id);
    notifyListeners();
  }
}
