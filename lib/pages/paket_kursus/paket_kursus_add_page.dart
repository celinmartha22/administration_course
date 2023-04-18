import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/data/provider/paket_kursus_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_dropdown_button.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../constants/formating.dart';

class PaketKursusAddFormPage extends StatefulWidget {
  static const routeName = '/paket_kursus_add_update';
  const PaketKursusAddFormPage({super.key, required this.data});
  final PaketKursus data;

  @override
  State<PaketKursusAddFormPage> createState() => _PaketKursusAddFormPageState();
}

class _PaketKursusAddFormPageState extends State<PaketKursusAddFormPage> {
  List<String> listJenjang = <String>['SD/MI', 'SMP/MTs', 'SMA/SMK'];

  final _namaPaketKursusController = TextEditingController();
  final _jenjangController = TextEditingController();
  final _hargaController = TextEditingController();
  final _periodeController = TextEditingController();
  final _keteranganController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data.idPaketKursus != '') {
      setData();
    }
    super.initState();
  }

  void setData() {
    _namaPaketKursusController.text = widget.data.namaPaketKursus;
    _jenjangController.text = widget.data.jenjang;
    _hargaController.text = formatNumber(
      widget.data.harga.toString().replaceAll(',', ''),
    );
    _periodeController.text = widget.data.berlakuSelama;
    _keteranganController.text = widget.data.keterangan;
  }

  Future<void> goAddOrUpdate(String nama, int harga, String periode,
      String jenjang, String keterangan) async {
    debugPrint(
        'ADD PaketKursus => PaketKursus: $nama, harga: $harga, berlakuSelama: $periode, jenjang: $jenjang, keterangan: $keterangan');
    String id = "C${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
    final dataPaketKursus = PaketKursus(
        idPaketKursus:
            widget.data.idPaketKursus == '' ? id : widget.data.idPaketKursus,
        namaPaketKursus: nama,
        harga: harga,
        berlakuSelama: periode,
        jenjang: jenjang == "" ? 'SD/MI' : jenjang,
        keterangan: keterangan);
    if (_formKey.currentState!.validate()) {
      if (widget.data.idPaketKursus == '') {
        await Provider.of<PaketKursusProvider>(context, listen: false)
            .addPaketKursus(dataPaketKursus);
      } else {
        await Provider.of<PaketKursusProvider>(context, listen: false)
            .updatePaketKursus(dataPaketKursus);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil menyimpan data Kursus"),
          backgroundColor: Colors.green,));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Gagal menyimpan data Kursus"),
          backgroundColor: Colors.red.shade300,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5, vertical: defaultPadding),
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child:
                    const Icon(Icons.book, color: Colors.deepPurple, size: 45)),
            const Text(
              "Paket Kursus",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Tambahkan data paket kursus dalam form di bawah ini"),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyFormTextfield(
                      myController: _namaPaketKursusController,
                      myFieldName: "Nama Paket Kursus",
                      myIcon: Icons.book,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormDropdownButton(
                      listItem: listJenjang,
                      myController: _jenjangController,
                      myFieldName: "Jenjang",
                      myIcon: Icons.school,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValue: _jenjangController.text,
                    ),
                    MyFormTextfield(
                      myController: _hargaController,
                      myFieldName: "Harga",
                      myIcon: Icons.attach_money,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: true,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.number,
                    ),
                    MyFormTextfield(
                      myController: _periodeController,
                      myFieldName: "Berlaku Selama",
                      myIcon: Icons.date_range,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormTextfield(
                      myController: _keteranganController,
                      myFieldName: "Keterangan",
                      myIcon: Icons.note_alt_rounded,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 5,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormButton(
                      onPress: () {
                        goAddOrUpdate(
                            _namaPaketKursusController.text,
                            int.parse(
                                _hargaController.text.replaceAll(",", "")),
                            _periodeController.text,
                            _jenjangController.text,
                            _keteranganController.text);
                      },
                      textButton:
                          widget.data.idPaketKursus != '' ? 'simpan' : 'tambah',
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
