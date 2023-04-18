import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/provider/trans_kas_keluar_provider.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_add_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/formating.dart';
import '../../data/model/jenis_kas.dart';
import '../../data/provider/jenis_kas_provider.dart';
import '../../widgets/page/profile_detail_column.dart';
import '../../widgets/page/profile_detail_row.dart';

class TransaksiKeluarDetailPage extends StatefulWidget {
  static const String routeName = 'transaksi_keluar_detail';
  static final ValueNotifier<TransaksiKasKeluar> transaksiNotifier =
      ValueNotifier(TransaksiKasKeluar(
          idTransaksiKasKeluar: '',
          tanggal: '',
          idJenisKasKeluar: '',
          idAsisten: '',
          penerima: '',
          nominal: 0,
          keterangan: ''));
  const TransaksiKeluarDetailPage({Key? key, required this.transKeluarId})
      : super(key: key);
  final String transKeluarId;

  @override
  State<TransaksiKeluarDetailPage> createState() =>
      _TransaksiKeluarDetailPageState();
}

class _TransaksiKeluarDetailPageState extends State<TransaksiKeluarDetailPage> {
  late TransaksiKasKeluar selectedTransaksiKasKeluar;
  late Future<JenisKas> kategori = Provider.of<JenisKasProvider>(context, listen: false)
        .getJenisKasById(widget.transKeluarId);

  @override
  void initState() {
    selectedTransaksiKasKeluar = TransaksiKasKeluar(
        idTransaksiKasKeluar: '',
        tanggal: '',
        idJenisKasKeluar: '',
        idAsisten: '',
        penerima: '',
        nominal: 0,
        keterangan: '');
    _getDataInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getDataInit() async {
    final transKeluar =
        await Provider.of<TransKasKeluarProvider>(context, listen: false)
            .getTransaksiKasKeluarById(widget.transKeluarId);
    setState(() {
      selectedTransaksiKasKeluar = transKeluar;
      TransaksiKeluarDetailPage.transaksiNotifier.value = transKeluar;
      _futureJenisKas(selectedTransaksiKasKeluar.idJenisKasKeluar);
    });
  }

  Future<JenisKas> _futureJenisKas(String id) {
    return kategori = Provider.of<JenisKasProvider>(context, listen: false)
        .getJenisKasById(id);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TransaksiKasKeluar>(
        valueListenable: TransaksiKeluarDetailPage.transaksiNotifier,
        builder: (_, tasks, __) {
          final transaksi = tasks;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryLightColor,
              elevation: 0,
              title: Text("Transaksi Kas Keluar Detail",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0)),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        TransaksiKeluarAddFormPage.routeName,
                        arguments: selectedTransaksiKasKeluar);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: kDefaultPadding / 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit,
                          size: kDefaultPadding,
                        ),
                        const SizedBox(
                          width: kDefaultPadding / 10,
                        ),
                        Text(
                          'Ubah',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0),
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
            body: Container(
              color: kOtherColor,
              child: Column(
                children: [
                  Container(
                    width: 100.w,
                    height:
                        SizerUtil.deviceType == DeviceType.tablet ? 19.h : 18.h,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: kBottomBorderRadius,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        kWidthSizedBox,

                        /// -- IMAGE
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: SizerUtil.deviceType == DeviceType.tablet
                                  ? 12.w
                                  : 11.w,
                              backgroundColor: kSecondaryColor,
                              backgroundImage: const AssetImage(
                                  'assets/images/Plain credit card-bro.png'),
                            ),
                          ],
                        ),
                        kWidthSizedBox,
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  transaksi.idJenisKasKeluar,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0),
                                ),
                                Flexible(
                                  child: Text(transaksi.penerima,
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileDetailRow(
                          title: 'Transaction Number',
                          value: transaksi.idTransaksiKasKeluar),
                      ProfileDetailRow(title: 'Date', value: transaksi.tanggal),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FutureBuilder<JenisKas>(
                          future: kategori,
                          builder: (BuildContext context,
                              AsyncSnapshot<JenisKas> snap) {
                            if (snap.hasData) {
                              return ProfileDetailRow(
                                  title: 'Jenis Kas',
                                  value: snap.data!.namaJenisKas);
                            } else if (snap.hasError) {
                              return const ProfileDetailRow(
                                  title: 'Jenis Kas', value: '');
                            } else {
                              return const ProfileDetailRow(
                                  title: 'Jenis Kas', value: '');
                            }
                          }),
                      ProfileDetailRow(
                          title: 'Nominal',
                          value: "Rp ${formatNumber(
                            transaksi.nominal.toString().replaceAll(',', ''),
                          ).replaceAll(",", ".")}"),
                    ],
                  ),
                  kHalfSizedBox,
                  ProfileDetailColumn(
                    title: 'Keterangan',
                    value: transaksi.keterangan,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
