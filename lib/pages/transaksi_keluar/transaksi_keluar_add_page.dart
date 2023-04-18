import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/provider/asisten_provider.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/data/provider/trans_kas_keluar_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_datepicker.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransaksiKeluarAddFormPage extends StatefulWidget {
  static const routeName = '/transaksi_keluar_add_update';
  const TransaksiKeluarAddFormPage({super.key, required this.data});
  final TransaksiKasKeluar data;

  @override
  State<TransaksiKeluarAddFormPage> createState() =>
      _TransaksiKeluarAddFormPageState();
}

class _TransaksiKeluarAddFormPageState
    extends State<TransaksiKeluarAddFormPage> {
  late List<JenisKas> listJenisKas;
  late JenisKas kategori;
  static String _displayStringForOptionJenisKas(JenisKas option) =>
      option.namaJenisKas;

  late List<Asisten> listAsisten;
  late Asisten asisten;
  static String _displayStringForOptionAsisten(Asisten option) =>
      option.namaAsisten;

  final _idTransaksiKasKeluarController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _idJenisKasKeluarController = TextEditingController();
  final _idAsistenController = TextEditingController();
  final _nominalController = TextEditingController();
  final _keteranganController = TextEditingController();
  late TextEditingController jenisKasKeluarController = TextEditingController();
  late TextEditingController penerimaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data.idTransaksiKasKeluar != '') {
      _futureJenisKas(widget.data.idJenisKasKeluar);
      _futureAsisten(widget.data.idAsisten);
      setData();
    }
    super.initState();
  }

  _futureJenisKas(String id) {
    if (id != '') {
      Provider.of<JenisKasProvider>(context, listen: false)
          .getJenisKasById(id)
          .then(
        (value) {
          setState(() {
            kategori = value;
            jenisKasKeluarController.text = kategori.namaJenisKas;
          });
        },
      );
    }
  }

  _futureAsisten(String id) {
    if (id != '') {
      Provider.of<AsistenProvider>(context, listen: false)
          .getAsistenById(id)
          .then(
        (value) {
          setState(() {
            asisten = value;
            penerimaController.text = asisten.namaAsisten;
          });
        },
      );
    }
  }

  void setData() {
    _idTransaksiKasKeluarController.text = widget.data.idTransaksiKasKeluar;
    _tanggalController.text = widget.data.tanggal;
    _idJenisKasKeluarController.text = widget.data.idJenisKasKeluar;
    _idAsistenController.text = widget.data.idAsisten;
    _nominalController.text = formatNumber(
      widget.data.nominal.toString().replaceAll(',', ''),
    );
    _keteranganController.text = widget.data.keterangan;
    jenisKasKeluarController = TextEditingController();
    penerimaController = TextEditingController();
    penerimaController.text = widget.data.penerima;
  }

  Future<void> goAddOrUpdate(
      String tanggal,
      String idJenisKasKeluar,
      String jenisKasKeluar,
      String idAsisten,
      String penerima,
      int nominal,
      String keterangan) async {
    debugPrint(
        'ADD TransaksiKasKeluar => TransaksiKasKeluar: $idJenisKasKeluar, tanggal: $tanggal, penerima: $penerima, idAsisten,: $idAsisten, nominal: $nominal, keterangan: $keterangan');
    String id = "KK${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
    String tmpKeterangan = keterangan;
    if (idJenisKasKeluar == "" && jenisKasKeluar != "") {
      tmpKeterangan = "$jenisKasKeluar, Keterangan: $keterangan";
    }
    final dataTransKeluar = TransaksiKasKeluar(
        idTransaksiKasKeluar: widget.data.idTransaksiKasKeluar == ''
            ? id
            : widget.data.idTransaksiKasKeluar,
        tanggal: tanggal,
        idJenisKasKeluar: idJenisKasKeluar,
        idAsisten: idAsisten,
        penerima: penerima,
        nominal: nominal,
        keterangan: tmpKeterangan);
    if (_formKey.currentState!.validate()) {
      if (widget.data.idTransaksiKasKeluar == '') {
        await Provider.of<TransKasKeluarProvider>(context, listen: false)
            .addTransKas(dataTransKeluar);
      } else {
        await Provider.of<TransKasKeluarProvider>(context, listen: false)
            .updateTransKas(dataTransKeluar);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil menyimpan data Kas Keluar"),
          backgroundColor: Colors.green,));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Gagal menyimpan data Kas Keluar"),
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
                child: const Icon(Icons.input,
                    color: Colors.deepPurple, size: 45)),
            const Text(
              "Transaksi Kas Keluar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Silahkan isi data kas keluar pada form dibawah"),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        MyFormDatePicker(
                            myController: _tanggalController,
                            myFieldName: 'Tanggal Transaksi',
                            myIcon: Icons.calendar_month,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please select date"),
                      ],
                    ),
                    Consumer<JenisKasProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultStateDb.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultStateDb.hasData) {
                          listJenisKas = state.result;
                          if (listJenisKas.isNotEmpty) {
                            return Autocomplete<JenisKas>(
                              displayStringForOption:
                                  _displayStringForOptionJenisKas,
                              initialValue: jenisKasKeluarController.value,
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<JenisKas>.empty();
                                } else {
                                  return listJenisKas.where((JenisKas option) {
                                    return option.namaJenisKas
                                        .toString()
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase());
                                  });
                                }
                              },
                              optionsViewBuilder:
                                  (context, onSelected, options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 400,
                                    child: Material(
                                      elevation: 16,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          final option =
                                              options.elementAt(index);
                                          return ListTile(
                                            title: SubstringHighlight(
                                              text: option.namaJenisKas
                                                  .toString(),
                                              term:
                                                  jenisKasKeluarController.text,
                                              textStyleHighlight:
                                                  const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: kErrorBorderColor),
                                            ),
                                            onTap: () {
                                              onSelected(option);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        itemCount: options.length,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onSelected: (JenisKas selected) {
                                _idJenisKasKeluarController.text =
                                    selected.idJenisKas;
                                debugPrint(
                                    'You just selected ${_displayStringForOptionJenisKas(selected)}');
                              },
                              fieldViewBuilder: (context, controller, focusNode,
                                  onEditingComplete) {
                                controller.text =
                                    jenisKasKeluarController.text != ""
                                        ? jenisKasKeluarController.text
                                        : '';
                                jenisKasKeluarController = controller;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    onEditingComplete: onEditingComplete,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Kategori Kas Keluar",
                                        prefixIcon: Icon(
                                          Icons.bookmark,
                                          color: Colors.deepPurple.shade300,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .deepPurple.shade300)),
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: 0)),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Text(
                              "Data kategori kosong.\nTambahkan data kategori terlebih dahulu pada menu Kategori",
                              style: TextStyle(color: Colors.red[800]),
                              textAlign: TextAlign.center,
                            );
                          }
                        } else if (state.state == ResultStateDb.noData) {
                          return Text(
                            "Data kategori kosong.\nTambahkan data kategori terlebih dahulu pada menu Kategori",
                            style: TextStyle(color: Colors.red[800]),
                            textAlign: TextAlign.center,
                          );
                        } else if (state.state == ResultStateDb.error) {
                          return Text(
                            "Data kategori kosong.\nTambahkan data kategori terlebih dahulu pada menu Kategori",
                            style: TextStyle(color: Colors.red[800]),
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Text(
                            "Data kategori kosong.\nTambahkan data kategori terlebih dahulu pada menu Kategori",
                            style: TextStyle(color: Colors.red[800]),
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                    ),
                    Consumer<AsistenProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultStateDb.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultStateDb.hasData) {
                          listAsisten = state.result;
                          if (listAsisten.isNotEmpty) {
                            return Autocomplete<Asisten>(
                              displayStringForOption:
                                  _displayStringForOptionAsisten,
                              initialValue: penerimaController.value,
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<Asisten>.empty();
                                } else {
                                  return listAsisten.where((Asisten option) {
                                    return option.namaAsisten
                                        .toString()
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase());
                                  });
                                }
                              },
                              optionsViewBuilder:
                                  (context, onSelected, options) {
                                return Material(
                                  elevation: 4,
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return ListTile(
                                        title: SubstringHighlight(
                                          text: option.namaAsisten.toString(),
                                          term: penerimaController.text,
                                          textStyleHighlight: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: kErrorBorderColor),
                                        ),
                                        onTap: () {
                                          onSelected(option);
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemCount: options.length,
                                  ),
                                );
                              },
                              onSelected: (Asisten selected) {
                                _idAsistenController.text = selected.idAsisten;
                                debugPrint(
                                    'You just selected ${_displayStringForOptionAsisten(selected)}');
                              },
                              fieldViewBuilder: (context, controller, focusNode,
                                  onEditingComplete) {
                                controller.text = penerimaController.text != ""
                                    ? penerimaController.text
                                    : '';
                                penerimaController = controller;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    onEditingComplete: onEditingComplete,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Kepada",
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.deepPurple.shade300,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .deepPurple.shade300)),
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: 0)),
                                  ),
                                );
                              },
                            );
                          } else {
                            penerimaController = TextEditingController();
                            return MyFormTextfield(
                              myController: penerimaController,
                              myFieldName: "Kepada",
                              myIcon: Icons.person,
                              myPrefixIconColor: Colors.deepPurple.shade300,
                              myValidationNote: "Please enter some text",
                              isCurrency: false,
                              myMaxLine: 1,
                              myKeyboardType: TextInputType.name,
                            );
                          }
                        } else if (state.state == ResultStateDb.noData) {
                          penerimaController = TextEditingController();
                          return MyFormTextfield(
                            myController: penerimaController,
                            myFieldName: "Kepada",
                            myIcon: Icons.person,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please enter some text",
                            isCurrency: false,
                            myMaxLine: 1,
                            myKeyboardType: TextInputType.name,
                          );
                        } else if (state.state == ResultStateDb.error) {
                          penerimaController = TextEditingController();
                          return MyFormTextfield(
                            myController: penerimaController,
                            myFieldName: "Kepada",
                            myIcon: Icons.person,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please enter some text",
                            isCurrency: false,
                            myMaxLine: 1,
                            myKeyboardType: TextInputType.name,
                          );
                        } else {
                          penerimaController = TextEditingController();
                          return MyFormTextfield(
                            myController: penerimaController,
                            myFieldName: "Kepada",
                            myIcon: Icons.person,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please enter some text",
                            isCurrency: false,
                            myMaxLine: 1,
                            myKeyboardType: TextInputType.name,
                          );
                        }
                      },
                    ),
                    MyFormTextfield(
                      myController: _nominalController,
                      myFieldName: "Nominal",
                      myIcon: Icons.attach_money,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: true,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.number,
                    ),
                    MyFormTextfield(
                      myController: _keteranganController,
                      myFieldName: "Keterangan",
                      myIcon: Icons.note_alt_rounded,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 3,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormButton(
                      onPress: () {
                        goAddOrUpdate(
                            _tanggalController.text,
                            _idJenisKasKeluarController.text,
                            jenisKasKeluarController.text,
                            _idAsistenController.text,
                            penerimaController.text,
                            int.parse(
                                _nominalController.text.replaceAll(',', '')),
                            _keteranganController.text);
                      },
                      textButton: widget.data.idTransaksiKasKeluar != ''
                          ? 'simpan'
                          : 'tambah',
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
