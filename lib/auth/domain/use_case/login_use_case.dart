import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

class LoginUseCase {
  AuthRepositoryContract repositoryContract;
  LoginUseCase({required this.repositoryContract});

  Future<AuthResultEntity> invoke(String password, String email) {
    return repositoryContract.login(password, email);
  }
}