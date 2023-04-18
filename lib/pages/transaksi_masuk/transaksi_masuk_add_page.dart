import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/data/provider/paket_kursus_provider.dart';
import 'package:administration_course/data/provider/siswa_provider.dart';
import 'package:administration_course/data/provider/trans_kas_masuk_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_datepicker.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransaksiMasukAddFormPage extends StatefulWidget {
  static const routeName = '/transaksi_masuk_add_update';
  const TransaksiMasukAddFormPage({super.key, required this.data});
  final TransaksiKasMasuk data;

  @override
  State<TransaksiMasukAddFormPage> createState() =>
      _TransaksiMasukAddFormPageState();
}

class _TransaksiMasukAddFormPageState extends State<TransaksiMasukAddFormPage> {
  late List<JenisKas> listJenisKas;
  late JenisKas kategori;
  static String _displayStringForOptionJenisKas(JenisKas option) =>
      option.namaJenisKas;

  late List<Siswa> listSiswa;
  late Siswa siswa;
  static String _displayStringForOptionSiswa(Siswa option) => option.namaSiswa;

  late List<PaketKursus> listPaketKursus;
  late PaketKursus kursus;
  static String _displayStringForOptionPaketKursus(PaketKursus option) =>
      option.namaPaketKursus;

  final _idTransaksiKasMasukController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _idJenisKasMasukController = TextEditingController();
  final _idSiswaController = TextEditingController();
  final _idPaketKursusController = TextEditingController();
  final _nominalController = TextEditingController();
  final _keteranganController = TextEditingController();
  late TextEditingController jenisKasMasukController = TextEditingController();
  late TextEditingController pembayarController = TextEditingController();
  late TextEditingController paketKursusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPaketKursusShow = false;

