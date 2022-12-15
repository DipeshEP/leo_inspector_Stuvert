part of 'client_login_cubit.dart';

 class ClientLoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  const ClientLoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
  });
  ClientLoginState copyWith({bool? isLoading, bool? isSuccess, bool? isFailure}){
    return ClientLoginState(
      isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    isFailure: isFailure ?? this.isFailure,
    );
  }




  @override
  List<Object> get props => [isLoading,isSuccess,isFailure];
}
