class Pertemuan {
  int? id;
  int? idJadwal;
  String? materi;
  int? isAktif;
  String? evaluasi;
  int? capaian;

  Pertemuan({
    this.id,
    this.idJadwal,
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
