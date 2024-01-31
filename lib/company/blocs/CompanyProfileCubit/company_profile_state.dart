part of 'company_profile_cubit.dart';

@immutable
abstract class CompanyProfileState {}

class CompanyProfileInitial extends CompanyProfileState {}
class GetProfileDataLoadingState extends CompanyProfileState {}
class GetProfileDataSuccessState extends CompanyProfileState {}
class GetProfileDataErrorState extends CompanyProfileState {}
class UpdateProfileDataLoadingState extends CompanyProfileState {}
class UpdateProfileDataSuccessState extends CompanyProfileState {}
class UpdateProfileDataErrorState extends CompanyProfileState {}
class ProfileImagePickedSuccessState extends CompanyProfileState {}
class ProfileImagePickedErrorState extends CompanyProfileState {}
class uploadProfileImageLoadingState extends CompanyProfileState {}
class uploadProfileImageSuccessState extends CompanyProfileState {}
class uploadProfileImageErrorState extends CompanyProfileState {}



