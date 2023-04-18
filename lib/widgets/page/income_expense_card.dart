import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class IncomeExpenseCard extends StatelessWidget {
  IncomeExpenseCard({
    super.key,
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });
  String label;
  String amount;
  IconData icon;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kTextWhiteColor,
                    letterSpacing: 0),
              ),
              Text(
                amount,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kTextWhiteColor,
                    letterSpacing: 0),
              ),
            ],
          )),
          Icon(
            icon,
            color: kTextWhiteColor,
          )
        ],
      ),
    );
  }
}
