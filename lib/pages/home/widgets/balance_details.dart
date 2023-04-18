import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/overview_kategori.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';

// import '../../../constants.dart';
import 'chart.dart';
import 'balance_info_card.dart';

class BalanceDetails extends StatelessWidget {
  BalanceDetails(
      {Key? key,
      required this.title,
      required this.total,
      required this.listOverviewKategori})
      : super(key: key);
  String title;
  int total;
  List<OverviewKategori> listOverviewKategori;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                letterSpacing: 0),
          ),
          sizedBox,
          Chart(
            title: title,
            total: total,
            listOverviewKategori: listOverviewKategori,
          ),
          sizedBox,
          SizedBox(
            height: listOverviewKategori.length * 70,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOverviewKategori.length,
              itemBuilder: (context, index) {
                final Color categoryColor =
                    Color(listOverviewKategori[index].warna);
                final IconData categoryIcon = IconData(
                    int.parse(listOverviewKategori[index].ikon),
                    fontFamily: 'MaterialIcons');
                return BalanceInfoCard(
                  ikon: categoryIcon,
                  title: listOverviewKategori[index].namaKategori,
                  amountOfFiles: listOverviewKategori[index].total.toString(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
