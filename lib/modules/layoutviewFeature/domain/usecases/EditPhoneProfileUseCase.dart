import '../repository/LayoutviewRepositories.dart';

class EditPhoneProfileUseCase {
  final LayoutRepositories _layoutRepositories;

  EditPhoneProfileUseCase(this._layoutRepositories);

  Future<bool> call(String phone) async {
    return await _layoutRepositories.EditNameProfile(phone);
  }
}
