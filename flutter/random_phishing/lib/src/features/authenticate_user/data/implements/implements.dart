
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class Authenticate_userRepositoryImp implements Authenticate_userRepository{

        final Authenticate_userRemoteDataSource remoteDataSource;
        Authenticate_userRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    