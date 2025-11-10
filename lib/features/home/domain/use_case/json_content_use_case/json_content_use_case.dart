import 'package:fitness/features/home/domain/repositories/json_content_repository/json_content_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class JsonContentUseCase {
  final JsonContentRepository _jsonContentRepository;

  JsonContentUseCase({required JsonContentRepository jsonContentRepository}) : _jsonContentRepository = jsonContentRepository;
  Future<List<dynamic>> invok(String assetPath){
       return _jsonContentRepository.fetchJsonContent(assetPath);
  }
}