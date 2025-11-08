import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:flutter/material.dart';
class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final photo=UserManager().currentUser!.personalInfo!.photo!;
    return   CircleAvatar(
      radius: context.setMinSize(30),
      backgroundImage:
      NetworkImage(photo.toString()),
      backgroundColor: Colors.transparent,
    );
  }
}
