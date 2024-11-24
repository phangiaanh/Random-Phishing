import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}