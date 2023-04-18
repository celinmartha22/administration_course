import 'dart:async';
import 'dart:io';
import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/model/transaksi_kas.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/data/provider/trans_kas_keluar_provider.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_add_page.dart';
import 'package:administration_course/widgets/confirm_pop_up.dart';
import 'package:administration_course/widgets/form/form_datepicker.dart';
import 'package:administration_course/widgets/page/notification_blank_data_result.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:administration_course/widgets/page/trans_item_tile.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class TransaksiKeluarListPage extends StatefulWidget {
  static const routeName = '/transaksi_keluar_list';
  const TransaksiKeluarListPage({Key? key}) : super(key: key);

  @override
  State<TransaksiKeluarListPage> createState() =>
      _TransaksiKeluarListPageState();
}

class _TransaksiKeluarListPageState extends State<TransaksiKeluarListPage> {
  late Future<List<TransaksiKasKeluar>> listTransKeluar;
  late List<TransaksiKasKeluar> listTrans;
  DateTime startDatetime = DateTime(2000);
  DateTime endDatetime = DateTime(3000);
  late Future<String> totalExpense;
  late String total;
  late JenisKas kategori;
  String searchString = "";
  final searchController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  Future<JenisKas> _futureJenisKas(String id) {
    return Provider.of<JenisKasProvider>(context, listen: false)
        .getJenisKasById(id);
  }

  Future<void> exportToExcel(List<TransaksiKasKeluar> transaksi,
      DateTime? start, DateTime? end) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];
    for (var c = 0; c < 7; c += 1) {
      sheet.setColAutoFit(c);
    }
    CellStyle cellTitleStyle =
        CellStyle(backgroundColorHex: '#f5f5f5', bold: true);

    var dateFormat = DateFormat('dd MMMM yyyy');
    var output = <TransaksiKasKeluar>[];
    if (start != null && end != null) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "ID Transaksi";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .value = "Tanggal";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .value = "Kategori";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .cellStyle = cellTitleStyle;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value = "Nominal";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .value = "Kepada";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .value = "ID Asisten";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .value = "Keterangan";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      for (var i = 1; i <= transaksi.length; i += 1) {
        var date = dateFormat.parse(transaksi[i - 1].tanggal, true);
        debugPrint(
            "${transaksi[i - 1].tanggal} - ${transaksi[i - 1].nominal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
        if (transaksi[i - 1].idJenisKasKeluar != '') {
          kategori = await _futureJenisKas(transaksi[i - 1].idJenisKasKeluar);
        }
        if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
          output.add(transaksi[i - 1]);
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
              .value = transaksi[i - 1].idTransaksiKasKeluar;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
              .value = transaksi[i - 1].tanggal;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
              .value = kategori.namaJenisKas;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
              .value = transaksi[i - 1].nominal;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
              .value = transaksi[i - 1].penerima;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
              .value = transaksi[i - 1].idAsisten;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
              .value = transaksi[i - 1].keterangan;
        }
      }
    }
    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

    File(path.join(
        '/storage/emulated/0/Download/Laporan Kas Keluar - ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Export Laporan Kas Keluar berhasil\nSilahkan buka folder "Download" untuk melihat hasilnya'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransKasKeluarProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          final result = state.result;
          listTrans = result;
          String total = state.total != 'null' && state.total != ''
              ? formatNumber(
                  state.total.replaceAll(',', ''),
                ).replaceAll(',', '.')
              : "0";

          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryLightColor,
              elevation: 0,
              title: Text("Transaksi Kas Keluar",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0)),
            ),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: kDefaultPadding / 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pilih rentang tanggal",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                  letterSpacing: 0),
                        ),
                        InkWell(
                          onTap: () {
                            // Export to excel
                            exportToExcel(listTrans, startDatetime,
                                endDatetime.add(const Duration(days: 1)));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: kDefaultPadding / 7),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Export',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0),
                                ),
                                const SizedBox(
                                  width: kDefaultPadding / 10,
                                ),
                                const Icon(
                                  Icons.feed,
                                  size: kDefaultPadding,
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(
                                  width: kDefaultPadding / 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                    Row(
                      children: [
                        MyFormDatePicker(
                            myController: _startDateController,
                            myFieldName: 'Dari',
                            myIcon: null,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please select date"),
                        SizedBox(
                          width: kDefaultPadding,
                          child: Text(
                            "-",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                    letterSpacing: 0),
                          ),
                        ),
                        MyFormDatePicker(
                            myController: _endDateController,
                            myFieldName: 'Sampai',
                            myIcon: null,
                            myPrefixIconColor: Colors.deepPurple.shade300,
                            myValidationNote: "Please select date"),
                        IconButton(
                            onPressed: () {
                              if ((_startDateController.text != "Dari" &&
                                      _startDateController.text != "") &&
                                  (_endDateController.text != "Sampai" &&
                                      _endDateController.text != "")) {
                                setState(() {
                                  startDatetime = DateFormat('dd MMMM yyyy')
                                      .parse(_startDateController.text);
                                  endDatetime = DateFormat('dd MMMM yyyy')
                                      .parse(_endDateController.text);
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.search,
                              color: kPrimaryColor,
                              size: kDefaultPadding * 2,
                            ))
                      ],
                    ),
                    sizedBox,
                    BuildTotal(
                      listTransaksi: listTrans,
                      startDate: startDatetime,
                      endDate: endDatetime,
                    ),
                    sizedBox,
                    Expanded(
                        child: listTrans.isNotEmpty
                            ? BuildListTransaction(
                                listTransaksi: listTrans,
                                startDate: startDatetime,
                                endDate: endDatetime,
                              )
                            : const NotificationBlankDataResult()),
                  ],
                ),
              ),
            ),
          );
        } else if (state.state == ResultStateDb.noData) {
          return const NotificationNoData();
        } else if (state.state == ResultStateDb.error) {
          return const NotificationErrorData();
        } else {
          return const NotificationDataNotFound();
        }
      },
    );
  }
}

