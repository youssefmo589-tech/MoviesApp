import '../repository/LayoutviewRepositories.dart';

class EditImageProfileUseCase {
  final LayoutRepositories _LayoutRepositories;

  EditImageProfileUseCase(this._LayoutRepositories);

  Future<bool> call(String image) async {
    return await _LayoutRepositories.EditImageProfile(image);
  }
}
