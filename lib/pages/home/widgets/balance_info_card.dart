import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class BalanceInfoCard extends StatelessWidget {
  const BalanceInfoCard({
    Key? key,
    required this.title,
    required this.ikon,
    required this.amountOfFiles,
  }) : super(key: key);

  final String title, amountOfFiles;
  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding / 2),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: kPrimaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Icon(
              ikon,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: kTextBlackColor)),
            ),
          ),
          Text(
            "Rp ${formatNumber(
              amountOfFiles.toString().replaceAll(',', ''),
            ).replaceAll(',', '.')}",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: kTextBlackColor),
          )
        ],
      ),
    );
  }
}
