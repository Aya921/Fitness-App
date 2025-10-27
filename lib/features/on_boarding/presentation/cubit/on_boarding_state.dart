import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class OnBoardingState extends Equatable {
  final int pageIndex;
  const OnBoardingState({this.pageIndex = 0});

  OnBoardingState copyWith({int? pageIndex}) {
    return OnBoardingState(
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object?> get props => [pageIndex];
}
