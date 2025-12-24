// import 'package:fitness/core/responsive/size_helper.dart';
// import 'package:fitness/core/widget/custom_card_fitness.dart';
// import 'package:fitness/core/widget/tab_bar_widget.dart';
// import 'package:fitness/core/widget/tab_item_widget.dart';
// import 'package:flutter/material.dart';
// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return
//       Scaffold(
//       backgroundColor: Colors.black,
//       body:   SizedBox(
//         width: double.infinity,
//         child:       Column(
//          // mainAxisAlignment: MainAxisAlignment.center,
//           //crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 100),
//       SizedBox(
//         height: context.setMinSize(30),
//         child:   TabBarWidget(
//
//           titles: ["full Body",
//             "Chest","Arms","Legs","Back","Shoulder",
//           ], ),
//       ),
//             Expanded(child:
//           Padding(padding: EdgeInsetsDirectional.all(20),
//           child:   GridView.builder(gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
//               crossAxisSpacing: 10,mainAxisSpacing: 16),itemCount: 12,
//             itemBuilder: (context,index){
//               return CustomCardFitness(
//                 title:  "High Chest Exercise",
//                 image:     "https://www.themealdb.com/images/media/meals/1548772327.jpg",
//               );
//             },),
//           )
//             )
//           ],
//         ),
//       ),
//
//     );
//   }
// }
