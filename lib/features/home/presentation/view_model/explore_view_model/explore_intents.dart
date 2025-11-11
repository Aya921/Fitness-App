sealed class ExploreIntents {}
class GetHomeData extends ExploreIntents{}
class GetMusclesGroupByIdIntent extends ExploreIntents{
  final String? id;

  GetMusclesGroupByIdIntent({required this.id});
}
