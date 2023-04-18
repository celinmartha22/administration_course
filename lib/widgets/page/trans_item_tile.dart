import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/model/transaksi_kas.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_detail_page.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransItemTile extends StatefulWidget {
  TransItemTile(
      {super.key,
      required this.transactionIn,
      required this.transactionOut,
      required this.transactionAll});
  TransaksiKasMasuk transactionIn;
  TransaksiKasKeluar transactionOut;
  TransaksiKas transactionAll;

  @override
  State<TransItemTile> createState() => _TransItemTileState();
}

class _TransItemTileState extends State<TransItemTile> {
  late Future<JenisKas> kategori;

  @override
  void initState() {
    if (widget.transactionAll.idJenisKas != '') {
      _futureJenisKas(widget.transactionAll.idJenisKas);
    } else if (widget.transactionIn.idJenisKasMasuk != '') {
      _futureJenisKas(widget.transactionIn.idJenisKasMasuk);
    } else {
      _futureJenisKas(widget.transactionOut.idJenisKasKeluar);
    }

    super.initState();
  }

  Future<JenisKas> _futureJenisKas(String id) {
    return kategori = Provider.of<JenisKasProvider>(context, listen: false)
        .getJenisKasById(id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.transactionAll.idJenisKas != ''
          ? widget.transactionAll.kasMasuk != 0
              ? Navigator.of(context).pushNamed(
                  TransaksiMasukDetailPage.routeName,
                  arguments: widget.transactionAll.idDetailKas)
              : Navigator.of(context).pushNamed(
                  TransaksiKeluarDetailPage.routeName,
                  arguments: widget.transactionAll.idDetailKas)
          : widget.transactionIn.idJenisKasMasuk != ''
              ? Navigator.of(context).pushNamed(
                  TransaksiMasukDetailPage.routeName,
                  arguments: widget.transactionIn.idTransaksiKasMasuk)
              : Navigator.of(context).pushNamed(
                  TransaksiKeluarDetailPage.routeName,
                  arguments: widget.transactionOut.idTransaksiKasKeluar),
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 6, horizontal: kDefaultPadding / 3),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset.zero,
                  blurRadius: 3,
                  spreadRadius: 2),
            ],
            color: kTextWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding))),
        child: FutureBuilder<JenisKas>(
            future: kategori,
            builder: (BuildContext context, AsyncSnapshot<JenisKas> snapshot) {
              if (snapshot.hasData) {
                final Color categoryColor = Color(snapshot.data!.warna);
                final IconData categoryIcon = IconData(
                    int.parse(snapshot.data!.ikon),
                    fontFamily: 'MaterialIcons');
                return ListTile(
                  leading: Container(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(kDefaultPadding / 2)),
                      child: Icon(
                        categoryIcon,
                        color: categoryColor,
                      )),
                  title: Text(
                    widget.transactionAll.idTransaksiKas != ''
                        ? snapshot.data!.namaJenisKas
                        : widget.transactionIn.idTransaksiKasMasuk != ''
                            ? widget.transactionIn.pembayar
                            : widget.transactionOut.penerima,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTextBlackColor,
                        letterSpacing: 0),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.transactionAll.idTransaksiKas != ''
                            ? widget.transactionAll.idDetailKas
                            : snapshot.data!.namaJenisKas,
                        style: widget.transactionAll.idTransaksiKas != ''
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.normal,
                                color: kPrimaryColor,
                                letterSpacing: 0)
                            : Theme.of(context).textTheme.labelSmall!.copyWith(
                                fontWeight: FontWeight.normal,
                                color: kPrimaryColor,
                                letterSpacing: 0),
                      ),
                      Text(
                        widget.transactionAll.idTransaksiKas != ''
                            ? "\"${widget.transactionAll.keterangan}\""
                            : widget.transactionIn.idTransaksiKasMasuk != ''
                                ? "\"${widget.transactionIn.keterangan}\""
                                : "\"${widget.transactionOut.keterangan}\"",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: kContainerColor,
                            letterSpacing: 0),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.transactionAll.idTransaksiKas != ''
                            ? widget.transactionAll.kasMasuk != 0
                                ? formatNumber(
                                    widget.transactionAll.kasMasuk.toString())
                                : formatNumber(
                                    widget.transactionAll.kasKeluar.toString())
                            : widget.transactionIn.idTransaksiKasMasuk != ''
                                ? formatNumber(
                                    widget.transactionIn.nominal.toString())
                                : formatNumber(
                                    widget.transactionOut.nominal.toString()),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: widget.transactionIn.nominal == 0 &&
                                        widget.transactionAll.kasMasuk == 0
                                    ? kErrorBorderColor
                                    : Colors.greenAccent[700],
                                letterSpacing: 0),
                      ),
                      Text(
                        widget.transactionAll.idTransaksiKas != ''
                            ? widget.transactionAll.tanggal
                            : widget.transactionIn.idTransaksiKasMasuk != ''
                                ? widget.transactionIn.tanggal
                                : widget.transactionOut.tanggal,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: kContainerColor,
                            letterSpacing: 0),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