  @override
  void initState() {
    if (widget.data.idTransaksiKasMasuk != '') {
      _futureJenisKas(widget.data.idJenisKasMasuk);
      _futureSiswa(widget.data.idSiswa);
      _futurePaketKursus(widget.data.idPaketKursus);
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
            jenisKasMasukController.text = kategori.namaJenisKas;
          });
        },
      );
    }
  }

  _futureSiswa(String id) {
    if (id != '') {
      Provider.of<SiswaProvider>(context, listen: false).getSiswaById(id).then(
        (value) {
          setState(() {
            siswa = value;
            pembayarController.text = siswa.namaSiswa;
          });
        },
      );
    }
  }

  _futurePaketKursus(String id) {
    if (id != '') {
      Provider.of<PaketKursusProvider>(context, listen: false)
          .getPaketKursusById(id)
          .then(
        (value) {
          setState(() {
            kursus = value;
            paketKursusController.text = kursus.namaPaketKursus;
          });
        },
      );
    }
  }

  void setData() {
    _idTransaksiKasMasukController.text = widget.data.idTransaksiKasMasuk;
    _tanggalController.text = widget.data.tanggal;
    _idJenisKasMasukController.text = widget.data.idJenisKasMasuk;
    _idSiswaController.text = widget.data.idSiswa;
    _idPaketKursusController.text = widget.data.idPaketKursus;
    _nominalController.text = formatNumber(
      widget.data.nominal.toString().replaceAll(',', ''),
    );
    _keteranganController.text = widget.data.keterangan;
    jenisKasMasukController = TextEditingController();
    pembayarController = TextEditingController();
    paketKursusController = TextEditingController();
    pembayarController.text = widget.data.pembayar;
  }

  Future<void> goAddOrUpdate(
      String tanggal,
      String idJenisKasMasuk,
      String jenisKasMasuk,
      String idSiswa,
      String pembayar,
      String idPaketKursus,
      String paketKursus,
      int nominal,
      String keterangan) async {
    debugPrint(
        'ADD TransaksiKasMasuk => TransaksiKasMasuk: $idJenisKasMasuk, tanggal: $tanggal, pembayar: $pembayar, pilihanPaket: $idPaketKursus, idSiswa: $idSiswa, nominal: $nominal, keterangan: $keterangan');
    String id = "KM${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
    String tmpKeterangan = keterangan;
    if (idJenisKasMasuk == "" && jenisKasMasuk != "" && paketKursus != "") {
      tmpKeterangan =
          "$jenisKasMasuk kursus $paketKursus, Keterangan: $keterangan";
    } else if (idJenisKasMasuk == "" && jenisKasMasuk != "") {
      tmpKeterangan = "$jenisKasMasuk, Keterangan: $keterangan";
    }
    final dataTransMasuk = TransaksiKasMasuk(
        idTransaksiKasMasuk: widget.data.idTransaksiKasMasuk == ''
            ? id
            : widget.data.idTransaksiKasMasuk,
        tanggal: tanggal,
        idJenisKasMasuk: idJenisKasMasuk,
        idSiswa: idSiswa,
        pembayar: pembayar,
        idPaketKursus: idPaketKursus,
        nominal: nominal,
        keterangan: tmpKeterangan);
    if (_formKey.currentState!.validate()) {
      if (widget.data.idTransaksiKasMasuk == '') {
        await Provider.of<TransKasMasukProvider>(context, listen: false)
            .addTransKas(dataTransMasuk);
      } else {
        await Provider.of<TransKasMasukProvider>(context, listen: false)
            .updateTransKas(dataTransMasuk);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil menyimpan data Kas Masuk"),
          backgroundColor: Colors.green,));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Gagal menyimpan data Kas Masuk"),
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
              "Transaksi Kas Masuk",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Silahkan isi data kas masuk pada form dibawah"),
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
                              initialValue: jenisKasMasukController.value,
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
                                                  jenisKasMasukController.text,
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
                                _idJenisKasMasukController.text =
                                    selected.idJenisKas;
                                debugPrint(
                                    'You just selected ${_displayStringForOptionJenisKas(selected)}');
                              },
                              fieldViewBuilder: (context, controller, focusNode,
                                  onEditingComplete) {
                                controller.text =
                                    jenisKasMasukController.text != ""
                                        ? jenisKasMasukController.text
                                        : '';
                                jenisKasMasukController = controller;
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
                                        labelText: "Kategori Kas Masuk",
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
                    Consumer<SiswaProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultStateDb.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultStateDb.hasData) {
                          listSiswa = state.result;
                          if (listSiswa.isNotEmpty) {
                            return Autocomplete<Siswa>(
                              displayStringForOption:
                                  _displayStringForOptionSiswa,
                              initialValue: pembayarController.value,
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<Siswa>.empty();
                                } else {
                                  return listSiswa.where((Siswa option) {
                                    return option.namaSiswa
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
                                          text: option.namaSiswa.toString(),
                                          term: pembayarController.text,
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
                              onSelected: (Siswa selected) {
                                _idSiswaController.text = selected.idSiswa;
                                setState(() {
                                  _isPaketKursusShow = true;
                                });
                                debugPrint(
                                    'You just selected ${_displayStringForOptionSiswa(selected)}');
                              },
                              fieldViewBuilder: (context, controller, focusNode,
                                  onEditingComplete) {
                                controller.text = pembayarController.text != ""
                                    ? pembayarController.text
                                    : '';
                                pembayarController = controller;
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
                                        labelText: "Dari",
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
                            // Future.delayed(Duration.zero, () {
                            //   setState(() {
                            //     _isPaketKursusShow = false;
                            //   });
                            // });
                            // setState(() {
                            //   _isPaketKursusShow = false;
                            // });
                            pembayarController = TextEditingController();
                            return MyFormTextfield(
                              myController: pembayarController,
                              myFieldName: "Dari",
                              myIcon: Icons.person,
                              myPrefixIconColor: Colors.deepPurple.shade300,
                              myValidationNote: "Please enter some text",
                              isCurrency: false,
                              myMaxLine: 1,
                              myKeyboardType: TextInputType.name,
                            );
                          }
                        } else if (state.state == ResultStateDb.noData) {
                          // Future.delayed(Duration.zero, () {
                          //   setState(() {
                          //     _isPaketKursusShow = false;
                          //   });
                          // });
                          // setState(() {
                          //   _isPaketKursusShow = false;
                          // });
                          pembayarController = TextEditingController();
                          return MyFormTextfield(
                            myController: pembayarController,
                            myFieldName: "Dari",
                            myIcon: Icons.person,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please enter some text",
                            isCurrency: false,
                            myMaxLine: 1,
                            myKeyboardType: TextInputType.name,
                          );
                        } else if (state.state == ResultStateDb.error) {
                          // Future.delayed(Duration.zero, () {
                          //   setState(() {
                          //     _isPaketKursusShow = false;
                          //   });
                          // });
                          // setState(() {
                          //   _isPaketKursusShow = false;
                          // });
                          pembayarController = TextEditingController();
                          return MyFormTextfield(
                            myController: pembayarController,
                            myFieldName: "Dari",
                            myIcon: Icons.person,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please enter some text",
                            isCurrency: false,
                            myMaxLine: 1,
                            myKeyboardType: TextInputType.name,
                          );
                        } else {
                          // Future.delayed(Duration.zero, () {
                          //   setState(() {
                          //     _isPaketKursusShow = false;
                          //   });
                          // });
                          // setState(() {
                          //   _isPaketKursusShow = false;
                          // });
                          pembayarController = TextEditingController();
                          return MyFormTextfield(
                            myController: pembayarController,
                            myFieldName: "Dari",
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
                    Visibility(
                      visible: _isPaketKursusShow,
                      child: Consumer<PaketKursusProvider>(
                        builder: (context, state, _) {
                          if (state.state == ResultStateDb.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.state == ResultStateDb.hasData) {
                            listPaketKursus = state.result;
                            if (listPaketKursus.isNotEmpty) {
                              return Autocomplete<PaketKursus>(
                                displayStringForOption:
                                    _displayStringForOptionPaketKursus,
                                initialValue: paketKursusController.value,
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return const Iterable<PaketKursus>.empty();
                                  } else {
                                    return listPaketKursus
                                        .where((PaketKursus option) {
                                      return option.namaPaketKursus
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
                                            text: option.namaPaketKursus
                                                .toString(),
                                            term: paketKursusController.text,
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
                                onSelected: (PaketKursus selected) {
                                  _idPaketKursusController.text =
                                      selected.idPaketKursus;
                                  debugPrint(
                                      'You just selected ${_displayStringForOptionPaketKursus(selected)}');
                                },
                                fieldViewBuilder: (context, controller,
                                    focusNode, onEditingComplete) {
                                  paketKursusController = controller;
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
                                          labelText: "Paket Kursus",
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
                              paketKursusController = TextEditingController();
                              return MyFormTextfield(
                                myController: paketKursusController,
                                myFieldName: "Paket Kursus",
                                myIcon: Icons.school,
                                myPrefixIconColor: Colors.deepPurple.shade300,
                                myValidationNote: "Please enter some text",
                                isCurrency: false,
                                myMaxLine: 1,
                                myKeyboardType: TextInputType.text,
                              );
                            }
                          } else if (state.state == ResultStateDb.noData) {
                            return MyFormTextfield(
                              myController: paketKursusController,
                              myFieldName: "Paket Kursus",
                              myIcon: Icons.school,
                              myPrefixIconColor: Colors.deepPurple.shade300,
                              myValidationNote: "Please enter some text",
                              isCurrency: false,
                              myMaxLine: 1,
                              myKeyboardType: TextInputType.text,
                            );
                          } else if (state.state == ResultStateDb.error) {
                            return MyFormTextfield(
                              myController: paketKursusController,
                              myFieldName: "Paket Kursus",
                              myIcon: Icons.school,
                              myPrefixIconColor: Colors.deepPurple.shade300,
                              myValidationNote: "Please enter some text",
                              isCurrency: false,
                              myMaxLine: 1,
                              myKeyboardType: TextInputType.text,
                            );
                          } else {
                            return MyFormTextfield(
                              myController: paketKursusController,
                              myFieldName: "Paket Kursus",
                              myIcon: Icons.school,
                              myPrefixIconColor: Colors.deepPurple.shade300,
                              myValidationNote: "Please enter some text",
                              isCurrency: false,
                              myMaxLine: 1,
                              myKeyboardType: TextInputType.text,
                            );
                          }
                        },
                      ),
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
                            _idJenisKasMasukController.text,
                            jenisKasMasukController.text,
                            _idSiswaController.text,
                            pembayarController.text,
                            _idPaketKursusController.text,
                            paketKursusController.text,
                            int.parse(
                                _nominalController.text.replaceAll(',', '')),
                            _keteranganController.text);
                      },
                      textButton: widget.data.idTransaksiKasMasuk != ''
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
