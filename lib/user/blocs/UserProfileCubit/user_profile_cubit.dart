import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/data/users/projects.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/main.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  static UserProfileCubit get(context) => BlocProvider.of(context);
  var storage=FlutterSecureStorage();
  UserModel? userModel;

  List<WorkExperience> workExperience = [];
  List <Education>education=[] ;
  List<SKills> skills =[] ;
  List<Projects> projects=[]  ;
  var box = Hive.box(boxName);
  double ? percent;


  getProfileData()async{
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    emit(GetProfileDataLoadingState());
    await FirebaseFirestore.instance
        .collection(userType)
        .doc(uid)
        .get()
        .then((value) {

      userModel = UserModel.fromJson(value.data()!);
//       box.put('name', user!.name);
//       box.put('image', user!.image);
//       box.put('email', user!.email);
//       box.put('phone', user!.phone);
// box.put('address', user!.address);
//       box.put('uid', user!.uid);
//       box.put('country', user!.country);

//       box.put('date', user!.date);





      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      emit(GetProfileDataErrorState());
    });
  }
  getWorkExperience() async{
    var token = await storage.read(key: 'uid');
    emit(GetWorkExperienceLoadingState());

    FirebaseFirestore.instance.collection('users').doc(token).collection('workExperience').get()
        .then((value) {
      value.docs.forEach((element) {
        print (element.data());
        workExperience.add(WorkExperience.fromJson(element.data(),element.id));
      });
      emit(GetWorkExperienceSuccessState());
    }).catchError((e){
      emit(GetWorkExperienceErrorState());
    });
  }

  getEducation() async {
    var token = await storage.read(key: 'uid');
    emit(GetEducationLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('education').get()
        .then((value) {


      value.docs.forEach((element) {
        print (element.data());
        print (element.id);
        education.add(Education.fromJson(element.data(),element.id));
      });
      emit(GetEducationSuccessState());
    }).catchError((e){
      emit(GetEducationErrorState());
    });

  }

  getSkills()async{
    var token = await storage.read(key: 'uid');
    emit(GetSkillsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('skills').get()
        .then((value) {
      value.docs.forEach((element) {
        print (element.data());
        skills.add(SKills.fromJson(element.data(),element.id));
      });
      emit(GetSkillsSuccessState());
    }).catchError((e){
      emit(GetSkillsErrorState());
    });


  }

  getProjects()async{
    var token = await storage.read(key: 'uid');
    emit(GetProjectsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('projects').get()
        .then((value) {
      value.docs.forEach((element) {
        print (element.data());
        projects.add(Projects.fromJson(element.data(),element.id));
      });
      emit(GetProjectsSuccessState());
    }).catchError((e){
      emit(GetProjectsErrorState());
    });


  }
  List<String> Completed=[];
  completeProfile()async {
    percent = 0;
    await getProfileData();
    await getWorkExperience();
    await getEducation();
    await getSkills();
    await getProjects();
    if (userModel!.name!.isNotEmpty && userModel!.email!.isNotEmpty &&
        userModel!.phone!.isNotEmpty && userModel!.address!.isNotEmpty &&
        userModel!.country!.isNotEmpty && userModel!.workingField!.isNotEmpty &&
        userModel!.jobField!.isNotEmpty) {
      percent =percent! + 0.20;
      print(percent);
    }else {
      Completed.add('Profile is not completed');
    }
    if (workExperience.isNotEmpty) {
      percent =percent! + 0.20;
      print(percent);

    }else {
      Completed.add('Work Experience is not completed');
    }
    if (education.isNotEmpty) {
      percent =percent! + 0.20;
      print(percent);

    }else {
      Completed.add('Education is not completed');
    }
    if (skills.isNotEmpty) {
      percent =percent! + 0.20;
      print(percent);

    }
    else {
      Completed.add('Skills is not completed');
    }
    if (projects.isNotEmpty) {
      percent =percent! + 0.20;
      print(percent);

    }
    else {
      Completed.add('Projects is not completed');
    }

    emit(CompleteProfileSuccessState());

    // for (var item in workExperience) {
    //   if (item.company!.isNotEmpty && item.position!.isNotEmpty &&
    //       item.startDate!.isNotEmpty && item.endDate!.isNotEmpty) {
    //     percent += 25;
    //   }
    //
    // }
    // for (var item in education) {
    //   if (item.degree!.isNotEmpty && item.field!.isNotEmpty
    //       && item.grade!.isNotEmpty &&
    //       item.degree!.isNotEmpty &&
    //       item.from!.isNotEmpty && item.to!.isNotEmpty) {
    //     percent += 25;
    //   }
    // }
    // for (var item in skills) {
    //   if (item.name!.isNotEmpty) {
    //     percent += 25;
    //   }
    // }
    // for (var item in projects) {
    //   if (item.name!.isNotEmpty && item.description!.isNotEmpty &&
    //      item!) {
    //     percent += 25;
    //   }
    // }
  }


  deleteWorkExperience({required String id})async{
    var token = await storage.read(key: 'uid');
    emit(DeleteWorkExperienceLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('workExperience').doc(id).delete()
        .then((value) {
      emit(DeleteWorkExperienceSuccessState());
    }).catchError((e){
      emit(DeleteWorkExperienceErrorState());
    });
  }
  editWorkExperience({required String id,required WorkExperience workExperience})async{
    var token = await storage.read(key: 'uid');
    emit(EditWorkExperienceLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('workExperience').doc(id).update(workExperience.toJson())
        .then((value) {
      emit(EditWorkExperienceSuccessState());
    }).catchError((e){
      emit(EditWorkExperienceErrorState());
    });
  }
  deleteEducation({required String id})async{
    var token = await storage.read(key: 'uid');
    emit(DeleteEducationLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('education').doc(id).delete()
        .then((value) {
      emit(DeleteEducationSuccessState());
    }).catchError((e){
      emit(DeleteEducationErrorState());
    });
  }
  editEducation({required String id,required Education education})async{
    var token = await storage.read(key: 'uid');
    emit(EditEducationLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('education').doc(id).update(education.toJson())
        .then((value) {
      emit(EditEducationSuccessState());
    }).catchError((e){
      emit(EditEducationErrorState());
    });
  }
  deleteSkills({required String id})async{
    var token = await storage.read(key: 'uid');
    emit(DeleteSkillsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('skills').doc(id).delete()
        .then((value) {
      emit(DeleteSkillsSuccessState());
    }).catchError((e){
      emit(DeleteSkillsErrorState());
    });
  }
  editSkills({required String id,required SKills skills})async{
    var token = await storage.read(key: 'uid');
    emit(EditSkillsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('skills').doc(id).update(skills.toJson())
        .then((value) {
      emit(EditSkillsSuccessState());
    }).catchError((e){
      emit(EditSkillsErrorState());
    });
  }

  deleteProjects({required String id})async{
    var token = await storage.read(key: 'uid');
    emit(DeleteProjectsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('projects').doc(id).delete()
        .then((value) {
      emit(DeleteProjectsSuccessState());
    }).catchError((e){
      emit(DeleteProjectsErrorState());
    });
  }
  editProjects({required String id,required Projects projects})async{
    var token = await storage.read(key: 'uid');
    emit(EditProjectsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('projects').doc(id).update(projects.toJson())
        .then((value) {
      emit(EditProjectsSuccessState());
    }).catchError((e){
      emit(EditProjectsErrorState());
    });
  }


  addWorkExperience({required WorkExperience workExperience})async{
    var token = await storage.read(key: 'uid');
    emit(AddWorkExperienceLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('workExperience').add(workExperience.toJson())
        .then((value) {
      emit(AddWorkExperienceSuccessState());
    }).catchError((e){
      emit(AddWorkExperienceErrorState());
    });
  }
  addEducation({required Education education})async{
    var token = await storage.read(key: 'uid');
    emit(AddEducationLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('education').add(education.toJson())
        .then((value) {
      emit(AddEducationSuccessState());
    }).catchError((e){
      emit(AddEducationErrorState());
    });
  }
  addSkills({required SKills skills})async{
    var token = await storage.read(key: 'uid');
    emit(AddSkillsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('skills').add(skills.toJson())
        .then((value) {
      emit(AddSkillsSuccessState());
    }).catchError((e){
      emit(AddSkillsErrorState());
    });
  }
  addProjects({required Projects projects})async{
    var token = await storage.read(key: 'uid');
    emit(AddProjectsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(token).collection('projects').add(projects.toJson())
        .then((value) {
      emit(AddProjectsSuccessState());
    }).catchError((e){
      emit(AddProjectsErrorState());
    });
  }






}
