part of 'create_profile_user_cubit.dart';

@immutable
abstract class CreateProfileUserState {}

class CreateProfileUserInitial extends CreateProfileUserState {}

class AddExperienceLoadingState extends CreateProfileUserState {}
class AddExperienceSuccessState extends CreateProfileUserState {}
class AddExperienceErrorState extends CreateProfileUserState {}


class AddEducationLoadingState extends CreateProfileUserState {}
class AddEducationSuccessState extends CreateProfileUserState {}
class AddEducationErrorState extends CreateProfileUserState {}



class AddSkillsLoadingState extends CreateProfileUserState {}
class AddSkillsSuccessState extends CreateProfileUserState {}
class AddSkillsErrorState extends CreateProfileUserState {}


class AddProjectsLoadingState extends CreateProfileUserState {}
class AddProjectsSuccessState extends CreateProfileUserState {}
class AddProjectsErrorState extends CreateProfileUserState {}

class CreateProfileUserSuccess extends CreateProfileUserState {}


class CreateProfileUserError extends CreateProfileUserState {}

class CreateProfileUserLoading extends CreateProfileUserState {}

class CreateProfileUserLoaded extends CreateProfileUserState {}


