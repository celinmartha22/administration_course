// import 'package:admin/models/MyFiles.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.title,
    required this.totalIn,
    required this.totalOut,
    required this.ikon,
  }) : super(key: key);

  final String title;
  final int totalIn;
  final int totalOut;
  final IconData ikon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: kTextBlackColor),
        ),
        ProgressLine(
          colorIn:
              totalIn == 0 && totalOut == 0 ? kTextWhiteColor : kPrimaryColor,
          colorEx:
              totalIn == 0 && totalOut == 0 ? kTextWhiteColor : Colors.amber,
          percentage: percentageBalance(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: const BoxDecoration(
                color: kTextWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    color: kPrimaryColor,
                  ),
                  // sizedBox,
                  Text(
                    "Rp ${formatNumber(
                      totalIn.toString().replaceAll(',', ''),
                    ).replaceAll(',', '.')}",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.arrow_downward, color: Colors.amber[200]),
                  Text(
                    "Rp ${formatNumber(
                      totalOut.toString().replaceAll(',', ''),
                    ).replaceAll(',', '.')}",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.amber[200], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  int percentageBalance() {
    int result = 100;
    if (totalIn != 0 && totalOut != 0) {
      result = (totalIn / (totalIn + totalOut) * 100).ceil();
    }
    return result;
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.colorIn = kPrimaryColor,
    this.colorEx = Colors.amber,
    required this.percentage,
  }) : super(key: key);

  final Color? colorIn;
  final Color? colorEx;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: colorEx, //!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 10,
            decoration: BoxDecoration(
              color: colorIn,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}