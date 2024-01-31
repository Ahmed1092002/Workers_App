import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/data/users/projects.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/main.dart';

part 'jop_state.dart';

class JopCubit extends Cubit<JopState> {
  JopCubit() : super(JopInitial());
  static JopCubit get(context) => BlocProvider.of(context);

  JopsModel? jop;
  var box = Hive.box(boxName);
  var storage = FlutterSecureStorage();
  DateTime? now = DateTime.now();
  List<JopsModel> jops = [];

  addJop({required String jopTitle,
    required String jopDescription,
    required int jopSalary,
    required String jopLocation,
    required String jopRequirements,
    required String jopSkills,
    required String jopExperience,
required String companyname,
    required String jopType,
required String JopField,
    String? jopid,
    required String jopImage}) async {
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    jop = JopsModel(
      companyUid: uid,
       date: now.toString(),
      description: jopDescription,
      companyInfo: await box.get('companyInfo'),
      Experience: jopExperience,
      imageUrl: jopImage,
      location: jopLocation,
      jopType: jopType,
      Requirements: jopRequirements,
      Salary: jopSalary,
      Skills: jopSkills,
      title: jopTitle,
      workingField: userType,
      jopField: JopField,
      jopid: jopid,
      userEmail: box.get('email'),

      companyname: companyname




    );
    emit(AddJopLoadingState());
    await FirebaseFirestore.instance
        .collection('jops')
    .doc(jopid)
        .set(jop!.toJson())
        .then((value)async {



      emit(AddJopSuccessState());

    })
        .catchError((error) {
      emit(AddJopErrorState());
    });
  }

  addJopToCompany({required String jopTitle,
    required String jopDescription,
    required int jopSalary,
    required String jopLocation,
    required String jopRequirements,
    required String jopSkills,
    required String jopExperience,
    required String jopType,
    required String JopField,

    required String jopImage}) async {
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    jop = JopsModel(
      companyUid: uid,
      date: now.toString(),
      jopType: jopType,
      description: jopDescription,
      Experience: jopExperience,
      imageUrl: jopImage,
      location: jopLocation,
      Requirements: jopRequirements,
      jopField: JopField,
      Salary: jopSalary,
      Skills: jopSkills,
      title: jopTitle,
      workingField: userType,
      userEmail: box.get('email')

    );
    emit(AddjopJopToCompanyLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('jops')
        .add(jop!.toJson()).then((value) {
          print (value.id);
          addJop(jopTitle: jopTitle,
              companyname: box.get('name'),
              JopField: JopField,
              jopDescription: jopDescription,
              jopSalary: jopSalary,
              jopLocation: jopLocation,
              jopRequirements: jopRequirements,
              jopSkills: jopSkills,
              jopExperience: jopExperience,
              jopType: jopType,
              jopid: value.id,

              jopImage: jopImage);


      emit(AddjopJopToCompanySuccessState());


    }
    ).catchError((error) {
      emit(AddJopErrorState());
    });
    }

    getAllJopsOfComapny()async{
      String? uid = await storage.read(key: 'uid');
      String userType = await box.get('userType').toString();
      emit(GetAllJopsOfCompanyLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('jops')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print (element.data());
          jops.add(JopsModel.fromJson(element.data(), element.id));
        });
        emit(GetAllJopsOfCompanySuccessState());
      }).catchError((error) {
        emit(GetAllJopsOfCompanyErrorState());
      });

    }

    editJop({
      required String jopTitle,
      required String jopDescription,
      required int jopSalary,
      required String jopLocation,
      required String jopRequirements,
      required String jopSkills,
      required String jopExperience,
      required String jopType,
      required String JopField,
      required String jopid,
      required String jopImage})async{
      String? uid = await storage.read(key: 'uid');
      String userType = await box.get('userType').toString();
      jop = JopsModel(
          companyUid: uid,
          date: now.toString(),
          jopType: jopType,
          description: jopDescription,
          Experience: jopExperience,
          imageUrl: jopImage,
          location: jopLocation,
          Requirements: jopRequirements,
          jopField: JopField,
          Salary: jopSalary,
          Skills: jopSkills,
          title: jopTitle,
          workingField: userType,
          userEmail: box.get('email')

      );
      emit(EditJopLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('jops')
          .doc(jopid)
          .update(jop!.toJson()).then((value) {
        emit(EditJopSuccessState());
      }).catchError((error) {
        emit(EditJopErrorState());
      });

      await FirebaseFirestore.instance
          .collection('jops')
          .doc(jopid)
          .update(jop!.toJson()).then((value) {
        emit(EditJopSuccessState());
      }).catchError((error) {
        emit(EditJopErrorState());
      });

    }



    deleteJop({required String jopid})async{
      String? uid = await storage.read(key: 'uid');
      String userType = await box.get('userType').toString();
      emit(DeleteJopLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('jops')
          .doc(jopid)
          .delete().then((value) {
        emit(DeleteJopSuccessState());
      }).catchError((error) {
        emit(DeleteJopErrorState());
      });

      await FirebaseFirestore.instance
          .collection('jops')
          .doc(jopid)
          .delete().then((value) {
        emit(DeleteJopSuccessState());
      }).catchError((error) {
        emit(DeleteJopErrorState());
      });

    }
    GetAllJops ()async{
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      emit(GetAllJopsLoadingState());
      await FirebaseFirestore.instance
          .collection('jops')
          // .where('date', isGreaterThanOrEqualTo: startOfWeek.toString())
          // .where('date', isLessThanOrEqualTo: endOfWeek.toString())
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print (element.data());
          jops.add(JopsModel.fromJson(element.data(), element.id));
        });
        emit(GetAllJopsSuccessState());
      }).catchError((error) {
        emit(GetAllJopsErrorState());
      });

    }

  Future  applyingjop({

      required String jopid,

      required String companyUid,

})
   async {
     String? userUid = await storage.read(key: 'uid');
     emit(ApplyingJopLoadingState());

     var jobDoc = FirebaseFirestore.instance.collection('users').doc(userUid).collection('applyedJobs').doc(jopid);
     var userDoc = FirebaseFirestore.instance.collection('users').doc(companyUid).collection('jops').doc(jopid).collection('applyedUsers').doc(userUid);

     if ((await jobDoc.get()).exists) {
       emit(ApplyingJopErrorState());
       return;
     }

     try {
       await userDoc.set({'uid': userUid});
       await jobDoc.set({'jobId': jopid});
       emit(ApplyingJopSuccessState());
     } catch (error) {
       emit(ApplyingJopErrorState());
     }

    }


    getAllApplyedJops()async{
      String? UserUid = await storage.read(key: 'uid');
      List<String> jopids = [];
jops.clear();
      emit(GetAllApplyedJopsLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserUid)
          .collection('applyedJops')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.data());
          jopids.add(element.id);
        });

        });
      for(String jopid in jopids) {
        await FirebaseFirestore.instance
            .collection('jops')
            .doc(jopid)
            .get()
            .then((value) {
          print(value.data());
          jops.add(JopsModel.fromJson(value.data() as Map <String, dynamic>, value.id));
          emit(GetAllApplyedJopsSuccessState());
        }).catchError(
              (error) {
            emit(GetAllApplyedJopsErrorState());
          },
        );
      }




          }

