import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leo_inspector/data/login/guest/model.dart';
import 'package:leo_inspector/data/login/guest/repository.dart';

part 'guest_login_state.dart';

class GuestLoginCubit extends Cubit<GuestLoginState> {
  GuestLoginCubit(this._repository) : super(GuestLoginState());
  GuestLoginRepository _repository;
  Future<void>saveEmailAndpassword(String email,String password)async{
    emit(state.copyWith(isLoading:true,isSuccess:false));
    try{GuestLoginModel data = await _repository.postGuestLoginRepo(email, password
    );
 emit(state.copyWith(isSuccess:true,isLoading:false));
    }catch(ex){
      emit(state.copyWith(isFailure:true,isLoading:false,));
}

    }
  }

