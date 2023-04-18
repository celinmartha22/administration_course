import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/controllers/side_menu_controller.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/data/model/transaksi_kas_keluar.dart';
import 'package:administration_course/data/model/transaksi_kas_masuk.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/data/provider/asisten_provider.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/data/provider/overview_provider.dart';
import 'package:administration_course/data/provider/paket_kursus_provider.dart';
import 'package:administration_course/data/provider/siswa_provider.dart';
import 'package:administration_course/data/provider/trans_kas_keluar_provider.dart';
import 'package:administration_course/data/provider/trans_kas_masuk_provider.dart';
import 'package:administration_course/data/provider/trans_kas_provider.dart';
import 'package:administration_course/data/provider/user_all_provider.dart';
import 'package:administration_course/data/provider/user_provider.dart';
import 'package:administration_course/pages/asisten/asisten_add_page.dart';
import 'package:administration_course/pages/asisten/asisten_detail_page.dart';
import 'package:administration_course/pages/asisten/asisten_page.dart';
import 'package:administration_course/pages/home/home_page.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_add_page.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_detail_page.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_page.dart';
import 'package:administration_course/pages/login/login_page.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_add_page.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_detail_page.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_page.dart';
import 'package:administration_course/pages/profile/profile_edit_page.dart';
import 'package:administration_course/pages/profile/profile_page.dart';
import 'package:administration_course/pages/signup/signup_page.dart';
import 'package:administration_course/pages/siswa/siswa_add_page.dart';
import 'package:administration_course/pages/siswa/siswa_detail_page.dart';
import 'package:administration_course/pages/siswa/siswa_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_add_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_detail_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_list_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_page.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_add_page.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_detail_page.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_page.dart';
import 'package:administration_course/pages/welcome/welcome_page.dart';
import 'package:administration_course/widgets/layout/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'pages/transaksi_masuk/transaksi_masuk_list_page.dart';

