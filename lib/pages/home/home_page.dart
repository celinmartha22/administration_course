import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/overview.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/data/provider/overview_provider.dart';
import 'package:administration_course/pages/home/widgets/my_total_data.dart';
import 'package:administration_course/pages/home/widgets/balance_details.dart';
import 'package:administration_course/responsive.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:administration_course/widgets/layout/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key, required this.currentUser}) : super(key: key);
  final User currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OverviewProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.hasData) {
          return BuildOverview(
            overview: state.result,
            currentUser: widget.currentUser,
          );
        } else {
          return BuildOverview(
            overview: Overview(
                totalKursus: 0,
                totalSiswa: 0,
                totalAsisten: 0,
                totalSaldoMasuk: 0,
                totalSaldoKeluar: 0,
                dataKasMasukKategori: [],
                dataKasKeluarKategori: []),
            currentUser: widget.currentUser,
          );
        }
      },
    );
  }
}

class BuildOverview extends StatefulWidget {
  const BuildOverview({
    super.key,
    required this.overview,
    required this.currentUser,
  });
  final Overview overview;
  final User currentUser;
  static final ValueNotifier<Overview> overviewNotifier = ValueNotifier(
      Overview(
          totalKursus: 0,
          totalSiswa: 0,
          totalAsisten: 0,
          totalSaldoMasuk: 0,
          totalSaldoKeluar: 0,
          dataKasMasukKategori: [],
          dataKasKeluarKategori: []));

  @override
  State<BuildOverview> createState() => _BuildOverviewState();
}

class _BuildOverviewState extends State<BuildOverview> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      setState(() {
        BuildOverview.overviewNotifier.value = widget.overview;
      });
    }

    // Future _getDataInit() async {
    //   final overviewData =
    //       await Provider.of<OverviewProvider>(context, listen: false);
    //   setState(() {
    //     BuildOverview.overviewNotifier.value = widget.overview;
    //   });
    // }

    void onTapMenu(int index, String itemName, String itemRoute) {
      if (!sidemenuController.isActive(itemName)) {
        sidemenuController.changeActiveItmeTo(itemName);
        if (Responsive.isMobile(context)) {
          Get.back();
        }
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppLayout(
                    currentUser: widget.currentUser,
                    selectedMenu: index,
                  )));
    }

    return ValueListenableBuilder<Overview>(
        valueListenable: BuildOverview.overviewNotifier,
        builder: (_, tasks, __) {
          final overview = tasks;
          return SafeArea(
            child: SingleChildScrollView(
              primary: false,
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            MyTotalData(
                              totalKursus: overview.totalKursus,
                              totalSiswa: overview.totalSiswa,
                              totalAsisten: overview.totalAsisten,
                              totalSaldoMasuk: overview.totalSaldoMasuk,
                              totalSaldoKeluar: overview.totalSaldoKeluar,
                              currentUser: widget.currentUser,
                            ),
                            const SizedBox(height: defaultPadding),
                            if (Responsive.isMobile(context))
                              InkWell(
                                onTap: () {
                                  onTapMenu(5, sideMenuItems[5][0],
                                      sideMenuItems[5][1]);
                                },
                                child: BalanceDetails(
                                  title: 'Pemasukan',
                                  total: overview.totalSaldoMasuk,
                                  listOverviewKategori:
                                      overview.dataKasMasukKategori,
                                ),
                              ),
                            const SizedBox(height: defaultPadding),
                            if (Responsive.isMobile(context))
                              InkWell(
                                onTap: () {
                                  onTapMenu(6, sideMenuItems[6][0],
                                      sideMenuItems[6][1]);
                                },
                                child: BalanceDetails(
                                    title: 'Pengeluaran',
                                    total: overview.totalSaldoKeluar,
                                    listOverviewKategori:
                                        overview.dataKasKeluarKategori),
                              ),
                          ],
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        const SizedBox(width: defaultPadding),
                      if (!Responsive.isMobile(context))
                        Expanded(
                          flex: 2,
                          child: BalanceDetails(
                            title: 'Saldo Masuk',
                            total: overview.totalSaldoMasuk,
                            listOverviewKategori: overview.dataKasMasukKategori,
                          ),
                        ),
                      if (!Responsive.isMobile(context))
                        const SizedBox(width: defaultPadding),
                      if (!Responsive.isMobile(context))
                        Expanded(
                          flex: 2,
                          child: BalanceDetails(
                              title: 'Saldo Keluar',
                              total: overview.totalSaldoKeluar,
                              listOverviewKategori:
                                  overview.dataKasKeluarKategori),
                        ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
