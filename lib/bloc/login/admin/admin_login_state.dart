part of 'admin_login_cubit.dart';

class AdminLoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  const AdminLoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
  });
  AdminLoginState copyWith(
      {bool? isLoading, bool? isSuccess, bool? isFailure}) {
    return AdminLoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [isLoading,isSuccess,isFailure];

}
