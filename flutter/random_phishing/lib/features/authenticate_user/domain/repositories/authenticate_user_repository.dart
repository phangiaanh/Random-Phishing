import 'package:dartz/dartz.dart';
import 'package:random_phishing/core/error/failures.dart';
import 'package:random_phishing/features/authenticate_user/domain/entities/authenticate_user_entity.dart';
import 'package:random_phishing/features/authenticate_user/domain/usecases/fetch_authenticate_user_usecase.dart';

abstract class AuthenticateUserRepository {
  Future<Either<Failure, AuthenticateUserEntity>> fetchAuthenticateUser({required FetchAuthenticateUserParam params});
}
