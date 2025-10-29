sealed class Result<t>{}
class SuccessResult<T> extends Result<T>{
  T successResult;
  SuccessResult(this.successResult);
}
class FailedResult<T> extends Result<T>{
  String errorMessage;
  FailedResult(this.errorMessage);
}