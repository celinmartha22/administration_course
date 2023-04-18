import 'dart:async';
import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/transaksi_kas.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/provider/trans_kas_keluar_provider.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_add_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_list_page.dart';
import 'package:administration_course/widgets/confirm_pop_up.dart';
import 'package:administration_course/widgets/page/notification_blank_data_result.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:administration_course/widgets/page/trans_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransaksiKeluarPage extends StatefulWidget {
  static const routeName = '/transaksi_keluar';
  const TransaksiKeluarPage({Key? key}) : super(key: key);

  @override
  State<TransaksiKeluarPage> createState() => _TransaksiKeluarPageState();
}

class _TransaksiKeluarPageState extends State<TransaksiKeluarPage> {
  late Future<List<TransaksiKasKeluar>> listTransKeluar;
  late Future<String> totalIncome;
  String searchString = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildDataTransaksi(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TransaksiKeluarAddFormPage.routeName,
              arguments: TransaksiKasKeluar(
                  idTransaksiKasKeluar: '',
                  tanggal: '',
                  idJenisKasKeluar: '',
                  idAsisten: '',
                  penerima: '',
                  nominal: 0,
                  keterangan: ''));
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BuildDataTransaksi extends StatelessWidget {
  const BuildDataTransaksi({
    super.key,
  });

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
          String total = state.total != 'null' && state.total != ''
              ? formatNumber(
                  state.total.replaceAll(',', ''),
                ).replaceAll(',', '.')
              : "0";
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: kDefaultPadding / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Total",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: kContainerColor,
                                  letterSpacing: 0),
                        ),
                        Text(
                          state.total == "null" || state.total == ""
                              ? "Rp 0"
                              : "Rp $total",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: kPrimaryColor,
                                  letterSpacing: 0),
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaksi terakhir",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kContainerColor,
                            letterSpacing: 0),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              kSecondaryLightColor.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(TransaksiKeluarListPage.routeName);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Lihat\nSelengkapnya",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                      letterSpacing: 0),
                            ),
                            const Icon(
                              Icons.arrow_right,
                              color: kPrimaryColor,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  kHalfSizedBox,
                  Expanded(
                      child: result.isNotEmpty
                          ? BuildListTransaction(
                              listTransaksi: result,
                            )
                          : const NotificationBlankDataResult()),
                ],
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

class BuildListTransaction extends StatelessWidget {
  BuildListTransaction({super.key, required this.listTransaksi});
  List<TransaksiKasKeluar> listTransaksi;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: listTransaksi.length,
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
                          listTransaksi[index].idTransaksiKasKeluar,
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
                  // Navigator.of(context).pushNamed(
                  //     TransaksiKeluarAddFormPage.routeName,
                  //     arguments: listTransaksi[index]);
                  Navigator.of(context).pushNamed(
                      TransaksiKeluarAddFormPage.routeName,
                      arguments: listTransaksi[index]);
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
            transactionOut: listTransaksi[index],
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
  }
}
