import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/provider/trans_kas_masuk_detail_provider.dart';
import 'package:administration_course/data/provider/trans_kas_masuk_provider.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_add_page.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/formating.dart';
import '../../data/model/jenis_kas.dart';
import '../../data/provider/jenis_kas_provider.dart';
import '../../widgets/page/profile_detail_column.dart';
import '../../widgets/page/profile_detail_row.dart';

class TransaksiMasukDetailPage extends StatefulWidget {
  static const String routeName = 'transaksi_masuk_detail';
  static final ValueNotifier<TransaksiKasMasuk> transaksiNotifier =
      ValueNotifier(TransaksiKasMasuk(
          idTransaksiKasMasuk: '',
          tanggal: '',
          idJenisKasMasuk: '',
          idSiswa: '',
          pembayar: '',
          idPaketKursus: '',
          nominal: 0,
          keterangan: ''));
  const TransaksiMasukDetailPage({Key? key, required this.transMasukId})
      : super(key: key);
  final String transMasukId;

  @override
  State<TransaksiMasukDetailPage> createState() =>
      _TransaksiMasukDetailPageState();
}

class _TransaksiMasukDetailPageState extends State<TransaksiMasukDetailPage> {
  late TransaksiKasMasuk selectedTransaksiKasMasuk;
  late Future<JenisKas> kategori = Provider.of<JenisKasProvider>(context, listen: false)
        .getJenisKasById(widget.transMasukId);

  @override
  void initState() {
    selectedTransaksiKasMasuk = TransaksiKasMasuk(
        idTransaksiKasMasuk: '',
        tanggal: '',
        idJenisKasMasuk: '',
        idSiswa: '',
        pembayar: '',
        idPaketKursus: '',
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
    final transMasuk =
        await Provider.of<TransKasMasukProvider>(context, listen: false)
            .getTransaksiKasMasukById(widget.transMasukId);
    setState(() {
      selectedTransaksiKasMasuk = transMasuk;
      TransaksiMasukDetailPage.transaksiNotifier.value = transMasuk;
      _futureJenisKas(selectedTransaksiKasMasuk.idJenisKasMasuk);
    });
  }

  Future<JenisKas> _futureJenisKas(String id) {
    return kategori = Provider.of<JenisKasProvider>(context, listen: false)
        .getJenisKasById(id);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TransaksiKasMasuk>(
        valueListenable: TransaksiMasukDetailPage.transaksiNotifier,
        builder: (_, tasks, __) {
          final transaksi = tasks;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryLightColor,
              elevation: 0,
              title: Text("Transaksi Kas Masuk Detail",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0)),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        TransaksiMasukAddFormPage.routeName,
                        arguments: selectedTransaksiKasMasuk);
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
                                  'assets/images/Savings-bro.png'),
                            ),
                          ],
                        ),
                        kWidthSizedBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                transaksi.idJenisKasMasuk,
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
                                child: Text(transaksi.pembayar,
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
                      ],
                    ),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileDetailRow(
                          title: 'Transaction Number',
                          value: transaksi.idTransaksiKasMasuk),
                      ProfileDetailRow(
                          title: 'Date', value: transaksi.tanggal),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FutureBuilder<JenisKas>(
                          future: kategori,
                          builder: (BuildContext context,
                              AsyncSnapshot<JenisKas> snapshot) {
                            if (snapshot.hasData) {
                              return ProfileDetailRow(
                                  title: 'Jenis Kas',
                                  value: snapshot.data!.namaJenisKas);
                            } else if (snapshot.hasError) {
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
