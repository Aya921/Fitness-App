enum Sender{user,model,system}
extension SenderX on Sender {
  String get name => this == Sender.user ? 'user' : 'model';

  static Sender fromString(String value) {
    switch (value) {
      case 'user':
        return Sender.user;
      case 'model':
        return Sender.model;
      default:
        return Sender.user;
    }
  }
}