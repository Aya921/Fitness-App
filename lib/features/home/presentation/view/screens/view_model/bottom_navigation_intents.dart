// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';

sealed class BottomNavigationIntents {}


class GoToTab extends BottomNavigationIntents {
  int index;
  GoToTab({
    required this.index,
  });
}
class SelectGroupIntent extends BottomNavigationIntents {
final String groupId;
   SelectGroupIntent(this.groupId);
}

class SyncDataIntent extends BottomNavigationIntents{
  List<MusclesGroupEntity>? muscleGroupsData;
  Map<String,MusclesGroupIdResponseEntity>? muscleByGroupId;
  SyncDataIntent({required this.muscleGroupsData,required this.muscleByGroupId});
}
