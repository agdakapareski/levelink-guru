import 'package:flutter/cupertino.dart';
import 'package:levelink_guru/api/cart_api.dart';
import 'package:levelink_guru/api/jadwal_api.dart';
import 'package:levelink_guru/model/jadwal_model.dart';
import 'package:levelink_guru/model/transaksi_model.dart';

class JadwalProvider extends ChangeNotifier {
  List<Jadwal> jadwals = [];
  bool isLoading = false;

  List<Transaksi> transaksi = [];
  bool loading = false;

  getTransaksi() async {
    transaksi = [];
    loading = true;
    transaksi = await CartApi().getCart();
    loading = false;

    notifyListeners();
  }

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
    getTransaksi();
  }
}
