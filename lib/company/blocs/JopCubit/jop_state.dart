part of 'jop_cubit.dart';

@immutable
abstract class JopState {}

class JopInitial extends JopState {}
class AddJopLoadingState extends JopState {}
class AddJopSuccessState extends JopState {}
class AddJopErrorState extends JopState {}
class GetAllJopsOfCompanyLoadingState extends JopState {}
class GetAllJopsOfCompanySuccessState extends JopState {}
class GetAllJopsOfCompanyErrorState extends JopState {}
class AddjopJopToCompanyLoadingState extends JopState {}
class AddjopJopToCompanySuccessState extends JopState {}
class AddjopJopToCompanyErrorState extends JopState {}
class EditJopLoadingState extends JopState {}
class EditJopSuccessState extends JopState {}
class EditJopErrorState extends JopState {}
class DeleteJopLoadingState extends JopState {}
class DeleteJopSuccessState extends JopState {}
class DeleteJopErrorState extends JopState {}
class GetAllJopsLoadingState extends JopState {}
class GetAllJopsSuccessState extends JopState {}
class GetAllJopsErrorState extends JopState {}

class ApplyingJopLoadingState extends JopState {}
class ApplyingJopSuccessState extends JopState {}
class ApplyingJopErrorState extends JopState {}
class GetAllApplyedJopsLoadingState extends JopState {}
class GetAllApplyedJopsSuccessState extends JopState {}
class GetAllApplyedJopsErrorState extends JopState {}
class GetApplyedUsersLoadingState extends JopState {}
class GetApplyedUsersSuccessState extends JopState {}
class GetApplyedUsersErrorState extends JopState {}
class SearchJopFilterErrorState extends JopState {}
class SearchJopFilterLoadingState extends JopState {}
class SearchJopFilterSuccessState extends JopState {}
class GetApplyedUserdataLoadingState extends JopState {}
class GetApplyedUserdataSuccessState extends JopState {}
class GetApplyedUserdataErrorState extends JopState {}
class ProfileImagePickedSuccessState extends JopState {}
class ProfileImagePickedErrorState extends JopState {}
class uploadProfileImageLoadingState extends JopState {}
class uploadProfileImageSuccessState extends JopState {}
class uploadProfileImageErrorState extends JopState {}







