import 'package:administration_course/constants/style.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text('Column A'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Column B'),
            ),
            DataColumn(
              label: Text('Column C'),
            ),
            DataColumn(
              label: Text('Column D'),
            ),
            DataColumn(
              label: Text('Column NUMBERS'),
              numeric: true,
            ),
          ],
          rows: List<DataRow>.generate(
              100,
              (index) => DataRow(cells: [
                    DataCell(Text('A' * (10 - index % 10))),
                    DataCell(Text('B' * (10 - (index + 5) % 10))),
                    DataCell(Text('C' * (15 - (index + 5) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text(((index + 0.1) * 25.4).toString()))
                  ]))),
    );
  }
}

// /// Tabel Siswa
// /// Example without a datasource
// class AvailableStudentsTable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: active.withOpacity(.4), width: .5),
//         boxShadow: [
//           BoxShadow(
//               offset: Offset(0, 6),
//               color: lightGrey.withOpacity(.1),
//               blurRadius: 12)
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: const EdgeInsets.all(16),
//       margin: EdgeInsets.only(bottom: 30),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 width: 10,
//                 // height: 400,
//               ),
//               CustomText(
//                 text: "Available Drivers",
//                 color: lightGrey,
//                 weight: FontWeight.bold,
//                 size: 10,
//               ),
//             ],
//           ),
//           // DataTable2(
//           //     columnSpacing: 12,
//           //     horizontalMargin: 12,
//           //     minWidth: 600,
//           //     columns: [
//           //       DataColumn2(
//           //         label: Text("Name"),
//           //         size: ColumnSize.L,
//           //       ),
//           //       DataColumn(
//           //         label: Text('Location'),
//           //       ),
//           //       DataColumn(
//           //         label: Text('Rating'),
//           //       ),
//           //       DataColumn(
//           //         label: Text('Action'),
//           //       ),
//           //     ],
//           //     rows: List<DataRow>.generate(
//           //         7,
//           //         (index) => DataRow(cells: [
//           //               DataCell(CustomText(text: "Santos Enoque", color: Colors.black, size: 5, weight: FontWeight.normal,)),
//           //               DataCell(CustomText(text: "New yourk city", color: Colors.black, size: 5, weight: FontWeight.normal)),
//           //               DataCell(Row(
//           //                 mainAxisSize: MainAxisSize.min,
//           //                 children: [
//           //                   Icon(
//           //                     Icons.star,
//           //                     color: Colors.deepOrange,
//           //                     size: 18,
//           //                   ),
//           //                   SizedBox(
//           //                     width: 5,
//           //                   ),
//           //                   CustomText(
//           //                     text: "4.5", color: Colors.black, size: 5, weight: FontWeight.normal,
//           //                   )
//           //                 ],
//           //               )),
//           //               DataCell(Container(
//           //                   decoration: BoxDecoration(
//           //                     color: light,
//           //                     borderRadius: BorderRadius.circular(20),
//           //                     border: Border.all(color: active, width: .5),
//           //                   ),
//           //                   padding: EdgeInsets.symmetric(
//           //                       horizontal: 12, vertical: 6),
//           //                   child: CustomText(
//           //                     text: "Assign Delivery",
//           //                     color: active.withOpacity(.7),
//           //                     weight: FontWeight.bold,
//           //                     size: 10,
//           //                   ))),
//           //             ]))),
//         ],
//       ),
//     );
//   }
// }