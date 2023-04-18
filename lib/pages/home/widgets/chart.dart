import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/overview_kategori.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  Chart(
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
    double percentageBalance(int value) {
      double result = (value / total * 100);
      return result;
    }

    List<PieChartSectionData> paiChartSelectionDatas;
    paiChartSelectionDatas = [];

    for (var val in listOverviewKategori) {
      final Color categoryColor = Color(val.warna);
      paiChartSelectionDatas.add(PieChartSectionData(
        color: categoryColor,
        value: percentageBalance(val.total),
        showTitle: false,
        radius: 30,
      ));
    }

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Semua\n$title",
                  textAlign: TextAlign.center,
                ),
                kHalfSizedBox,
                Text(
                  "Rp ${formatNumber(
                    total.toString().replaceAll(',', ''),
                  ).replaceAll(',', '.')}",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                kHalfSizedBox,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
