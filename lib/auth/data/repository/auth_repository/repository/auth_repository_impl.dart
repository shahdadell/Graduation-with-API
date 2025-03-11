import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';
import 'package:graduation_project/auth/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<AuthResultEntity> register(
      String username, String password, String email, String phone) {
    return remoteDataSource.register(username, password, email, phone);
  }

  @override
  Future<AuthResultEntity> login(String password, String email) {
    return remoteDataSource.login(password, email);
  }

  @override
  Future<AuthResultEntity> checkemail(String email) {
    return remoteDataSource.checkemail(email);
  }

  @override
  Future<AuthResultEntity> verifyCode(String email, String verifyCode) {
    return remoteDataSource.verifyCode(email ,verifyCode);
  }
}