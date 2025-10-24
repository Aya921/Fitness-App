import 'package:equatable/equatable.dart';

class ForgetPassResponse extends Equatable {
  final String info;
 const ForgetPassResponse({required this.info});
  
  @override
 
  List<Object?> get props => [info];
}
