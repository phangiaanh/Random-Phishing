
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class FsdfdsfRepositoryImp implements FsdfdsfRepository{

        final FsdfdsfRemoteDataSource remoteDataSource;
        FsdfdsfRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    