import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_intents.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() :super(const BottomNavigationState(index: 0));
 
 void doIntent(BottomNavigationIntents intent){
  switch(intent){
    case GoToTab():
    _changeTab(index: intent.index);
    break;
    case SelectGroupIntent():
    _selectGroup(intent.groupId);
     break;
    case SyncDataIntent():
    _syncData(
      muscleGroupsData: intent.muscleGroupsData,
      muscleByGroupId: intent.muscleByGroupId
    );
      break;
  }
 }


  void _changeTab(
      {required int index}) {
    emit(state.copyWith(
      index: index,
    ));
  }

  void _selectGroup(String groupId) {
    emit(state.copyWith(selectedGroupId: groupId));
  }

  void _syncData({List<MusclesGroupEntity>? muscleGroupsData,
      Map<String, MusclesGroupIdResponseEntity>? muscleByGroupId}){
 emit(state.copyWith(
      muscleGroupsData: muscleGroupsData ??state.muscleGroupsData,
      muscleByGroupId: muscleByGroupId ?? state.muscleByGroupId 
    ));
  }
}