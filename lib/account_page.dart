import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/login_page.dart';
import 'package:levelink_guru/mata_pelajaran_page.dart';
import 'package:levelink_guru/providers/rating_provider.dart';
import 'package:levelink_guru/widget/padded_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'model/rating_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    final ratingProvider = Provider.of<RatingProvider>(context, listen: false);
    ratingProvider.getRating(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ratingProvider = Provider.of<RatingProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Halaman Akun',
        ),
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ratingProvider.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('memuat')
                ],
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 16),
                PaddedWidget(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colour.blue,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            currentnama!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PaddedWidget(
                  child: Row(
                    children: [
                      const Text('Jenjang : '),
                      const Spacer(),
                      Text(currentjenjang!),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PaddedWidget(
                  child: Row(
                    children: [
                      const Text('Performa : '),
                      const Spacer(),
                      Text(
                        ratingProvider.rating.rataRating! < 3
                            ? 'kurang bagus, tingkatkan!'
                            : (ratingProvider.rating.rataRating! >= 3 &&
                                    ratingProvider.rating.rataRating! < 4
                                ? 'cukup, tingkatkan lagi!'
                                : 'sangat bagus!, pertahankan!'),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 16),
                // PaddedWidget(
                //   child: Row(
                //     children: [
                //       const Text('Kelas : '),
                //       const Spacer(),
                //       Text(currentkelas.toString()),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 16),
                const CustomDivider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MataPelajaranPage(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.menu_book,
                    color: Colour.blue,
                  ),
                  title: const Text('Mata Pelajaran Dikuasai'),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    deleteCurrentUser();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colour.red,
                  ),
                  title: const Text('Log Out'),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ),
                const CustomDivider(),
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 16),
                      PaddedWidget(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  ratingProvider.rating.rataRating.toString(),
                                  style: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                  initialRating:
                                      ratingProvider.rating.rataRating!,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize: 20,
                                  onRatingUpdate: (rating) {},
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${ratingProvider.rating.rating!.length} rating',
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  listSummaryRating(
                                      ratingProvider.rating.rating!, 5),
                                  listSummaryRating(
                                      ratingProvider.rating.rating!, 4),
                                  listSummaryRating(
                                      ratingProvider.rating.rating!, 3),
                                  listSummaryRating(
                                      ratingProvider.rating.rating!, 2),
                                  listSummaryRating(
                                      ratingProvider.rating.rating!, 1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      ratingProvider.rating.rating!.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ratingProvider.rating.rating!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colour.blue,
                                            child: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(ratingProvider.rating
                                              .rating![index].siswa!.nama!),
                                          const Spacer(),
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            allowHalfRating: true,
                                            initialRating: ratingProvider
                                                .rating.rating![index].rating!,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 15,
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        ratingProvider
                                            .rating.rating![index].evaluasi!,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const ListTile(
                              title: Text(
                                'belum ada rating',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  listSummaryRating(List<Rating> ratings, double rating) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(rating.toInt().toString()),
        ),
        Expanded(
          flex: 20,
          child: LinearPercentIndicator(
            lineHeight: 8,
            progressColor: Colour.blue,
            percent: ratings.isNotEmpty
                ? ratings
                        .where((element) => element.rating == rating)
                        .toList()
                        .length
                        .toDouble() /
                    ratings.length
                : 0,
          ),
        ),
      ],
    );
  }
}
