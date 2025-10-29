sealed class LoginIntent {}

final class LoginWithEmailAndPasswordIntent extends LoginIntent {}

final class UpdateEmailIntent extends LoginIntent {}

final class UpdatePasswordIntent extends LoginIntent {}
