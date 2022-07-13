import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:levelink_guru/detail_pembayaran_page.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/pembayaran_model.dart';
import 'package:levelink_guru/providers/pembayaran_provider.dart';
import 'package:provider/provider.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/providers/cart_provider.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

// TODO: implementasi view pembayaran

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getTransaksi();

    final pembayaranProvider =
        Provider.of<PembayaranProvider>(context, listen: false);
    pembayaranProvider.getPembayaran(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final pembayaranProvider = Provider.of<PembayaranProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Image.asset(
            'Levelink-guru.png',
            height: 35,
          ),
          bottom: TabBar(
            indicatorColor: Colour.blue,
            tabs: const [
              Tab(
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Tagihan',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            cartProvider.loading == false
                ? ListView(
                    children: [
                      cartProvider
                              .transaksi
                              // .where(
                              //   (element) => element.cart!.status! == 'requested',
                              // )
                              .isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartProvider.transaksi.length,
                              itemBuilder: (context, index) {
                                return transactionList(
                                  cartProvider,
                                  index,
                                );
                              },
                            )
                          : PaddedWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text('Tidak ada request'),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  )
                : Center(
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
                  ),
            pembayaranProvider.isLoading == false
                ? ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    children: [
                      const PaddedWidget(
                        child: SmallerTitleText('BELUM DIBAYAR'),
                      ),
                      pembayaranProvider.apiBayar.belumBayar!.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pembayaranProvider
                                  .apiBayar.belumBayar!.length,
                              itemBuilder: (context, index) {
                                Pembayaran belumBayar = pembayaranProvider
                                    .apiBayar.belumBayar![index];
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            DetailPembayaranPage(
                                          idPembayaran: belumBayar.id,
                                          namaGuru: belumBayar.siswa!.nama,
                                          tagihans: belumBayar.tagihan,
                                          totalHarga: belumBayar.totalBayar,
                                          statusBayar: belumBayar.statusBayar,
                                        ),
                                      ),
                                    );
                                  },
                                  shape: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!),
                                  ),
                                  title: Text(
                                    belumBayar.siswa!.nama!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  // subtitle: Text(
                                  //   belumBayar.statusBayar == true
                                  //       ? 'sudah bayar'
                                  //       : 'belum bayar',
                                  //   style: const TextStyle(
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                  trailing: Text(
                                    NumberFormat.simpleCurrency(
                                      name: 'Rp. ',
                                      locale: 'id',
                                    ).format(
                                      belumBayar.totalBayar,
                                    ),
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colour.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: PaddedWidget(
                                child: Text('tagihan kosong'),
                              ),
                            ),
                      const CustomDivider(),
                      const SizedBox(
                        height: 12,
                      ),
                      const PaddedWidget(
                        child: SmallerTitleText('SUDAH DIBAYAR'),
                      ),
                      pembayaranProvider.apiBayar.riwayatBayar!.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pembayaranProvider
                                  .apiBayar.riwayatBayar!.length,
                              itemBuilder: (context, index) {
                                Pembayaran riwayatBayar = pembayaranProvider
                                    .apiBayar.riwayatBayar![index];
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            DetailPembayaranPage(
                                          idPembayaran: riwayatBayar.id,
                                          namaGuru: riwayatBayar.siswa!.nama,
                                          tagihans: riwayatBayar.tagihan,
                                          totalHarga: riwayatBayar.totalBayar,
                                          statusBayar: riwayatBayar.statusBayar,
                                        ),
                                      ),
                                    );
                                  },
                                  shape: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!),
                                  ),
                                  title: Text(
                                    riwayatBayar.siswa!.nama!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  // subtitle: Text(
                                  //   riwayatBayar.statusBayar == true
                                  //       ? 'sudah bayar'
                                  //       : 'belum bayar',
                                  //   style: const TextStyle(
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                  trailing: Text(
                                    NumberFormat.simpleCurrency(
                                      name: 'Rp. ',
                                      locale: 'id',
                                    ).format(
                                      riwayatBayar.totalBayar,
                                    ),
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colour.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: PaddedWidget(
                                child: Text('riwayat kosong'),
                              ),
                            ),
                    ],
                  )
                : Center(
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
                  ),
          ],
        ),
      ),
    );
  }
}

transactionList(CartProvider cartProvider, index) {
  return Slidable(
    endActionPane: ActionPane(motion: const DrawerMotion(), children: [
      SlidableAction(
        onPressed: (context) async {
          cartProvider.storeJadwal(cartProvider.transaksi[index]);
        },
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        icon: Icons.done,
        label: 'Accept',
      ),
      SlidableAction(
        onPressed: (context) {
          cartProvider.rejectJadwal(cartProvider.transaksi[index]);
        },
        backgroundColor: Colour.red,
        foregroundColor: Colors.white,
        icon: Icons.clear,
        label: 'Reject',
      ),
    ]),
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: Row(
              children: [
                Text(
                  cartProvider.transaksi[index].cart!.siswa!.nama!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  cartProvider.transaksi[index].cart!.status!,
                  style: TextStyle(
                    color: cartProvider.transaksi[index].cart!.status! ==
                            'requested'
                        ? Colour.red
                        : Colour.blue,
                  ),
                ),
              ],
            ),
          ),
          PaddedWidget(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: cartProvider.transaksi[index].kelas!
                  .map(
                    (kelas) => Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Row(
                        children: [
                          Text(
                            kelas.mataPelajaran!.mataPelajaran!,
                          ),
                          const Spacer(),
                          Text(
                            '${kelas.hari!}, ${kelas.jam!}',
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    ),
  );
}
