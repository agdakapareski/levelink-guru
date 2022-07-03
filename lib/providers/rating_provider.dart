import 'package:flutter/cupertino.dart';
import 'package:levelink_guru/api/rating_api.dart';
import 'package:levelink_guru/model/rating_model.dart';

class RatingProvider extends ChangeNotifier {
  SummaryRating rating = SummaryRating();
  bool isLoading = false;

  getRating(int idUser) async {
    isLoading = true;
    rating = await RatingApi().getRating(idUser);
    isLoading = false;

    notifyListeners();
  }
}
