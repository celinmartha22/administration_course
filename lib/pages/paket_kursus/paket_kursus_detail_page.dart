import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/data/provider/paket_kursus_detail_provider.dart';
import 'package:administration_course/data/provider/paket_kursus_provider.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_add_page.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/page/profile_detail_column.dart';

class PaketKursusDetailPage extends StatefulWidget {
  static const String routeName = 'paket_kursus_detail';
    static final ValueNotifier<PaketKursus> kursusNotifier = ValueNotifier(PaketKursus(
        idPaketKursus: '',
        namaPaketKursus: '',
        harga: 0,
        berlakuSelama: '',
        jenjang: '',
        keterangan: ''));
  const PaketKursusDetailPage({Key? key, required this.paketKursusId})
      : super(key: key);
  final String paketKursusId;

  @override
  State<PaketKursusDetailPage> createState() => _PaketKursusDetailPageState();
}

class _PaketKursusDetailPageState extends State<PaketKursusDetailPage> {
  late PaketKursus selectedPaketKursus;
  @override
  void initState() {
    selectedPaketKursus = PaketKursus(
        idPaketKursus: '',
        namaPaketKursus: '',
        harga: 0,
        berlakuSelama: '',
        jenjang: '',
        keterangan: '');
    _getDataInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getDataInit() async {
    final paketKursusData =
        await Provider.of<PaketKursusProvider>(context, listen: false)
            .getPaketKursusById(widget.paketKursusId);
    setState(() {
      selectedPaketKursus = paketKursusData;
      PaketKursusDetailPage.kursusNotifier.value = paketKursusData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PaketKursus>(
      valueListenable: PaketKursusDetailPage.kursusNotifier,
      builder: (_, tasks, __) {
        final kursus = tasks;
        return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryLightColor,
                  elevation: 0,
                  title: Text("Detail Kursus",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0)),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            PaketKursusAddFormPage.routeName,
                            arguments: selectedPaketKursus);
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
                                      'assets/images/Dictionary.png'),
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
                                      kursus.namaPaketKursus,
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
                                      child: Text(kursus.jenjang,
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
                      ProfileDetailColumn(
                        title: 'Nama Kursus',
                        value: kursus.namaPaketKursus,
                      ),
                      ProfileDetailColumn(
                        title: 'ID Kursus',
                        value: kursus.idPaketKursus,
                      ),
                      ProfileDetailColumn(
                        title: 'Jenjang',
                        value: kursus.jenjang,
                      ),
                      ProfileDetailColumn(
                        title: 'Masa Berlaku',
                        value: kursus.berlakuSelama,
                      ),
                      ProfileDetailColumn(
                        title: 'Harga',
                        value: "Rp ${formatNumber(
                          kursus.harga.toString().replaceAll(',', ''),
                        ).replaceAll(",", ".")}",
                      ),
                      ProfileDetailColumn(
                        title: 'Keterangan',
                        value: kursus.keterangan,
                      ),
                    ],
                  ),
                ),
              );
            
  });
  }
}
