import 'package:levelink_guru/model/guru_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';

class Cart {
  int? id;
  String? idSiswa;
  String? idGuru;
  String? totalHarga;
  String? status;
  Guru? guru;
  Siswa? siswa;
  List<Map<String, String>>? detail;

  Cart({
    this.id,
    this.idSiswa,
    this.idGuru,
    this.totalHarga,
    this.status,
    this.guru,
    this.siswa,
    this.detail,
  });

  Map<String, dynamic> toJson() => {
        'id_siswa': idSiswa,
        'id_guru': idGuru,
        'total_harga': totalHarga,
        'status': status,
        'detail': detail,
      };
}
