import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/data/data_source/explore_data_source/explore_data_source.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ExploreDataSource)
class ExploreDataSourceImpl implements ExploreDataSource{
  final ApiServices _apiServices;

  ExploreDataSourceImpl(this._apiServices); 
 

  @override
  Future<Result<List<MusclesGroupEntity>>> getMusclesGroup() {
     return safeApiCall(()async{
      final response =  await _apiServices.getAllMusclesGroup();
      final data =response.musclesGroup;
      return data?.map((model) => model.toEntity()).toList() ?? [];
    });
  }

  @override
  Future<Result<List<MuscleEntity>>> getRandomMuscles() {
     return safeApiCall(()async{
      final response =  await _apiServices.getAllRandomMuscles();
      final data =response.muscles;
      return data?.map((model) => model.toEntity()).toList() ?? [];
    });
  }

  @override
  Future<Result<MusclesGroupIdResponseEntity>> getAllMusclesGroupById(String? id) {
   return safeApiCall(()async{
      final response =  await _apiServices.getAllMusclesGroupById(id);
      final data =response;
      return data.toEntity();
    });
  }

}