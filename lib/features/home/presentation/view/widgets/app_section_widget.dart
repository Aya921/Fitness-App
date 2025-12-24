import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/cupertino.dart';

class AppSectionWidget extends StatelessWidget {
  const AppSectionWidget({super.key,required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsetsDirectional.only(
        top: context.setMinSize(10),
        end: context.setMinSize(16),
        start:context.setMinSize(16),
        bottom: context.setMinSize(20),
      ),

      child:
      ClipRRect(

        borderRadius: BorderRadius.circular
          (context.setMinSize(16)),
        child:child

      ),
    );
  }
}
