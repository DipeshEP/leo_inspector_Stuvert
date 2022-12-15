part of 'inspector_login_cubit.dart';

class InspectorLoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  const InspectorLoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,

});
InspectorLoginState copyWith(
    {bool? isLoading, bool? isSuccess, bool? isFailure}) {
  return InspectorLoginState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    isFailure: isFailure?? this.isFailure
  );
    }


  @override
  List<Object?> get props => [isLoading,isSuccess,isFailure];

}
