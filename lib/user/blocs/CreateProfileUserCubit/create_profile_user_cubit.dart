import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/data/users/projects.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/data/users/work_experience.dart';

part 'create_profile_user_state.dart';

class CreateProfileUserCubit extends Cubit<CreateProfileUserState> {
  CreateProfileUserCubit() : super(CreateProfileUserInitial());
  static CreateProfileUserCubit get(context) => BlocProvider.of(context);
  var storage = FlutterSecureStorage();
  String? token;


  addExperience(List<WorkExperience> workExperience) async {
    try {
      token = await storage.read(key: 'uid');
      emit(AddExperienceLoadingState());

      for (var element in workExperience) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(token)
            .collection('workExperience')
            .add(element.toJson())
            .then((value) {
          emit(AddExperienceSuccessState());
        }).catchError((error) {
          emit(AddExperienceErrorState());
        });
      }
      emit(AddExperienceSuccessState());

    } catch (error) {
      print(error);
      emit(AddExperienceErrorState());
    }
  }

  addEducation(List<Education> education) async {
    try {
      token = await storage.read(key: 'uid');
      emit(AddEducationLoadingState());

      for (var element in education) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(token)
            .collection('education')
            .add(element.toJson())
            .then((value) {
          emit(AddEducationSuccessState());

        }).catchError((error) {
          emit(AddEducationErrorState());
        });
      }
      emit(AddEducationSuccessState());


    } catch (error) {
      print(error);
      emit(AddEducationErrorState());
    }
  }
  addSkills(List<SKills> skills) async {
    try {
      token = await storage.read(key: 'uid');
      emit(AddSkillsLoadingState());

      for (var element in skills) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(token)
            .collection('skills')
            .add(element.toJson())
            .then((value) {
          emit(AddSkillsSuccessState());
        }).catchError((error) {
          emit(AddSkillsErrorState());
        });
      }
      emit(AddSkillsSuccessState());

    } catch (error) {
      print(error);
      emit(AddSkillsErrorState());
    }
  }
  Future addProjects(List<Projects> projects) async {
    try {
      token = await storage.read(key: 'uid');
      emit(AddProjectsLoadingState());

      for (var element in projects) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(token)
            .collection('projects')
            .add(element.toJson())
            .then((value) {
          emit(AddProjectsSuccessState());
        }).catchError((error) {
          emit(AddProjectsErrorState());
        });
      }
      emit(AddProjectsSuccessState());

    } catch (error) {
      print(error);
      emit(AddProjectsErrorState());
    }
  }

}
