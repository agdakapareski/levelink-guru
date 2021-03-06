import 'package:flutter/cupertino.dart';
import 'package:levelink_guru/api/cart_api.dart';
import 'package:levelink_guru/api/jadwal_api.dart';
import 'package:levelink_guru/model/transaksi_model.dart';

class CartProvider extends ChangeNotifier {
  List<Transaksi> transaksi = [];
  bool loading = false;

  getTransaksi() async {
    transaksi = [];
    loading = true;
    transaksi = await CartApi().getCart();
    loading = false;

    notifyListeners();
  }

  storeJadwal(Transaksi t) async {
    await JadwalApi().storeJadwal(t);
    transaksi = await CartApi().getCart();
    notifyListeners();
  }

  rejectJadwal(Transaksi t) async {
    await JadwalApi().rejectJadwal(t);
    transaksi = await CartApi().getCart();
    notifyListeners();
  }
}
