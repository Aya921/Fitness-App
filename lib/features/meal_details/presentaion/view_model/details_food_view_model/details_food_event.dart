sealed class DetailsFoodEvent {}

class GetYoutubeIdEvent extends DetailsFoodEvent {
  final String videoUrl;
  GetYoutubeIdEvent({required this.videoUrl});
}

class GetMealDetailsEvent extends DetailsFoodEvent {
  final String mealId;
  GetMealDetailsEvent({required this.mealId});
}
