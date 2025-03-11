import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

class CheckEmailUseCase {
  AuthRepositoryContract repositoryContract;
  CheckEmailUseCase({required this.repositoryContract});

  Future<AuthResultEntity> invoke(String email) {
    return repositoryContract.checkemail(email);
  }
}