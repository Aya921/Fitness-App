import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/constants/constants.dart';
import 'on_boarding_intent.dart';
import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(const OnBoardingState());

  final PageController _pageController = PageController();
  PageController controller() => _pageController;


  final List<String> _images = [
    AssetsManager.onBoardingOne,
    AssetsManager.onBoardingTwo,
    AssetsManager.onBoardingThree,
  ];

  final List<String> _titles = [
    Constants.titleOnBoarding,
    Constants.titleTwoBoarding,
    Constants.titleThreeBoarding,
  ];

  List<String> get images => _images;
  List<String> get titles => _titles;

  void intent(OnBoardingIntent intent) {
    switch (intent) {
      case NextPageIntent _:
        _nextPage();
        break;
      case PreviousPageIntent _:
        _previousPage();
        break;
      case PageChangedIntent _:
        _onPageChanged((intent).pageIndex);
        break;
      case JumpToPageIntent _:
        _jumpToPage((intent).pageIndex);
        break;
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int index) {
    emit(state.copyWith(pageIndex: index));
  }

  void _jumpToPage(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}