List<UserModel> applyedUsers = [];


    getApplyedUsers({required String jopid})async{
      String? companyUid = await storage.read(key: 'uid');
      List<String> users = [];
      emit(GetApplyedUsersLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(companyUid)
          .collection('jops')
          .doc(jopid)
          .collection('applyedUsers')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.data());
          users.add(element.id);
        });

      }).catchError((error) {
        emit(GetApplyedUsersErrorState());
      });
      for (String user in users){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user)
            .get()
            .then((value) {
          print(value.data());
          applyedUsers.add(UserModel.fromJson(value.data() as Map<String, dynamic>));
          emit(GetApplyedUsersSuccessState());
        }).catchError((error) {
          emit(GetApplyedUsersErrorState());
        });
      }

    }
  List<WorkExperience> workExperience = [];
  List <Education>education=[] ;
  List<SKills> skills =[] ;
  List<Projects> projects=[]  ;

   Future getApplyedUserdata({required String uid})async {
      emit(GetApplyedUserdataLoadingState());
      FirebaseFirestore.instance.collection('users').doc(uid).collection('education').get()
          .then((value) {


        value.docs.forEach((element) {
          print (element.data());
          education.add(Education.fromJson(element.data(),element.id));
        });
        emit(GetApplyedUserdataSuccessState());
      }).catchError((error) {
        emit(GetApplyedUserdataErrorState());
      });

      FirebaseFirestore.instance.collection('users').doc(uid).collection('workExperience').get()
          .then((value) {
        value.docs.forEach((element) {
          print (element.data());
          workExperience.add(WorkExperience.fromJson(element.data(),element.id));
        });
        emit(GetApplyedUserdataSuccessState());
      }).catchError((error) {
        emit(GetApplyedUserdataErrorState());
      });

      FirebaseFirestore.instance.collection('users').doc(uid).collection('skills').get()
          .then((value) {
        value.docs.forEach((element) {
          print (element.data());
          skills.add(SKills.fromJson(element.data(),element.id));
        });
        emit(GetApplyedUserdataSuccessState());
      }).catchError((error) {
        emit(GetApplyedUserdataErrorState());
      });

      FirebaseFirestore.instance.collection('users').doc(uid).collection('projects').get()
          .then((value) {
        value.docs.forEach((element) {
          print (element.data());
          projects.add(Projects.fromJson(element.data(),element.id));
        });
        emit(GetApplyedUserdataSuccessState());
      }).catchError((error) {
        emit(GetApplyedUserdataErrorState());
      });

    }








   Future searchJopFilter({ String? jopTitle,
     String? jopLocation ,
     String? jopType
    , int? jopSalary,
     String? jopField,
     String? jopExperience})async{
      emit(SearchJopFilterLoadingState());
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('jops');

      if (jopTitle!=null|| jopTitle!.isEmpty ){
      query = query.where('title',isEqualTo: jopTitle);
      }
      else if (jopLocation!=null){
        query = query.where('location',isEqualTo: jopLocation);
      }
      else if (jopType!=null){
        query = query.where('jopType',isEqualTo: jopType);
      }
      else if (jopSalary!=null){
        query = query.where('Salary',isLessThanOrEqualTo: jopSalary);
      }
      else if (jopField!=null){
        query = query.where('jopField',isEqualTo: jopField);
      }
     else if (jopExperience!=null){
        query = query.where('Experience',isEqualTo: jopExperience);
      }
      //jop title
      else if (jopTitle!=null&&jopLocation!=null){
        query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation);
      }
     else if (jopTitle!=null&&jopLocation!=null&&jopType!=null){
        query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType);
      }
     else if (jopTitle!=null&&jopLocation!=null&&jopType!=null&&jopSalary!=null){
        query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary);
      }
     else if (jopTitle!=null&&jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null){
        query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
      }
     else if (jopTitle!=null&&jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null&&jopExperience!=null){
        query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField).where('Experience',isEqualTo: jopExperience);
      }
      //jop Location
     else if ( jopLocation!=null&&jopType!=null){
        query = query.where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType);
      }
     else if (jopLocation!=null&&jopType!=null&&jopSalary!=null){
        query = query.where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary);
      }
     else if (jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null){
        query = query.where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
      }
     else if (jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null&&jopExperience!=null) {
        query = query.where('location', isEqualTo: jopLocation).where(
            'jopType', isEqualTo: jopType)
            .where('Salary',isLessThanOrEqualTo: jopSalary)
            .where('jopField', isEqualTo: jopField)
            .where('Experience', isEqualTo: jopExperience);
      }
      // jopType
    else  if (jopType!=null&&jopSalary!=null){
        query = query.where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary);
      }
    else  if (jopType!=null&&jopSalary!=null&&jopField!=null){
        query = query.where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
      }
     else if (jopType!=null&&jopSalary!=null&&jopField!=null&&jopExperience!=null) {
        query = query.where('jopType', isEqualTo: jopType)
            .where('Salary',isLessThanOrEqualTo: jopSalary)
            .where('jopField', isEqualTo: jopField)
            .where('Experience', isEqualTo: jopExperience);
      }
      //jop Salary
     else if (jopSalary!=null&&jopField!=null){
        query = query.where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
      }
     else if (jopSalary!=null&&jopField!=null&&jopExperience!=null) {
        query = query.where('Salary',isLessThanOrEqualTo: jopSalary)
            .where('jopField', isEqualTo: jopField)
            .where('Experience', isEqualTo: jopExperience);
      }
      //jop Field
    else  if (jopField!=null&&jopExperience!=null) {
        query = query.where('jopField', isEqualTo: jopField)
            .where('Experience', isEqualTo: jopExperience);
      }
      //jop Experience
     else if (jopExperience!=null) {
        query = query.where('Experience', isEqualTo: jopExperience);
      }

      query.get().then((value) {
        jops.clear();
        value.docs.forEach((element) {
          jops.add(JopsModel.fromJson(element.data(), element.id));
        });
        emit(SearchJopFilterSuccessState());
      }).catchError((error) {
        emit(SearchJopFilterErrorState());
      });



      // await FirebaseFirestore.instance
      //     .collection('jops')
      //     .where('title',isEqualTo: jopTitle)
      //     .where('location',isEqualTo: jopLocation)
      //     .where('jopType',isEqualTo: jopType)
      //     .where('Salary',isEqualTo: jopSalary)
      //     .where('jopField',isEqualTo: jopField)
      //     .where('Experience',isEqualTo: jopExperience)
      //     .get()
      //     .then((value) {
      //       jops.clear();
      //   value.docs.forEach((element) {
      //     print (element.data());
      //     jops.add(JopsModel.fromJson(element.data(), element.id));
      //   });
      //   emit(SearchJopFilterSuccessState());
      // }).catchError((error) {
      //   emit(SearchJopFilterErrorState());
      // });
    }



  Future searchMyJopsFilter({ String? jopTitle,
    String? jopLocation ,
    String? jopType
    , int? jopSalary,
    String? jopField,
    String? jopExperience})async{
     String? uid = await storage.read(key: 'uid');
    emit(SearchJopFilterLoadingState());

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('users').doc(uid).collection('jops');

    if (jopTitle!=null|| jopTitle!.isEmpty ){
      query = query.where('title',isEqualTo: jopTitle);
    }
    else if (jopLocation!=null){
      query = query.where('location',isEqualTo: jopLocation);
    }
    else if (jopType!=null){
      query = query.where('jopType',isEqualTo: jopType);
    }
    else if (jopSalary!=null){
      query = query.where('Salary',isLessThanOrEqualTo: jopSalary);
    }
    else if (jopField!=null){
      query = query.where('jopField',isEqualTo: jopField);
    }
    else if (jopExperience!=null){
      query = query.where('Experience',isEqualTo: jopExperience);
    }
    //jop title
    else if (jopTitle!=null&&jopLocation!=null){
      query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation);
    }
    else if (jopTitle!=null&&jopLocation!=null&&jopType!=null){
      query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType);
    }
    else if (jopTitle!=null&&jopLocation!=null&&jopType!=null&&jopSalary!=null){
      query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary);
    }
    else if (jopTitle!=null&&jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null){
      query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
    }
    else if (jopTitle!=null&&jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null&&jopExperience!=null){
      query = query.where('title',isEqualTo: jopTitle).where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField).where('Experience',isEqualTo: jopExperience);
    }
    //jop Location
    else if ( jopLocation!=null&&jopType!=null){
      query = query.where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType);
    }
    else if (jopLocation!=null&&jopType!=null&&jopSalary!=null){
      query = query.where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary);
    }
    else if (jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null){
      query = query.where('location',isEqualTo: jopLocation).where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
    }
    else if (jopLocation!=null&&jopType!=null&&jopSalary!=null&&jopField!=null&&jopExperience!=null) {
      query = query.where('location', isEqualTo: jopLocation).where(
          'jopType', isEqualTo: jopType)
          .where('Salary',isLessThanOrEqualTo: jopSalary)
          .where('jopField', isEqualTo: jopField)
          .where('Experience', isEqualTo: jopExperience);
    }
    // jopType
    else  if (jopType!=null&&jopSalary!=null){
      query = query.where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary);
    }
    else  if (jopType!=null&&jopSalary!=null&&jopField!=null){
      query = query.where('jopType',isEqualTo: jopType).where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
    }
    else if (jopType!=null&&jopSalary!=null&&jopField!=null&&jopExperience!=null) {
      query = query.where('jopType', isEqualTo: jopType)
          .where('Salary',isLessThanOrEqualTo: jopSalary)
          .where('jopField', isEqualTo: jopField)
          .where('Experience', isEqualTo: jopExperience);
    }
    //jop Salary
    else if (jopSalary!=null&&jopField!=null){
      query = query.where('Salary',isLessThanOrEqualTo: jopSalary).where('jopField',isEqualTo: jopField);
    }
    else if (jopSalary!=null&&jopField!=null&&jopExperience!=null) {
      query = query.where('Salary',isLessThanOrEqualTo: jopSalary)
          .where('jopField', isEqualTo: jopField)
          .where('Experience', isEqualTo: jopExperience);
    }
    //jop Field
    else  if (jopField!=null&&jopExperience!=null) {
      query = query.where('jopField', isEqualTo: jopField)
          .where('Experience', isEqualTo: jopExperience);
    }
    //jop Experience
    else if (jopExperience!=null) {
      query = query.where('Experience', isEqualTo: jopExperience);
    }

    query.get().then((value) {
      jops.clear();
      value.docs.forEach((element) {
        jops.add(JopsModel.fromJson(element.data(), element.id));
      });
      emit(SearchJopFilterSuccessState());
    }).catchError((error) {
      emit(SearchJopFilterErrorState());
    });



    // await FirebaseFirestore.instance
    //     .collection('jops')
    //     .where('title',isEqualTo: jopTitle)
    //     .where('location',isEqualTo: jopLocation)
    //     .where('jopType',isEqualTo: jopType)
    //     .where('Salary',isEqualTo: jopSalary)
    //     .where('jopField',isEqualTo: jopField)
    //     .where('Experience',isEqualTo: jopExperience)
    //     .get()
    //     .then((value) {
    //       jops.clear();
    //   value.docs.forEach((element) {
    //     print (element.data());
    //     jops.add(JopsModel.fromJson(element.data(), element.id));
    //   });
    //   emit(SearchJopFilterSuccessState());
    // }).catchError((error) {
    //   emit(SearchJopFilterErrorState());
    // });
  }





}
