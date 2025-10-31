import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/widget/cusum_scaffold_messanger.dart';
import 'package:fitness/core/widget/video_widgets/video_section.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_cubit.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_event.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_state.dart';
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
  late YoutubePlayerController? _controller;
  final DetailsFoodCubit _detailsFoodCubit = getIt.get<DetailsFoodCubit>();

  @override
  void initState() {
    super.initState();
    _detailsFoodCubit.doIntent(GetYoutubeIdEvent(videoUrl: widget.videoUrl));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _detailsFoodCubit,
      child: BlocConsumer<DetailsFoodCubit, DetailsFoodState>(
        listener: (context, state) {
          if (state.detailsFoodState.isSuccess) {
            _controller = YoutubePlayerController(
            
         
              initialVideoId: state.detailsFoodState.data as String,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                showLiveFullscreenButton: true,
              ),
            );
          }
          if (state.detailsFoodState.isFailure) {
            showCustomSnackBar(context, state.detailsFoodState.error!.message);
          }
        },

        builder: (context, state) {
          if (state.detailsFoodState.isSuccess && _controller != null) {
            return VideoSection(controller: _controller);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
