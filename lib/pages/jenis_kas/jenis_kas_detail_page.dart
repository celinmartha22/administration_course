import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/provider/jenis_kas_detail_provider.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_add_page.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/page/profile_detail_column.dart';

class JenisKasDetailPage extends StatefulWidget {
  static const String routeName = 'jenis_kas_detail';
  static final ValueNotifier<JenisKas> kategoriNotifier = ValueNotifier(
      JenisKas(
          idJenisKas: '', namaJenisKas: '', status: '', warna: 0, ikon: ''));
  const JenisKasDetailPage({Key? key, required this.jenisKasId})
      : super(key: key);
  final String jenisKasId;

  @override
  State<JenisKasDetailPage> createState() => _JenisKasDetailPageState();
}

class _JenisKasDetailPageState extends State<JenisKasDetailPage> {
  late JenisKas selectedJenisKas;
  @override
  void initState() {
    selectedJenisKas = JenisKas(
        idJenisKas: '', namaJenisKas: '', status: '', warna: 0, ikon: '');
    _getDataInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getDataInit() async {
    final jenisKasData =
        await Provider.of<JenisKasProvider>(context, listen: false)
            .getJenisKasById(widget.jenisKasId);
    setState(() {
      selectedJenisKas = jenisKasData;
      JenisKasDetailPage.kategoriNotifier.value = jenisKasData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<JenisKas>(
      valueListenable: JenisKasDetailPage.kategoriNotifier,
      builder: (_, tasks, __) {
        final kategori = tasks;
        return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryLightColor,
                  elevation: 0,
                  title: Text("Detail Kategori",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0)),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            JenisKasAddFormPage.routeName,
                            arguments: selectedJenisKas);
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.only(right: kDefaultPadding / 7),
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
                                  .labelSmall!
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
                        height: SizerUtil.deviceType == DeviceType.tablet
                            ? 19.h
                            : 18.h,
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
                                  radius:
                                      SizerUtil.deviceType == DeviceType.tablet
                                          ? 12.w
                                          : 11.w,
                                  backgroundColor: kSecondaryColor,
                                  backgroundImage: const AssetImage(
                                      'assets/images/E-Wallet-rafiki.png'),
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
                                    kategori.namaJenisKas,
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
                                    child: Text(kategori.status,
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
                      ProfileDetailColumn(
                        title: 'ID Kategori',
                        value: kategori.idJenisKas,
                      ),
                      ProfileDetailColumn(
                        title: 'Nama',
                        value: kategori.namaJenisKas,
                      ),
                      ProfileDetailColumn(
                        title: 'Status',
                        value: kategori.status,
                      ),
                      ProfileDetailColumn(
                        title: 'Ikon',
                        value: '',
                        ikon: kategori.ikon,
                      ),
                      ProfileDetailColumn(
                        title: 'Warna',
                        value: '',
                        warna: kategori.warna,
                      ),
                    ],
                  ),
                ),
              );
            
  });
  }
}
