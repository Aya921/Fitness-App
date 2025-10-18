import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/end_points_constants.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class AuthApiServices{

}