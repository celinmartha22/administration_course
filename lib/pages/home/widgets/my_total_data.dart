import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/home/widgets/file_info_card.dart';
import 'package:administration_course/responsive.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:administration_course/widgets/layout/app_layout.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTotalData extends StatelessWidget {
  MyTotalData({
    Key? key,
    required this.totalKursus,
    required this.totalSiswa,
    required this.totalAsisten,
    required this.totalSaldoMasuk,
    required this.totalSaldoKeluar,
    required this.currentUser,
  }) : super(key: key);
  int totalKursus;
  int totalSiswa;
  int totalAsisten;
  int totalSaldoMasuk;
  int totalSaldoKeluar;

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
            totalKursus: totalKursus,
            totalSiswa: totalSiswa,
            totalAsisten: totalAsisten,
            totalSaldoMasuk: totalSaldoMasuk,
            totalSaldoKeluar: totalSaldoKeluar,
            currentUser: currentUser,
          ),
          tablet: FileInfoCardGridView(
            totalKursus: totalKursus,
            totalSiswa: totalSiswa,
            totalAsisten: totalAsisten,
            totalSaldoMasuk: totalSaldoMasuk,
            totalSaldoKeluar: totalSaldoKeluar,
            currentUser: currentUser,
          ),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            totalKursus: totalKursus,
            totalSiswa: totalSiswa,
            totalAsisten: totalAsisten,
            totalSaldoMasuk: totalSaldoMasuk,
            totalSaldoKeluar: totalSaldoKeluar,
            currentUser: currentUser,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.totalKursus,
    required this.totalSiswa,
    required this.totalAsisten,
    required this.totalSaldoMasuk,
    required this.totalSaldoKeluar,
    required this.currentUser,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  int totalKursus;
  int totalSiswa;
  int totalAsisten;
  int totalSaldoMasuk;
  int totalSaldoKeluar;

  final User currentUser;

  @override
  Widget build(BuildContext context) {
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
                    currentUser: currentUser,
                    selectedMenu: index,
                  )));
    }

    return StaggeredGrid.count(
      crossAxisCount: 6,
      crossAxisSpacing: kDefaultPadding / 2,
      mainAxisSpacing: kDefaultPadding / 2,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: InfoCard(
              isBalance: false,
              title: "Kursus",
              total: totalKursus,
              onTapping: () {
                onTapMenu(1, sideMenuItems[1][0], sideMenuItems[1][1]);
                // Navigator.of(context).pushNamed(PaketKursusPage.routeName);
              },
              imageAsset: 'assets/images/Dictionary.png'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: InfoCard(
              isBalance: false,
              title: "Siswa",
              total: totalSiswa,
              onTapping: () {
                onTapMenu(2, sideMenuItems[2][0], sideMenuItems[2][1]);
              },
              imageAsset: 'assets/images/End of school-amico.png'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: InfoCard(
              isBalance: false,
              title: "Asisten",
              total: totalAsisten,
              onTapping: () {
                onTapMenu(3, sideMenuItems[3][0], sideMenuItems[3][1]);
              },
              imageAsset: 'assets/images/Teachers Day-amico.png'),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 6,
          mainAxisCellCount: 2,
          child: InfoCard(
              isBalance: true,
              title: "Saldo Keuangan",
              total: totalSaldoMasuk,
              total2: totalSaldoKeluar,
              onTapping: () {
                onTapMenu(7, sideMenuItems[7][0], sideMenuItems[7][1]);
              },
              imageAsset: 'assets/images/Coins-amico.png'),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard(
      {super.key,
      required this.title,
      required this.total,
      this.total2,
      required this.onTapping,
      required this.imageAsset,
      required this.isBalance});

  Function() onTapping;
  String imageAsset;
  String title;
  int total;
  int? total2;
  bool isBalance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapping,
      child: Container(
        padding: isBalance ? EdgeInsets.all(10) : EdgeInsets.all(15),
        height: 200,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage(imageAsset),
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight),
        ),
        child: isBalance
            ? FileInfoCard(
                title: title,
                totalIn: total,
                totalOut: total2!,
                ikon: Icons.percent)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(total.toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: kPrimaryColor)),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: kContainerColor),
                  )
                ],
              ),
      ),
    );
  }
}
