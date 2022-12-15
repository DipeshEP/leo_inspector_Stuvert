import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leo_inspector/data/login/inspector/model.dart';
import 'package:leo_inspector/data/login/inspector/repository.dart';

import '../../../Model/inspector_login_response_model.dart';

part 'inspector_login_state.dart';

class InspectorLoginCubit extends Cubit<InspectorLoginState> {
  InspectorLoginCubit(this._repository) : super(InspectorLoginState());
  InspectorLoginRepository _repository;

  saveEmailAndPassword(String email,String password)async{
    emit(state.copyWith(isLoading:true,isSuccess:false));
    try{
      InspectorLoginModel data =await _repository.postInspectorLoginRepo(email,password);
      emit (state.copyWith(isSuccess:true,isLoading:false));
    }catch(ex){
      emit(state.copyWith(isFailure:true,isLoading:false));
    }
  }
}



