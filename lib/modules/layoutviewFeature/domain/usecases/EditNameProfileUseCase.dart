import '../repository/LayoutviewRepositories.dart';

class EditNameProfileUseCase {
  final LayoutRepositories _layoutRepositories;

  EditNameProfileUseCase(this._layoutRepositories);

  Future<bool> call(String name) async {
    return await _layoutRepositories.EditNameProfile(name);
  }
}
