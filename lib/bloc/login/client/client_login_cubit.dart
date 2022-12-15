import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leo_inspector/data/login/client/model.dart';
import 'package:leo_inspector/data/login/client/repository.dart';

part 'client_login_state.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {

  ClientLoginCubit(this._repository) : super(ClientLoginState());
  ClientLoginRepository _repository;
  Future<void> saveEmailAndPassword(String email,String password)async{
    emit(state.copyWith(isLoading: true,isSuccess: false));
    try {      ClientLoginModel data =  await _repository.postClientLoginRepo(email, password);
    emit(state.copyWith(isSuccess: true,isLoading: false));
    } catch (ex) {
      emit(state.copyWith(isFailure: true,isLoading: false,));
    }
  }

}

