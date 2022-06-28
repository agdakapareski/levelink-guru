import 'package:levelink_guru/model/siswa_model.dart';
import 'package:levelink_guru/model/tagihan_model.dart';

class Pembayaran {
  int? id;
  double? totalBayar;
  bool? statusBayar;
  Siswa? siswa;
  List<Tagihan>? tagihan;

  Pembayaran({
    this.id,
    this.totalBayar,
    this.statusBayar,
    this.siswa,
    this.tagihan,
  });
}

class ApiBayar {
  List<Pembayaran>? belumBayar;
  List<Pembayaran>? riwayatBayar;

  ApiBayar({
    this.belumBayar,
    this.riwayatBayar,
  });
}
