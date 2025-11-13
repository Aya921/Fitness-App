import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';


//  @LazySingleton()
//  class SmartCoachApiServices {
//    final _gemini = Gemini.instance;
// //
// //    Stream<Candidates?> streamChatWithSpecialPrompt(
// //        List<Content> history, {
// //          String? model,
// //          String? userName,
// //        })
// //    {
// //      final modifiedHistory = List<Content>.from(history);
// //
// //      modifiedHistory.insert(
// //        0,
// //        Content(
// //          role: 'system',
// //          parts: [Part.text(Constants.fitnessPrefix)],
// //        ),
// //      );
// //
// //      if (userName != null && userName.isNotEmpty && history.isEmpty) {
// //        final welcome = """
// // Hey $userName! Welcome aboard!
// // I'm **SmartCoach** – your AI personal trainer, nutritionist, and motivator.
// // Tell me your **weight, height, goal, and fitness level**, and I’ll build you a **custom workout + meal plan** in seconds.
// // Let’s get stronger together!
// // """;
// //        modifiedHistory.insert(
// //          1,
// //          Content(role: 'system', parts: [Part.text(welcome)]),
// //        );
// //      }
// //
// //      return _gemini.streamChat(
// //        modifiedHistory,
// //        modelName: model ?? 'gemini-1.5-flash',
// //      );
// //    }
//    Stream<Candidates?> streamChatWithSpecialPrompt(
//        List<Content> history, {
//          String? model,
//          String? userName,
//        }){
//      return _gemini.streamChat(history,modelName: model);
//    }
//  }
 @lazySingleton
 class SmartCoachService {
   Stream<Candidates?> streamChat(List<Content> history,{String? model}) {
     return Gemini.instance.streamChat(history,modelName: model);
   }
 }