void main() {
  Get.put(SideMenuController());

  // /// me-Register [MenuController]
  // Get.put(NavigationController());

  /// me-Register [NavigationController]
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => OverviewProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => UserAllProvider()),
              ChangeNotifierProvider(create: (_) => AsistenProvider()),
              ChangeNotifierProvider(create: (_) => SiswaProvider()),
              ChangeNotifierProvider(create: (_) => PaketKursusProvider()),
              ChangeNotifierProvider(create: (_) => JenisKasProvider()),
              ChangeNotifierProvider(create: (_) => TransKasMasukProvider()),
              ChangeNotifierProvider(create: (_) => TransKasKeluarProvider()),
              ChangeNotifierProvider(create: (_) => TransKasProvider()),
            ],
            child: Consumer<UserProvider>(
              builder: (context, state, _) {
                return GetMaterialApp(
                  // child: MaterialApp(
                  title: 'Course App',
                  theme: ThemeData(
                    unselectedWidgetColor: Colors.blueGrey,
                    disabledColor: Colors.deepPurple,
                    scaffoldBackgroundColor: light,
                    buttonTheme: ButtonThemeData(
                        buttonColor: Colors.deepPurple.shade300,
                        focusColor: Colors.deepPurple),
                    textTheme: myTextTheme,

                    /// [pageTransitionsTheme] untuk mengatur tema/gaya transisi ketika akan ganti halaman
                    pageTransitionsTheme: const PageTransitionsTheme(builders: {
                      TargetPlatform.windows:
                          FadeUpwardsPageTransitionsBuilder(),
                      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                      TargetPlatform.android:
                          FadeUpwardsPageTransitionsBuilder()
                    }),
                  ),
                  // home: AppLayout(),
                  // home: const WelcomePage(),
                  home: state.result.idUser == ''
                      ? const WelcomePage()
                      : AppLayout(currentUser: state.result, selectedMenu: 0),
                  navigatorObservers: [routeObserver],
                  onGenerateRoute: (RouteSettings settings) {
                    final args = settings.arguments;
                    switch (settings.name) {
                      case WelcomePage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const WelcomePage());
                      case LoginPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const LoginPage());
                      case SignUpPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const SignUpPage());
                      case HomePage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => HomePage(
                                  currentUser: args as User,
                                ));
                      case PaketKursusPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const PaketKursusPage());
                      case PaketKursusAddFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => PaketKursusAddFormPage(
                                  data: args as PaketKursus,
                                ));
                      case PaketKursusDetailPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => PaketKursusDetailPage(
                                  paketKursusId: args as String,
                                ));
                      case SiswaPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const SiswaPage());
                      case SiswaAddFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => SiswaAddFormPage(
                                  data: args as Siswa,
                                ));
                      case SiswaDetailPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => SiswaDetailPage(
                                  siswaId: args as String,
                                ));
                      case AsistenPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const AsistenPage());
                      case AsistenAddFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => AsistenAddFormPage(
                                  data: args as Asisten,
                                ));
                      case AsistenDetailPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => AsistenDetailPage(
                                  asistenId: args as String,
                                ));
                      case JenisKasPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const JenisKasPage());
                      case JenisKasAddFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => JenisKasAddFormPage(
                                  data: args as JenisKas,
                                ));
                      case JenisKasDetailPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => JenisKasDetailPage(
                                  jenisKasId: args as String,
                                ));
                      case TransaksiMasukPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const TransaksiMasukPage());
                      case TransaksiMasukListPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const TransaksiMasukListPage());
                      case TransaksiMasukAddFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => TransaksiMasukAddFormPage(
                                  data: args as TransaksiKasMasuk,
                                ));
                      case TransaksiMasukDetailPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => TransaksiMasukDetailPage(
                                  transMasukId: args as String,
                                ));
                      case TransaksiKeluarPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const TransaksiKeluarPage());
                      case TransaksiKeluarListPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => const TransaksiKeluarListPage());
                      case TransaksiKeluarAddFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => TransaksiKeluarAddFormPage(
                                  data: args as TransaksiKasKeluar,
                                ));
                      case TransaksiKeluarDetailPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => TransaksiKeluarDetailPage(
                                  transKeluarId: args as String,
                                ));
                      case ProfilePage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => ProfilePage(
                                  currentUser: args as User,
                                ));
                      case ProfileEditFormPage.routeName:
                        return MaterialPageRoute(
                            builder: (_) => ProfileEditFormPage(
                                  data: args as User,
                                ));
                      default:
                        return MaterialPageRoute(builder: (_) {
                          return const Scaffold(
                            body: Center(
                              child: Text('Page not found :('),
                            ),
                          );
                        });
                    }
                  },
                );
              },
              // child: GetMaterialApp(
              //   // child: MaterialApp(
              //   title: 'Course App',
              //   theme: ThemeData(
              //     unselectedWidgetColor: Colors.blueGrey,
              //     disabledColor: Colors.deepPurple,
              //     scaffoldBackgroundColor: light,
              //     buttonTheme: ButtonThemeData(
              //         buttonColor: Colors.deepPurple.shade300,
              //         focusColor: Colors.deepPurple),
              //     textTheme: myTextTheme,

              //     /// [pageTransitionsTheme] untuk mengatur tema/gaya transisi ketika akan ganti halaman
              //     pageTransitionsTheme: const PageTransitionsTheme(builders: {
              //       TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
              //       TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              //       TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
              //     }),
              //   ),
              //   // home: AppLayout(),
              //   home: const WelcomePage(),
              //   navigatorObservers: [routeObserver],
              //   onGenerateRoute: (RouteSettings settings) {
              //     final args = settings.arguments;
              //     switch (settings.name) {
              //       case WelcomePage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const WelcomePage());
              //       case LoginPage.routeName:
              //         return MaterialPageRoute(builder: (_) => const LoginPage());
              //       case SignUpPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const SignUpPage());
              //       case HomePage.routeName:
              //         return MaterialPageRoute(builder: (_) => HomePage());
              //       case PaketKursusPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const PaketKursusPage());
              //       case PaketKursusAddFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => PaketKursusAddFormPage(
              //                   data: args as PaketKursus,
              //                 ));
              //       case PaketKursusDetailPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => PaketKursusDetailPage(
              //                   paketKursusId: args as String,
              //                 ));
              //       case SiswaPage.routeName:
              //         return MaterialPageRoute(builder: (_) => const SiswaPage());
              //       case SiswaAddFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => SiswaAddFormPage(
              //                   data: args as Siswa,
              //                 ));
              //       case SiswaDetailPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => SiswaDetailPage(
              //                   siswaId: args as String,
              //                 ));
              //       case AsistenPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const AsistenPage());
              //       case AsistenAddFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => AsistenAddFormPage(
              //                   data: args as Asisten,
              //                 ));
              //       case AsistenDetailPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => AsistenDetailPage(
              //                   asistenId: args as String,
              //                 ));
              //       case JenisKasPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const JenisKasPage());
              //       case JenisKasAddFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => JenisKasAddFormPage(
              //                   data: args as JenisKas,
              //                 ));
              //       case JenisKasDetailPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => JenisKasDetailPage(
              //                   jenisKasId: args as String,
              //                 ));
              //       case TransaksiMasukPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const TransaksiMasukPage());
              //       case TransaksiMasukAddFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => TransaksiMasukAddFormPage(
              //                   data: args as TransaksiKasMasuk,
              //                 ));
              //       case TransaksiMasukDetailPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => TransaksiMasukDetailPage(
              //                   transMasukId: args as String,
              //                 ));
              //       case TransaksiKeluarPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const TransaksiKeluarPage());
              //       case TransaksiKeluarAddFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => TransaksiKeluarAddFormPage(
              //                   data: args as TransaksiKasKeluar,
              //                 ));
              //       case TransaksiKeluarDetailPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => TransaksiKeluarDetailPage(
              //                   transKeluarId: args as String,
              //                 ));
              //       case ProfilePage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => const ProfilePage());
              //       case ProfileEditFormPage.routeName:
              //         return MaterialPageRoute(
              //             builder: (_) => ProfileEditFormPage(
              //                   data: args as User,
              //                 ));
              //       default:
              //         return MaterialPageRoute(builder: (_) {
              //           return const Scaffold(
              //             body: Center(
              //               child: Text('Page not found :('),
              //             ),
              //           );
              //         });
              //     }
              //   },
              // ),
            ));
      },
    );
  }
}
