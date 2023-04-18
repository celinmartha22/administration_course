import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

import '../../../data/model/user.dart';

class ProfilePic extends StatelessWidget {
   ProfilePic({
    Key? key,required this.currentUser
  }) : super(key: key);
  User currentUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(currentUser.name.substring(0,1),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    letterSpacing: 0)),
          ),
         
        ],
      ),
    );
  }
}
