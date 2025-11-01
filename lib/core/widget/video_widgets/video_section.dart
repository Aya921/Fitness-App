import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoSection extends StatelessWidget {
  const VideoSection({
    super.key,
    required YoutubePlayerController? controller,
  }) : _controller = controller;

  final YoutubePlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(177, 0, 0, 0),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: YoutubePlayer(
                controller: _controller!,
                bufferIndicator:const CircularProgressIndicator(color: Colors.transparent),

                onReady: _controller.play,
              ),
            ),
            Positioned(
              right: context.setWidth(20),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: context.setWidth(30),
                ),
                onPressed: () {
                  _controller.pause();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
