
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/data/company/jop_model.dart';
import 'package:untitled10/data/users/education.dart';
import 'package:untitled10/data/users/projects.dart';
import 'package:untitled10/data/users/skills.dart';
import 'package:untitled10/data/users/work_experience.dart';
import 'package:untitled10/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../utils/dio_helper.dart';

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
    required String jopSalary,
    required String jopLocation,
    required  String jobLevel,
    required String jobShift,
    required  List<String> jopSkills,
    required String jopExperience,
    required String jopType,
required String JopField,
    String? jopid,
   }) async {
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    jop = JopsModel(
      companyUid: uid,
       date: now.toString(),
      description: jopDescription,
      companyInfo: await box.get('info'),
      Experience: jopExperience,
      location: jopLocation,
      jopType: jopType,
      Salary: jopSalary,
      country: await box.get('country'),



      Skills: jopSkills,
      companyImageUrl: await box.get('image'),

      jobLevel:jobLevel ,
      jobShift: jobShift,
      title: jopTitle,
      workingField: box.get('workingField'),
      jopField: JopField,
      jopid: jopid,
      userEmail: box.get('email'),
      companyname: box.get('name')




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
    required String jopSalary,
    required String jopLocation,
    required List<String> jopSkills,
    required String jopExperience,
    required String jopType,
    required String JopField,
    required String jobLevel,
    required String jobShift,

   }) async {
    String? uid = await storage.read(key: 'uid');
    String userType = await box.get('userType').toString();
    jop = JopsModel(
      companyUid: uid,
      date: now.toString(),
      jopType: jopType,
      description: jopDescription,
      Experience: jopExperience,


      location: jopLocation,
      jopField: JopField,
      Salary: jopSalary,
      jobLevel: jobLevel,
      jobShift:jobShift ,
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
              JopField: JopField,
              jopDescription: jopDescription,
              jopSalary: jopSalary,

              jopLocation: jopLocation,
              jopSkills: jopSkills,
              jobLevel: jobLevel,
              jobShift: jobShift,
              jopExperience: jopExperience,
              jopType: jopType,
              jopid: value.id,

              );


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
      required String jopSalary,
      required String jopLocation,
      required String jopExperience,
      required List <String> jopSkills,
      required String jopid,
      required String jopShift,
      required String jopType,
      required String JopField,
      required String jobLevel,



    })async{
      String? uid = await storage.read(key: 'uid');
      String userType = await box.get('userType').toString();
      jop = JopsModel(
          companyUid: uid,
          date: now.toString(),
          jopType: jopType,
          description: jopDescription,
          Experience: jopExperience,
          jobShift: jopShift,
          companyImageUrl: await box.get('image'),
          companyname: box.get('name') ,
          country: await box.get('country'),
          jopid: jopid,
          jobLevel:jobLevel ,
          location: jopLocation,
          jopField: JopField,
          Salary: jopSalary,
          Skills: jopSkills,
          title: jopTitle,
          workingField: box.get('workingField'),
          companyInfo: await box.get('info'),
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
    GetAlNewlJops ({Function(bool)? isSaved})async{
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      String? uid = await storage.read(key: 'uid');
      emit(GetAllJopsLoadingState());
      await FirebaseFirestore.instance
          .collection('jops')
          // .where('date', isGreaterThanOrEqualTo: startOfWeek.toString())
          // .where('date', isLessThanOrEqualTo: endOfWeek.toString())
          .get()
          .then((value) {
        jops.clear();
        value.docs.forEach((element) {
          print (element.data());
          jops.add(JopsModel.fromJson(element.data(), element.id));
        });
        emit(GetAllJopsSuccessState());
      }).catchError((error) {
        emit(GetAllJopsErrorState());
      });
      for (JopsModel jop in jops){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedJops')
            .doc(jop.jopid)
            .get()
            .then((value) {
          if (value.exists) {
            isSaved!(true);
          }
          else{
            isSaved!(false);
          }
        });
      }


    }
    List<JopsModel> workingFieldJobs = [];
    getJobOfWorkingField({Function(bool)? isSaved})async{
      String? workingField = await box.get('workingField');
      String? uid = await storage.read(key: 'uid');

      emit(GetAllWorkingFieldJopsLoadingState());
      await FirebaseFirestore.instance
          .collection('jops')
          .where('workingField',isEqualTo: workingField)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print (element.data());
          workingFieldJobs.add(JopsModel.fromJson(element.data(), element.id));
        });
        emit(GetAllWorkingFieldJopsSuccessState());
      }).catchError((error) {
        emit(GetAllWorkingFieldJopsErrorState());
      });
      for (JopsModel jop in workingFieldJobs){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedJops')
            .doc(jop.jopid)
            .get()
            .then((value) {
          if (value.exists) {
            isSaved!(true);
          }
          else{
            isSaved!(false);
          }
        });
      }

    }
    List<JopsModel> jobsFields = [];
  getJobOfMyJobField({Function(bool)? isSaved})async{
    String? jobField = await box.get('jobField');
    String? uid = await storage.read(key: 'uid');
    emit(GetAllJobFieldJopsLoadingState());
    await FirebaseFirestore.instance
        .collection('jops')
        .where('jobField',isEqualTo: jobField)
        .get()
        .then((value) {
      jobsFields.clear();
      value.docs.forEach((element) {
        print (element.data());
        jobsFields.add(JopsModel.fromJson(element.data(), element.id));
      });
      emit(GetAllJobFieldJopsSuccessState());
    }).catchError((error) {
      emit(GetAllJobFieldJopsErrorState());
    });
    for (JopsModel jop in jobsFields){
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('savedJops')
          .doc(jop.jopid)
          .get()
          .then((value) {
        if (value.exists) {
          isSaved!(true);
        }
        else{
          isSaved!(false);
        }
      });
    }

  }

  Future  applyingjop({

      required JopsModel jop,

      required String companyUid,
    Function(bool)? isApplyed

})
   async {


      String? userUid = await storage.read(key: 'uid');
      emit(ApplyingJopLoadingState());

      var userJobDoc = FirebaseFirestore.instance.collection('users').doc(userUid).collection('applyedJops').doc(jop.jopid);
      var companyJobDoc = FirebaseFirestore.instance.collection('users').doc(companyUid).collection('jops').doc(jop.jopid).collection('applyedUsers').doc(userUid);

      if ((await userJobDoc.get()).exists) {
        isApplyed!(true);
        emit(ApplyingJopErrorState());
      } else {
        await Future.wait([
          userJobDoc.set(jop.toJson()),
          companyJobDoc.set({'uid': userUid})
        ]);
        emit(ApplyingJopSuccessState());
      }



    }


    getAllApplyedJops({
    Function(bool)? isApplyed
})async{
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
          jops.add(JopsModel.fromJson(element.data() as Map <String, dynamic>, element.id));
print (element.data());
          jopids.add(element.id);
        });
        emit(GetAllApplyedJopsSuccessState());

        }).catchError((error) {
        emit(GetAllApplyedJopsErrorState());
      });
      // for(String jopid in jopids) {
      //   await FirebaseFirestore.instance
      //       .collection('jops')
      //       .doc(jopid)
      //       .get()
      //       .then((value) {
      //     print(value.data());
      //     jops.add(JopsModel.fromJson(value.data() as Map <String, dynamic>, value.id));
      //
      //     emit(GetAllApplyedJopsSuccessState());
      //   }).catchError(
      //         (error) {
      //       emit(GetAllApplyedJopsErrorState());
      //     },
      //   );
      //   // for (int i = 0; i <jops.length;i++){
      //   //  print (jops[i].);
      //   //
      //   // }
      // }




          }

