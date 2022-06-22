import 'package:levelink_guru/model/jadwal_model.dart';

class Pertemuan {
  int? id;
  int? idJadwal;
  Jadwal? jadwal;
  String? materi;
  int? isAktif;
  String? evaluasi;
  double? capaian;

  Pertemuan({
    this.id,
    this.idJadwal,
    this.jadwal,
    this.materi,
    this.isAktif,
    this.evaluasi,
    this.capaian,
  });
}

class ViewPertemuan {
  Pertemuan? pertemuanAktif;
  List<Pertemuan>? riwayatPertemuan;

  ViewPertemuan({
    this.pertemuanAktif,
    this.riwayatPertemuan,
  });
}
