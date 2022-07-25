/// Bar chart example
import 'package:administration_course/constants/style.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/// widget ini akan menampilkan grafik berupa Bar Chart
class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  /// nilai yang akan ditampilkan pada grafik bar
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('January', 43),
      new OrdinalSales('February', 25),
      new OrdinalSales('March', 9),
      new OrdinalSales('April', 75),
      new OrdinalSales('May', 5),
      new OrdinalSales('June', 25),
      new OrdinalSales('July', 68),
      new OrdinalSales('August', 53),
      new OrdinalSales('September', 5),
      new OrdinalSales('October', 25),
      new OrdinalSales('November', 89),
      new OrdinalSales('December', 56),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(active),
        // colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