List<UserModel> applyedUsers = [];


    getApplyedUsers({required String jopid,Function(bool)? isApplyed,Function(bool)? isWatch,})async{
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
      if (element.data()['isAccepted'] == true) {
        isApplyed!(true);
      }
      if (element.data()['isWatched'] == true) {
        isApplyed!(true);
      }


          users.add(element.id);
        });
        emit(GetApplyedUsersSuccessState());

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
    , String? jopSalary,
     String ?userType,
     String? jopField,
     String? jopExperience})async{
      emit(SearchJopFilterLoadingState());
      String? uid = await storage.read(key: 'uid');
      Query<Map<String, dynamic>> query;
      if(userType == 'company') {

      query = FirebaseFirestore.instance.collection('users').doc(uid).collection('jops');
      }
      else {
         query = FirebaseFirestore.instance
            .collection('jops');
      }

      Map<String, String?> conditions = {
        'title': jopTitle,
        'location': jopLocation,
        'jopType': jopType,
        'Salary': jopSalary,
        'jopField': jopField,
        'Experience': jopExperience
      };
      for (var condition in conditions.entries) {
        if (condition.value != null && condition.value!.isNotEmpty) {
          query = query.where(condition.key, isEqualTo: condition.value);
        }
      }
      query.get().then((value) async{
        jops.clear();
        value.docs.forEach((element)  {
          jops.add(JopsModel.fromJson(element.data(), element.id));
          print(element.data());
        });
        if (userType == 'users') {
          for (int i = 0; i < jops.length; i++) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('savedJops')
                .doc(jops[i].jopid)
                .get()
                .then((value) {
              if (value.exists) {
                jops[i].isSaved = true;

              } else {
                jops[i].isSaved = false;
              }
            });
          }
        }
        emit(SearchJopFilterSuccessState());
      }).catchError((error) {
        emit(SearchJopFilterErrorState());
      });



    }



  saveJop({required JopsModel jop})async{
    String? uid = await storage.read(key: 'uid');
    emit(SaveJopLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedJops')
        .doc(jop.jopid)
        .set(jop.toJson())
        .then((value) {

    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedJops')
        .doc(jop.jopid)
        .update({'isSaved': true}).then((value) {

      emit(SaveJopSuccessState());
    }).catchError((error) {
      emit(SaveJopErrorState());
    });

  }
  unSaveJop({required String jopid})async{
    String? uid = await storage.read(key: 'uid');
    emit(UnSaveJopLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedJops')
        .doc(jopid)
        .delete().then((value) {
      emit(UnSaveJopSuccessState());
    }).catchError((error) {
      emit(UnSaveJopErrorState());
    });


  }
  getSavedJops(Function(bool)? isSaved)async{
    String? uid = await storage.read(key: 'uid');
    emit(GetSavedJopsLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedJops')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print (element.data());
        jops.add(JopsModel.fromJson(element.data(), element.id));
        if (element.data()['isSaved'] == true) {
          isSaved!(true);
        }
      });
      emit(GetSavedJopsSuccessState());
    }).catchError((error) {
      emit(GetSavedJopsErrorState());
    });

  }
  acceptUser({required String jopid,required UserModel userUid})async {
    String? companyUid = await storage.read(key: 'uid');
    emit(AcceptUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(companyUid)
        .collection('jops')
        .doc(jopid)
        .collection('applyedUsers')
        .doc(userUid.id)
        .update({'isAccepted': true}).then((value) {
      emit(AcceptUserSuccessState());
    }).catchError((error) {
      emit(AcceptUserErrorState());
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid.id)
        .collection('applyedJops')
        .doc(jopid)
        .update({'isAccepted': true}).then((value) async {
          fcmToken(
              fcmTokenDevice: userUid.fcmToken,
              title: 'Jop Accepted',
              body: 'Your jop has been accepted',
              text: 'Jop Accepted',
          );
      emit(AcceptUserSuccessState());
    }).catchError((error) {
      emit(AcceptUserErrorState());
    });


  }
  rejectUser({required String jopid,required UserModel userUid})async {
    String? companyUid = await storage.read(key: 'uid');
    emit(RejectUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(companyUid)
        .collection('jops')
        .doc(jopid)
        .collection('applyedUsers')
        .doc(userUid.id)
        .update({'isAccepted': false}).then((value) {
      emit(RejectUserSuccessState());
    }).catchError((error) {
      emit(RejectUserErrorState());
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid.id)
        .collection('applyedJops')
        .doc(jopid)
        .update({'isAccepted': false}).then((value) {
          fcmToken(
              fcmTokenDevice: userUid.fcmToken,
              title: 'Jop Rejected',
              body: 'Your jop has been rejected',
              text: 'Jop Rejected',
          );
      emit(RejectUserSuccessState());
    }).catchError((error) {
      emit(RejectUserErrorState());
    });
  }

    fcmToken({
      String ?fcmTokenDevice,
      String ?title,
      String ?body,
      String ?text,

    })async{
      DioHelper.postData(
          url: 'fcm/send',
          data: {
            "to":"$fcmTokenDevice",

            "notification": {
              "title": title,
              "text": text,
              "body": body,
              "sound": "default",

              "color": "#990000"
            },
            "priority": "high",
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "type": "COMMENT"
            }

          }
      ).then((value) => print(value.data)).catchError((error) {
        print(error.toString());
      });
    }








  }




