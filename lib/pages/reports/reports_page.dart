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
import 'package:administration_course/data/provider/trans_kas_masuk_provider.dart';
import 'package:administration_course/data/provider/trans_kas_provider.dart';
import 'package:administration_course/widgets/form/form_datepicker.dart';
import 'package:administration_course/widgets/page/income_expense_card.dart';
import 'package:administration_course/widgets/page/notification_blank_data_result.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:administration_course/widgets/page/trans_item_tile.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class ReportsPage extends StatefulWidget {
  static const routeName = '/laporan';
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late Future<List<TransaksiKas>> listTrans;
  late List<TransaksiKas> listTransAll;
  DateTime startDatetime = DateTime(2000);
  DateTime endDatetime = DateTime(3000);
  late Future<String> totalIncome;
  late String total;
  late JenisKas kategori;
  late TransaksiKasMasuk kasMasuk;
  late TransaksiKasKeluar kasKeluar;
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

  Future<TransaksiKasMasuk> _futureKasMasuk(String id) {
    return Provider.of<TransKasMasukProvider>(context, listen: false)
        .getTransaksiKasMasukById(id);
  }

  Future<TransaksiKasKeluar> _futureKasKeluar(String id) {
    return Provider.of<TransKasKeluarProvider>(context, listen: false)
        .getTransaksiKasKeluarById(id);
  }

  Future<void> exportToExcel(
      List<TransaksiKas> transaksi, DateTime? start, DateTime? end) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];
    for (var c = 0; c < 8; c += 1) {
      sheet.setColAutoFit(c);
    }

    CellStyle cellTitleStyle =
        CellStyle(backgroundColorHex: '#f5f5f5', bold: true);

    var dateFormat = DateFormat('dd MMMM yyyy');
    var output = <TransaksiKas>[];
    if (start != null && end != null) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "ID Buku Kas";
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
          .value = "Masuk";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value = "Keluar";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .value = "Kategori";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .value = "ID Transaksi";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .value = "Dari/Kepada";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0))
          .value = "Keterangan";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0))
          .cellStyle = cellTitleStyle;

      for (var i = 1; i <= transaksi.length; i += 1) {
        var date = dateFormat.parse(transaksi[i - 1].tanggal, true);
        debugPrint(
            "${transaksi[i - 1].tanggal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
        if (transaksi[i - 1].idJenisKas != '') {
          kategori = await _futureJenisKas(transaksi[i - 1].idJenisKas);
        }

        if (transaksi[i - 1].kasMasuk > 0) {
          kasMasuk = await _futureKasMasuk(transaksi[i - 1].idDetailKas);
        }

        if (transaksi[i - 1].kasKeluar > 0) {
          kasKeluar = await _futureKasKeluar(transaksi[i - 1].idDetailKas);
        }

        if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
          output.add(transaksi[i - 1]);
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
              .value = transaksi[i - 1].idTransaksiKas;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
              .value = transaksi[i - 1].tanggal;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
              .value = transaksi[i - 1].kasMasuk;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
              .value = transaksi[i - 1].kasKeluar;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
              .value = kategori.namaJenisKas;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
              .value = transaksi[i - 1].idDetailKas;

          sheet
                  .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
                  .value =
              kasMasuk.idJenisKasMasuk != ''
                  ? kasMasuk.pembayar
                  : kasKeluar.penerima;

          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
              .value = transaksi[i - 1].keterangan;
        }
      }
    }
    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

    File(path.join(
        '/storage/emulated/0/Download/Laporan Keuangan - ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Export Laporan Keuangan berhasil\nSilahkan buka folder "Download" untuk melihat hasilnya'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransKasProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          final result = state.result;
          listTransAll = result;
          return Scaffold(
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
                            exportToExcel(listTransAll, startDatetime,
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
                      listTransaksi: listTransAll,
                      startDate: startDatetime,
                      endDate: endDatetime,
                    ),
                    sizedBox,
                    BuildIncomeExpense(
                        listTransaksi: listTransAll,
                        startDatetime: startDatetime,
                        endDatetime: endDatetime),
                    kHalfSizedBox,
                    Expanded(
                        child: listTransAll.isNotEmpty
                            ? BuildListTransaction(
                                listTransaksi: listTransAll,
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

class BuildIncomeExpense extends StatelessWidget {
  BuildIncomeExpense({
    super.key,
    required this.listTransaksi,
    required this.startDatetime,
    required this.endDatetime,
  });

  List<TransaksiKas> listTransaksi;
  DateTime startDatetime;
  DateTime endDatetime;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransKasProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          listTransaksi = state.result;
          final result = _searchTransaksi(
              transaksi: listTransaksi,
              start: startDatetime,
              end: endDatetime.add(const Duration(days: 1)));
          final totalSaldoMasuk = _getTotalMasuk(
              transaksi: result,
              start: startDatetime,
              end: endDatetime.add(const Duration(days: 1)));

          final totalSaldoKeluar = _getTotalKeluar(
              transaksi: result,
              start: startDatetime,
              end: endDatetime.add(const Duration(days: 1)));
          if (result.isNotEmpty) {
            return Row(
              children: [
                Expanded(
                    child: IncomeExpenseCard(
                  label: "Income",
                  amount: totalSaldoMasuk,
                  icon: Icons.arrow_upward,
                  color: kPrimaryColor,
                )),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 40,
                ),
                Expanded(
                    child: IncomeExpenseCard(
                  label: "Expense",
                  amount: totalSaldoKeluar,
                  icon: Icons.arrow_downward,
                  color: kSecondaryColor,
                )),
              ],
            );
          } else {
            return const NotificationBlankDataResult();
          }
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

List<TransaksiKas> _searchTransaksi({
  required List<TransaksiKas> transaksi,
  required DateTime? start,
  required DateTime? end,
}) {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var output = <TransaksiKas>[];
  if (start != null && end != null) {
    for (var i = 0; i < transaksi.length; i += 1) {
      var date = dateFormat.parse(transaksi[i].tanggal, true);
      debugPrint(
          "${transaksi[i].tanggal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        output.add(transaksi[i]);
      }
    }
  }
  return output;
}

String _getTotal({
  required List<TransaksiKas> transaksi,
  required DateTime? start,
  required DateTime? end,
}) {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var outputTotalSub = 0;
  if (start != null && end != null) {
    for (var i = 0; i < transaksi.length; i += 1) {
      var date = dateFormat.parse(transaksi[i].tanggal, true);
      debugPrint(
          "${transaksi[i].tanggal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        outputTotalSub =
            outputTotalSub + (transaksi[i].kasMasuk - transaksi[i].kasKeluar);
      }
    }
  }
  return formatNumber(
    outputTotalSub.toString().replaceAll(',', ''),
  ).replaceAll(",", ".");
}

String _getTotalMasuk({
  required List<TransaksiKas> transaksi,
  required DateTime? start,
  required DateTime? end,
}) {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var outputTotalSub = 0;
  if (start != null && end != null) {
    for (var i = 0; i < transaksi.length; i += 1) {
      var date = dateFormat.parse(transaksi[i].tanggal, true);
      debugPrint(
          "${transaksi[i].tanggal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        outputTotalSub = outputTotalSub + transaksi[i].kasMasuk;
      }
    }
  }
  return formatNumber(
    outputTotalSub.toString().replaceAll(',', ''),
  ).replaceAll(",", ".");
}

String _getTotalKeluar({
  required List<TransaksiKas> transaksi,
  required DateTime? start,
  required DateTime? end,
}) {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var outputTotalSub = 0;
  if (start != null && end != null) {
    for (var i = 0; i < transaksi.length; i += 1) {
      var date = dateFormat.parse(transaksi[i].tanggal, true);
      debugPrint(
          "${transaksi[i].tanggal} => date.compareTo(start) = ${date.compareTo(start)};   date.compareTo(end) = ${date.compareTo(end)}");
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        outputTotalSub = outputTotalSub + transaksi[i].kasKeluar;
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
  List<TransaksiKas> listTransaksi;
  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransKasProvider>(
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
          if (result.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: result.length,
              itemBuilder: (context, index) {
                return TransItemTile(
                  transactionIn: TransaksiKasMasuk(
                      idTransaksiKasMasuk: '',
                      tanggal: '',
                      idJenisKasMasuk: '',
                      idSiswa: '',
                      pembayar: '',
                      idPaketKursus: '',
                      nominal: 0,
                      keterangan: ''),
                  transactionOut: TransaksiKasKeluar(
                      idTransaksiKasKeluar: '',
                      tanggal: '',
                      idJenisKasKeluar: '',
                      idAsisten: '',
                      penerima: '',
                      nominal: 0,
                      keterangan: ''),
                  transactionAll: result[index],
                );
              },
            );
          } else {
            return const NotificationBlankDataResult();
          }
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
  List<TransaksiKas> listTransaksi;
  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransKasProvider>(
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
          return Center(
            child: Column(
              children: [
                Text(
                  "Total Saldo",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: kContainerColor,
                      letterSpacing: 0),
                ),
                Text(
                  total == "null" || total == "" ? "Rp 0" : "Rp $total",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: kPrimaryColor,
                      letterSpacing: 0),
                ),
              ],
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
