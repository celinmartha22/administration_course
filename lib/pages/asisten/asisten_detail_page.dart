import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/data/provider/asisten_detail_provider.dart';
import 'package:administration_course/data/provider/asisten_provider.dart';
import 'package:administration_course/pages/asisten/asisten_add_page.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/page/profile_detail_column.dart';

class AsistenDetailPage extends StatefulWidget {
  static final ValueNotifier<Asisten> asistenNotifier = ValueNotifier(Asisten(
      idAsisten: '',
      namaAsisten: '',
      jabatan: '',
      alamat: '',
      jenisKelamin: '',
      nomorHP: ''));
  static const String routeName = '/asisten_detail';
  const AsistenDetailPage({Key? key, required this.asistenId})
      : super(key: key);
  final String asistenId;

  @override
  State<AsistenDetailPage> createState() => _AsistenDetailPageState();
}

class _AsistenDetailPageState extends State<AsistenDetailPage> {
  late Asisten selectedAsisten;

  @override
  void initState() {
    selectedAsisten = Asisten(
        idAsisten: '',
        namaAsisten: '',
        jabatan: '',
        alamat: '',
        jenisKelamin: '',
        nomorHP: '');
    _getDataInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getDataInit() async {
    final asistenData =
        await Provider.of<AsistenProvider>(context, listen: false)
            .getAsistenById(widget.asistenId);
    setState(() {
      selectedAsisten = asistenData;
      AsistenDetailPage.asistenNotifier.value = asistenData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Asisten>(
        valueListenable: AsistenDetailPage.asistenNotifier,
        builder: (_, tasks, __) {
          final asisten = tasks;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryLightColor,
              elevation: 0,
              title: Text("Profil Asisten",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0)),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AsistenAddFormPage.routeName,
                        arguments: selectedAsisten);
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
                              backgroundImage: AssetImage(
                                  asisten.jenisKelamin.contains("laki")
                                      ? 'assets/images/Mathematics-bro.png'
                                      : 'assets/images/Teachers Day-amico.png'),
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
                                asisten.namaAsisten,
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
                                child: Text(asisten.jabatan,
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
                    title: 'ID Asisten',
                    value: asisten.idAsisten,
                  ),
                  ProfileDetailColumn(
                    title: 'Jabatan',
                    value: asisten.jabatan,
                  ),
                  ProfileDetailColumn(
                    title: 'Jenis Kelamin',
                    value: asisten.jenisKelamin,
                  ),
                  ProfileDetailColumn(
                    title: 'Address',
                    value: asisten.alamat,
                  ),
                  ProfileDetailColumn(
                    title: 'Phone Number',
                    value: asisten.nomorHP,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
