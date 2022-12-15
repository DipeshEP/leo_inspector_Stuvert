part of 'guest_login_cubit.dart';

 class GuestLoginState extends Equatable {
   final bool isLoading;
   final bool isSuccess;
   final bool isFailure;

   const GuestLoginState({
     this.isLoading = false,
     this.isSuccess = false,
     this.isFailure = false,
   });

   GuestLoginState copyWith(
       {bool? isLoading, bool? isSuccess, bool? isFailure}) {
     return GuestLoginState(
       isLoading: isLoading ?? this.isLoading,
       isSuccess: isSuccess ?? this.isSuccess,
       isFailure: isFailure ?? this.isFailure,
     );
   }

   @override
   List<Object> get props => [isLoading, isSuccess, isFailure];
 }