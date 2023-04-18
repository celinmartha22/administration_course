import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/data/provider/siswa_provider.dart';
import 'package:administration_course/pages/siswa/siswa_add_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/page/profile_detail_column.dart';
import '../../widgets/page/profile_detail_row.dart';

class SiswaDetailPage extends StatefulWidget {
  static const String routeName = 'siswa_detail';
  static final ValueNotifier<Siswa> siswaNotifier = ValueNotifier(Siswa(
      idSiswa: '-',
      namaSiswa: '',
      kelas: '',
      asalSekolah: '',
      jenisKelamin: '',
      tanggalLahir: '',
      tanggalMasuk: '',
      email: '',
      namaAyah: '',
      namaIbu: '',
      nomorHP: '',
      alamat: ''));
  const SiswaDetailPage({Key? key, required this.siswaId}) : super(key: key);
  final String siswaId;

  @override
  State<SiswaDetailPage> createState() => _SiswaDetailPageState();
}

class _SiswaDetailPageState extends State<SiswaDetailPage> {
  late Siswa selectedSiswa;

  @override
  void initState() {
    selectedSiswa = Siswa(
        idSiswa: '-',
        namaSiswa: '',
        kelas: '',
        asalSekolah: '',
        jenisKelamin: '',
        tanggalLahir: '',
        tanggalMasuk: '',
        email: '',
        namaAyah: '',
        namaIbu: '',
        nomorHP: '',
        alamat: '');
    _getDataInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getDataInit() async {
    final siswaData = await Provider.of<SiswaProvider>(context, listen: false)
        .getSiswaById(widget.siswaId);
    setState(() {
      selectedSiswa = siswaData;
      SiswaDetailPage.siswaNotifier.value = siswaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        elevation: 0,
        title: Text("Profil Siswa",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                letterSpacing: 0)),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(SiswaAddFormPage.routeName,
                  arguments: selectedSiswa);
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
      body: BuildDetail(
        siswaId: widget.siswaId,
      ),
    );
  }
}

class BuildDetail extends StatelessWidget {
  const BuildDetail({
    super.key,
    required this.siswaId,
  });
  final String siswaId;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Siswa>(
      valueListenable: SiswaDetailPage.siswaNotifier,
      builder: (_, tasks, __) {
        final siswa = tasks;
        return Container(
          color: kOtherColor,
          child: Column(
            children: [
              Container(
                width: 100.w,
                height: SizerUtil.deviceType == DeviceType.tablet ? 19.h : 18.h,
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
                              siswa.jenisKelamin.contains("laki")
                                  ? 'assets/images/Raising hand-cuate.png'
                                  : 'assets/images/Raising hand-pana.png'),
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
                            siswa.namaSiswa,
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
                            child: Text(siswa.email,
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
                      title: 'Nomor Registrasi', value: siswa.idSiswa),
                  ProfileDetailRow(
                      title: 'Jenis Kelamin', value: siswa.jenisKelamin),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                      title: 'Jenjang Sekolah', value: siswa.kelas),
                  ProfileDetailRow(
                      title: 'Asal Sekolah', value: siswa.asalSekolah),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileDetailRow(
                      title: 'Tanggal Penerimaan', value: siswa.tanggalMasuk),
                  ProfileDetailRow(
                      title: 'Tanggal Lahir', value: siswa.tanggalLahir),
                ],
              ),
              kHalfSizedBox,
              ProfileDetailColumn(
                title: 'Nama Ayah',
                value: siswa.namaAyah,
              ),
              ProfileDetailColumn(
                title: 'Nama Ibu',
                value: siswa.namaIbu,
              ),
              ProfileDetailColumn(
                title: 'Alamat',
                value: siswa.alamat,
              ),
              ProfileDetailColumn(
                title: 'Nomor Telp/HP',
                value: siswa.nomorHP,
              ),
            ],
          ),
        );
      },
    );
  }
}







// class BuildDetail extends StatelessWidget {
//   const BuildDetail({
//     super.key,
//     required this.siswaId,
//   });
//   final String siswaId;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (_) => SiswaDetailProvider(siswaId),
//         child: Consumer<SiswaDetailProvider>(
//           builder: (context, state, _) {
//             if (state.state == ResultStateDb.loading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state.state == ResultStateDb.hasData) {
//               return Container(
//                 color: kOtherColor,
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 100.w,
//                       height: SizerUtil.deviceType == DeviceType.tablet
//                           ? 19.h
//                           : 18.h,
//                       decoration: BoxDecoration(
//                         color: kPrimaryLightColor,
//                         borderRadius: kBottomBorderRadius,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           kWidthSizedBox,

//                           /// -- IMAGE
//                           Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius:
//                                     SizerUtil.deviceType == DeviceType.tablet
//                                         ? 12.w
//                                         : 11.w,
//                                 backgroundColor: kSecondaryColor,
//                                 backgroundImage: AssetImage(state
//                                         .result.jenisKelamin
//                                         .contains("laki")
//                                     ? 'assets/images/Raising hand-cuate.png'
//                                     : 'assets/images/Raising hand-pana.png'),
//                               ),
//                             ],
//                           ),
//                           kWidthSizedBox,
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   siswa.namaSiswa,
//                                   softWrap: true,
//                                   maxLines: 3,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall!
//                                       .copyWith(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           letterSpacing: 0),
//                                 ),
//                                 Flexible(
//                                   child: Text(state.result.email,
//                                       softWrap: true,
//                                       maxLines: 3,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .labelMedium!
//                                           .copyWith(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.normal,
//                                               letterSpacing: 0)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     sizedBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ProfileDetailRow(
//                             title: 'Nomor Registrasi',
//                             value: state.result.idSiswa),
//                         ProfileDetailRow(
//                             title: 'Jenis Kelamin',
//                             value: state.result.jenisKelamin),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ProfileDetailRow(
//                             title: 'Jenjang Sekolah',
//                             value: state.result.kelas),
//                         ProfileDetailRow(
//                             title: 'Asal Sekolah',
//                             value: state.result.asalSekolah),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ProfileDetailRow(
//                             title: 'Tanggal Penerimaan',
//                             value: state.result.tanggalMasuk),
//                         ProfileDetailRow(
//                             title: 'Tanggal Lahir',
//                             value: state.result.tanggalLahir),
//                       ],
//                     ),
//                     kHalfSizedBox,
//                     ProfileDetailColumn(
//                       title: 'Nama Ayah',
//                       value: state.result.namaAyah,
//                     ),
//                     ProfileDetailColumn(
//                       title: 'Nama Ibu',
//                       value: state.result.namaIbu,
//                     ),
//                     ProfileDetailColumn(
//                       title: 'Alamat',
//                       value: state.result.alamat,
//                     ),
//                     ProfileDetailColumn(
//                       title: 'Nomor Telp/HP',
//                       value: state.result.nomorHP,
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state.state == ResultStateDb.noData) {
//               return const NotificationNoData();
//             } else if (state.state == ResultStateDb.error) {
//               return const NotificationErrorData();
//             } else {
//               return const NotificationDataNotFound();
//             }
//           },
//         ));
//   }
// }
