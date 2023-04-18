// // import 'package:administration_course/pages/login/login_page.dart';
// // import 'package:administration_course/pages/logout/logout_dialog.dart';
// import 'package:administration_course/pages/asisten/asisten_add_page.dart';
// import 'package:administration_course/pages/asisten/asisten_detail_page.dart';
// import 'package:administration_course/pages/jenis_kas/jenis_kas_add_page.dart';
// import 'package:administration_course/pages/jenis_kas/jenis_kas_detail_page.dart';
// import 'package:administration_course/pages/jenis_kas/jenis_kas_page.dart';
// import 'package:administration_course/pages/paket_kursus/paket_kursus_add_page.dart';
// import 'package:administration_course/pages/paket_kursus/paket_kursus_detail_page.dart';
// // import 'package:administration_course/pages/logout/logout_page.dart';
// import 'package:administration_course/pages/paket_kursus/paket_kursus_page.dart';
// import 'package:administration_course/pages/siswa/siswa_add_page.dart';
// import 'package:administration_course/pages/siswa/siswa_detail_page.dart';
// import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_add_page.dart';
// import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_page.dart';
// import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_add_page.dart';
// import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_page.dart';
// // import 'package:administration_course/pages/invoices/invoices.dart';
// import 'package:administration_course/pages/home/home_page.dart';
// // import 'package:administration_course/pages/payroll/payroll.dart';
// // import 'package:administration_course/pages/reports/reports_page.dart';
// // import 'package:administration_course/pages/signup/signup_page.dart';
// import 'package:administration_course/pages/siswa/siswa_page.dart';
// import 'package:administration_course/pages/asisten/asisten_page.dart';
// // import 'package:administration_course/pages/welcome/welcome_page.dart';
// import 'package:administration_course/routing/routes.dart';
// import 'package:flutter/material.dart';

// /// digunakan untuk membuat [route] yang mengenerate fungsi

// /// [generateRoute] untuk mengambil route settings dan dari data setting itu kita mengambil data routename [settings.name]
// /// yang akan mengembalikan halaman sesuai nama routing
// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     // ///RETURN [WelcomePage()]
//     // case "/":
//     //   // return _getPageRoute(const WelcomePage());
//     //   return _getPageRoute( HomePage());

//     // ///RETURN [WelcomePage()]
//     // case welcomePageRoute:
//     //   // return _getPageRoute(const WelcomePage());
//     //   return _getPageRoute(const WelcomePage());

//     // ///RETURN [LoginPage()]
//     // case loginPageRoute:
//     //   return _getPageRoute(const LoginPage());

//     // ///RETURN [SignUpPage()]
//     // case signupPageRoute:
//     //   return _getPageRoute(const SignUpPage());

//     ///RETURN [OverviewPage()]
//     case homePageRoute:
//       return _getPageRoute(HomePage(), homePageRoute);

//     ///RETURN [CoursesPage()]
//     case paketKursusPageRoute:
//       return _getPageRoute(PaketKursusPage(), paketKursusPageRoute);
//     case paketKursusAddUpdatePageRoute:
//       return _getPageRoute(
//           const PaketKursusAddFormPage(), paketKursusAddUpdatePageRoute);
//     // case paketKursusDetailPageRoute:
//     //   return _getPageRoute(
//     //       PaketKursusDetailPage(
//     //         paketKursusId: '',
//     //       ),
//     //       paketKursusDetailPageRoute);

//     ///RETURN [StudentsPage()]
//     case siswaPageRoute:
//       return _getPageRoute(const SiswaPage(), siswaPageRoute);
//     case siswaAddUpdatePageRoute:
//       return _getPageRoute(const SiswaAddFormPage(), siswaAddUpdatePageRoute);
//     // case siswaDetailPageRoute:
//     //   return _getPageRoute(
//     //       SiswaDetailPage(siswaId: param1), siswaDetailPageRoute);

//     ///RETURN [TeamsPage()]
//     case asistenPageRoute:
//       return _getPageRoute(const AsistenPage(), asistenPageRoute);
//     case asistenAddUpdatePageRoute:
//       return _getPageRoute(
//           const AsistenAddFormPage(), asistenAddUpdatePageRoute);
//     // case asistenDetailPageRoute:
//     //   return _getPageRoute(
//     //       AsistenDetailPage(asistenId: param1), asistenDetailPageRoute);

//     // ///RETURN [InvoicesPage()]
//     // case invoicesPageRoute:
//     //   return _getPageRoute(const InvoicesPage());

//     // ///RETURN [PayrollPage()]
//     // case payrollPageRoute:
//     //   return _getPageRoute(const PayrollPage());

//     ///RETURN [CategoryPage()]
//     case jenisKasPageRoute:
//       return _getPageRoute(const JenisKasPage(), jenisKasPageRoute);
//     case jenisKasAddUpdatePageRoute:
//       return _getPageRoute(
//           const JenisKasAddFormPage(), jenisKasAddUpdatePageRoute);
//     // case jenisKasDetailPageRoute:
//     //   return _getPageRoute(
//     //       JenisKasDetailPage(jenisKasId: param1), jenisKasDetailPageRoute);

//     ///RETURN [IncomesPage()]
//     case transaksiMasukPageRoute:
//       return _getPageRoute(const TransaksiMasukPage(), transaksiMasukPageRoute);
//     case transaksiMasukAddUpdatePageRoute:
//       return _getPageRoute(
//           const TransaksiMasukAddFormPage(), transaksiMasukAddUpdatePageRoute);

//     ///RETURN [ExpansesPage()]
//     case transaksiKeluarPageRoute:
//       return _getPageRoute(
//           const TransaksiKeluarPage(), transaksiKeluarPageRoute);
//     case transaksiKeluarAddUpdatePageRoute:
//       return _getPageRoute(const TransaksiKeluarAddFormPage(),
//           transaksiKeluarAddUpdatePageRoute);

//     // ///RETURN [ReportsPage()]
//     // case reportsPageRoute:
//     //   return _getPageRoute(const ReportsPage());

//     // ///RETURN [LogoutPage()]
//     // case logoutPageRoute:
//     // // return _getPageRoute(LogoutDialog(contentText: "Are you sure you want to logout?"));
//     // // return _getPageRoute(const logoutDialog(context, "Are you sure you want to logout?", currentUser));

//     default:
//       return _getPageRoute(HomePage(), settings.name!);
//   }
// }

// /// [_getPageRoute] digunakan untuk mendapatkan data [PageRoute]
// PageRoute _getPageRoute(Widget child, String route) {
//   return MaterialPageRoute(
//     builder: (context) => child,
//     settings: RouteSettings(name: route),
//   );
// }
