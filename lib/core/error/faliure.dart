abstract class Failure {
  dynamic message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(dynamic message) : super(message);
}
