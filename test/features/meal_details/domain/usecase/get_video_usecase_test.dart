import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/repository/details_food_repo.dart';
import 'package:fitness/features/meal_details/domain/usecase/get_video_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_video_usecase_test.mocks.dart';

@GenerateMocks([DetailsFoodRepo])
void main() {
  late MockDetailsFoodRepo mockDetailsFoodRepo;
  late GetVideoUsecase getVideoUsecase;

  setUp(() {
    mockDetailsFoodRepo = MockDetailsFoodRepo();
    getVideoUsecase = GetVideoUsecase(mockDetailsFoodRepo);
  });

  group('GetVideoUsecase', () {
    const videoUrl = 'https://youtube.com/watch?v=abc123';
    const convertedUrl = 'abc123';

    test('should return SuccessResult when repo call succeeds', () async {
      final mockResult = SuccessResult<String>(convertedUrl);
      provideDummy<Result<String>>(mockResult);

      when(mockDetailsFoodRepo.convertIdToVideo(videoUrl))
          .thenAnswer((_) async => mockResult);

      final result = await getVideoUsecase.convetIdToVideo(videoUrl: videoUrl);

      expect(result, isA<SuccessResult<String>>());
      verify(mockDetailsFoodRepo.convertIdToVideo(videoUrl)).called(1);
    });

    test('should return FailedResult when repo call fails', () async {
      final mockResult = FailedResult<String>('Failed to convert video ID');
      provideDummy<Result<String>>(mockResult);

      when(mockDetailsFoodRepo.convertIdToVideo(videoUrl))
          .thenAnswer((_) async => mockResult);

      final result = await getVideoUsecase.convetIdToVideo(videoUrl: videoUrl);

      expect(result, isA<FailedResult<String>>());
      verify(mockDetailsFoodRepo.convertIdToVideo(videoUrl)).called(1);
    });
  });
}
