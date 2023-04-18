import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/asisten/asisten_page.dart';
import 'package:administration_course/pages/home/home_page.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_page.dart';
import 'package:administration_course/pages/logout/logout_dialog.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_page.dart';
import 'package:administration_course/pages/reports/reports_page.dart';
import 'package:administration_course/pages/siswa/siswa_page.dart';
import 'package:administration_course/pages/transaksi_keluar/transaksi_keluar_page.dart';
import 'package:administration_course/pages/transaksi_masuk/transaksi_masuk_page.dart';
import 'package:administration_course/responsive.dart';
import 'package:administration_course/widgets/menu_bar/side_bar.dart';
import 'package:administration_course/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  AppLayout({Key? key, required this.currentUser, required this.selectedMenu})
      : super(key: key);
  int selectedMenu = 0;
  final User currentUser;

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int currentMenu = 0;

  void onMenuTapped(int index) {
    setState(() {
      widget.selectedMenu = index;
      currentMenu = widget.selectedMenu;
    });
  }

  @override
  void initState() {
    onMenuTapped(widget.selectedMenu);
    super.initState();
  }

  Future<bool> _onWillPop(int index) async {
    if (index == 0) {
      return logoutDialog(
              context,
              "close",
              "${widget.currentUser.name}, Anda akan keluar dari aplikasi",
              widget.currentUser) ??
          false;
    } else {
      sidemenuController.changeActiveItmeTo("Home");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AppLayout(
                    currentUser: widget.currentUser,
                    selectedMenu: 0,
                  )));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = currentMenu == 0
        ? HomePage(
            currentUser: widget.currentUser,
          )
        : currentMenu == 1
            ? const PaketKursusPage()
            : currentMenu == 2
                ? const SiswaPage()
                : currentMenu == 3
                    ? const AsistenPage()
                    : currentMenu == 4
                        ? const JenisKasPage()
                        : currentMenu == 5
                            ? const TransaksiMasukPage()
                            : currentMenu == 6
                                ? const TransaksiKeluarPage()
                                : currentMenu == 7
                                    ? const ReportsPage()
                                    : HomePage(
                                        currentUser: widget.currentUser,
                                      );
    return WillPopScope(
      onWillPop: () => _onWillPop(currentMenu),
      child: Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: topAppBar(context, scaffoldKey),
        drawer: SideBar(
          currentUser: widget.currentUser,
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideBar(
                    currentUser: widget.currentUser,
                  ),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: currentScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
