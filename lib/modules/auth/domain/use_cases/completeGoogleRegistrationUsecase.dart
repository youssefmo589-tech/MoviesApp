import '../entity/user_entity.dart';
import '../repositories/auth_repositories.dart';

class CompleteGoogleRegistrationUseCase {
  final AuthRepositories _repository;

  CompleteGoogleRegistrationUseCase(this._repository);

  Future<UserEntity> call(
    String uid,
    String name,
    String email,
    String phone,
    int avatarIndex,
  ) {
    return _repository.completeGoogleRegistration(
      uid,
      name,
      email,
      phone,
      avatarIndex,
    );
  }
}
