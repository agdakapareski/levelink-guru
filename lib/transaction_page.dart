import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:provider/provider.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/providers/cart_provider.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
                      // const CustomDivider(),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // const PaddedWidget(
                      //   child: SmallerTitleText('Tagihan'),
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     border: Border(
                      //       bottom: BorderSide(
                      //         color: Color(0xFFEEEEEE),
                      //       ),
                      //     ),
                      //   ),
                      //   child: PaddedWidget(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: const [
                      //         Text(
                      //           'Belum ada tagihan',
                      //         ),
                      //         SizedBox(
                      //           height: 16,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
            const Center(
              child: Text('Tagihan'),
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
          cartProvider.storeJadwal(cartProvider.transaksi[index], currentid!);
        },
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        icon: Icons.done,
        label: 'Accept',
      ),
      SlidableAction(
        onPressed: (context) {},
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
