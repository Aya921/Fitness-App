import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/widget/cusum_scaffold_messanger.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/core/widget/video_widgets/video_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/video_error_dialog.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_intent.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _controller;
  final ExercisesCubit _cubit = getIt<ExercisesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.doIntent(intent: GetYoutubeIdIntent(videoUrl: widget.videoUrl));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ExercisesCubit, ExercisesStates>(
        listener: (context, state) {
          if (state.youtubeIdStatus.isFailure) {
            showCustomSnackBar(context, state.youtubeIdStatus.error!.message);
          }
        },
        builder: (context, state) {
          if (state.youtubeIdStatus.isLoading) {
            return const LoadingCircle();
          }

          if (state.youtubeIdStatus.isSuccess) {
            final videoId = state.youtubeIdStatus.data!;
            _controller = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(autoPlay: true),
            );
            return VideoSection(controller: _controller);
          }

          if (state.youtubeIdStatus.isFailure) {
            return VideoErrorDialog(message:
              state.youtubeIdStatus.error?.message ??
                  context.loc.errorLoadingVideo,
            );
          }

          return VideoErrorDialog(message:
          state.youtubeIdStatus.error?.message ??
              context.loc.errorLoadingVideo,
          );
        },
      ),
    );
  }


}
