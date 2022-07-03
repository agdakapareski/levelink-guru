import 'dart:convert';

import 'package:http/http.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/rating_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';

class RatingApi {
  getRating(int idUser) async {
    Uri url = Uri.parse('$mainUrl/get-rating/$idUser');
    Response response = await get(url);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var data = body['data'];
      List<Rating> ratings = [];

      for (var item in data) {
        Rating r = Rating(
          id: item['id'],
          siswa: Siswa(
            id: item['siswa']['id'],
            nama: item['siswa']['nama_pengguna'],
          ),
          rating: item['rating'].toDouble(),
          evaluasi: item['evaluasi'],
        );

        ratings.add(r);
      }
      double? rataRating = body['rata_rating'].toDouble();

      return SummaryRating(
        rating: ratings,
        rataRating: rataRating,
      );
    }
  }
}
