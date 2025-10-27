
sealed class OnBoardingIntent {}

class NextPageIntent extends OnBoardingIntent {}

class PreviousPageIntent extends OnBoardingIntent {}

class PageChangedIntent extends OnBoardingIntent {
  final int pageIndex;

  PageChangedIntent(this.pageIndex);
}

class JumpToPageIntent extends OnBoardingIntent {
  final int pageIndex;

  JumpToPageIntent(this.pageIndex);
}
