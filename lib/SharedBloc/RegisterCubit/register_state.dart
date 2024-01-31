part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {}
class UserCreateLoadingState extends RegisterState {}
class UserCreateSuccessState extends RegisterState {}
class UserCreateErrorState extends RegisterState {}


class ProfileImagePickedSuccessState extends RegisterState {}
class ProfileImagePickedErrorState extends RegisterState {}
class uploadProfileImageErrorState extends RegisterState {}
class uploadProfileImageSuccessState extends RegisterState {}
class uploadProfileImageLoadingState extends RegisterState {}
class ChangeGenderState extends RegisterState {}

