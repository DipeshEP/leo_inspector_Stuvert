import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leo_inspector/data/login/admin/model.dart';
import 'package:leo_inspector/data/login/admin/repository.dart';

part 'admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  AdminLoginCubit(this._repository) : super(const AdminLoginState());
  AdminLoginRepository _repository;

  Future<void> saveEmailAndPassword(String email, String password)async {
    emit(state.copyWith(isLoading: true,isSuccess: false));
    try {
    AdminLoginModel data =  await _repository.postAdminLoginRepo(email, password);
      emit(state.copyWith(isSuccess: true,isLoading: false));
    } catch (ex) {
      emit(state.copyWith(isFailure: true,isLoading: false,));
    }
  }
}
