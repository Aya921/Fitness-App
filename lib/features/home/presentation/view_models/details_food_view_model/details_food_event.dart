sealed class DetailsFoodEvent {}

class GetYoutubeIdEvnet extends DetailsFoodEvent {
  final String videoUrl;
  GetYoutubeIdEvnet({required this.videoUrl});
}
