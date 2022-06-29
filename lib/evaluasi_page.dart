import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/model/pertemuan_model.dart';
import 'package:levelink_guru/providers/pertemuan_provider.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/input_form.dart';
import 'package:provider/provider.dart';

class EvaluasiPage extends StatefulWidget {
  final int idPertemuan;
  const EvaluasiPage({Key? key, required this.idPertemuan}) : super(key: key);

  @override
  State<EvaluasiPage> createState() => _EvaluasiPageState();
}

// TODO: implementasi evaluasi

class _EvaluasiPageState extends State<EvaluasiPage> {
  int jawabanFlag = 1;
  TextEditingController evaluasiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pertemuanProvider = Provider.of<PertemuanProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        evaluasiController.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'EVALUASI MURID',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colour.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pemahaman murid tentang materi'),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          jawabanFlag = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: jawabanFlag == 1 ? Colour.red : Colors.white,
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: jawabanFlag == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          jawabanFlag = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: jawabanFlag == 2 ? Colour.red : Colors.white,
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: jawabanFlag == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          jawabanFlag = 3;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: jawabanFlag == 3 ? Colour.red : Colors.white,
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: jawabanFlag == 3
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          jawabanFlag = 4;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: jawabanFlag == 4 ? Colour.red : Colors.white,
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            '4',
                            style: TextStyle(
                              color: jawabanFlag == 4
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          jawabanFlag = 5;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: jawabanFlag == 5 ? Colour.red : Colors.white,
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            '5',
                            style: TextStyle(
                              color: jawabanFlag == 5
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InputForm(
                labelText: 'evaluasi',
                hintText: 'evaluasi',
                controller: evaluasiController,
                maxLines: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () {
                  Pertemuan p = Pertemuan(
                    isAktif: 0,
                    capaian: double.parse(jawabanFlag.toString()),
                    evaluasi: evaluasiController.text,
                  );

                  pertemuanProvider.updatePertemuan(p, widget.idPertemuan);

                  Navigator.popUntil(context, ((route) => route.isFirst));
                },
                color: Colour.blue,
                text: 'Masukkan Evaluasi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