List<TransaksiKasKeluar> _searchTransaksi({
  required List<TransaksiKasKeluar> transaksi,
  required DateTime? start,
  required DateTime? end,
}) {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var output = <TransaksiKasKeluar>[];
  if (start != null && end != null) {
    for (var i = 0; i < transaksi.length; i += 1) {
      var date = dateFormat.parse(transaksi[i].tanggal, true);
      debugPrint(
          "${transaksi[i].tanggal} - ${transaksi[i].nominal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        output.add(transaksi[i]);
      }
    }
  }
  return output;
}

String _getTotal({
  required List<TransaksiKasKeluar> transaksi,
  required DateTime? start,
  required DateTime? end,
}) {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var outputTotalSub = 0;
  if (start != null && end != null) {
    for (var i = 0; i < transaksi.length; i += 1) {
      var date = dateFormat.parse(transaksi[i].tanggal, true);
      debugPrint(
          "${transaksi[i].tanggal} - ${transaksi[i].nominal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        outputTotalSub = outputTotalSub + transaksi[i].nominal;
      }
    }
  }
  return formatNumber(
    outputTotalSub.toString().replaceAll(',', ''),
  ).replaceAll(",", ".");
}

class BuildListTransaction extends StatelessWidget {
  BuildListTransaction(
      {super.key,
      required this.listTransaksi,
      required this.startDate,
      required this.endDate});
  List<TransaksiKasKeluar> listTransaksi;
  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
        return Consumer<TransKasKeluarProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          listTransaksi = state.result;
          final result = _searchTransaksi(
              transaksi: listTransaksi,
              start: startDate,
              end: endDate.add(const Duration(days: 1)));
          final total = _getTotal(
              transaksi: result,
              start: startDate,
              end: endDate.add(const Duration(days: 1)));
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: result.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                autoClose: false,
                onPressed: (context) {
                  final slidable = Slidable.of(context);
                  slidable?.dismiss(
                    ResizeRequest(const Duration(milliseconds: 300), () {
                      debugPrint('Delete on dismissed 2');
                      confirmPopUp(
                          context,
                          "delete_kas_keluar",
                          result[index].idTransaksiKasKeluar,
                          "Hapus",
                          "Hapus 1 data transaksi?",
                          "Ya",
                          "Batal");
                    }),
                  );
                },
                backgroundColor: kErrorBorderColor,
                foregroundColor: Colors.white,
                icon: Icons.delete_forever,
                label: 'Delete',
                borderRadius:
                    const BorderRadius.all(Radius.circular(kDefaultPadding)),
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.2,
            children: [
              SlidableAction(
                onPressed: (context) {
                  debugPrint('Edit on Press');
                  Navigator.of(context).pushNamed(
                      TransaksiKeluarAddFormPage.routeName,
                      arguments: result[index]);
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                borderRadius:
                    const BorderRadius.all(Radius.circular(kDefaultPadding)),
              ),
            ],
          ),
          child: TransItemTile(
            transactionIn: TransaksiKasMasuk(
                idTransaksiKasMasuk: '',
                tanggal: '',
                idJenisKasMasuk: '',
                idSiswa: '',
                pembayar: '',
                idPaketKursus: '',
                nominal: 0,
                keterangan: ''),
            transactionOut: result[index],
            transactionAll: TransaksiKas(
                idTransaksiKas: '',
                tanggal: '',
                kasMasuk: 0,
                kasKeluar: 0,
                idDetailKas: '',
                idJenisKas: '',
                keterangan: ''),
          ),
        );
      },
    );
            } else if (state.state == ResultStateDb.noData) {
          return const NotificationNoData();
        } else if (state.state == ResultStateDb.error) {
          return const NotificationErrorData();
        } else {
          return const NotificationDataNotFound();
        }
      },
    );
  }
}

class BuildTotal extends StatelessWidget {
  BuildTotal(
      {super.key,
      required this.listTransaksi,
      required this.startDate,
      required this.endDate});
  List<TransaksiKasKeluar> listTransaksi;
  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransKasKeluarProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          listTransaksi = state.result;
          final result = _searchTransaksi(
              transaksi: listTransaksi,
              start: startDate,
              end: endDate.add(const Duration(days: 1)));
          final total = _getTotal(
              transaksi: result,
              start: startDate,
              end: endDate.add(const Duration(days: 1)));
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            elevation: 10, // the size of the shadow
            shadowColor: Colors.white, // shadow color
            color: kBackgroundColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: kContainerColor,
                          letterSpacing: 0),
                    ),
                    Text(
                      state.total == "null" || state.total == ""
                          ? "Rp 0"
                          : "Rp $total",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: kPrimaryColor,
                          letterSpacing: 0),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.state == ResultStateDb.noData) {
          return const NotificationNoData();
        } else if (state.state == ResultStateDb.error) {
          return const NotificationErrorData();
        } else {
          return const NotificationDataNotFound();
        }
      },
    );
  }
}


