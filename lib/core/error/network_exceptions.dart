import 'package:emvigo/core/error/failure.dart';

class GenericFailure implements Failure {
  @override
  final String message;

  GenericFailure(this.message);

  @override
  String toString() => 'GenericFailure: $message';
}
