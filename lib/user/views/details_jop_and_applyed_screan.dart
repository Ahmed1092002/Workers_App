import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled10/SharedWidget/custoButton.dart';
import 'package:untitled10/user/views/main_screan.dart';
import 'package:untitled10/utils/navigator.dart';

import '../../company/blocs/JopCubit/jop_cubit.dart';
import '../../data/company/jop_model.dart';
import '../../src/app_root.dart';

class DetailsJopAndApplyedScrean extends StatefulWidget {
  JopsModel? jops;
  bool? isSaved = false;

  DetailsJopAndApplyedScrean({Key? key, this.jops, this.isSaved}) : super(key: key);

  @override
  State<DetailsJopAndApplyedScrean> createState() => _DetailsJopAndApplyedScreanState();
}

class _DetailsJopAndApplyedScreanState extends State<DetailsJopAndApplyedScrean> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JopCubit(),
      child: BlocConsumer<JopCubit, JopState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is ApplyingJopSuccessState) {
            navigateToScreen(context, MainScrean());
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You Applyed This Jop'),
                  backgroundColor: greenColor,
                ));
          }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Details Jop'),
              centerTitle: true,
              backgroundColor: backgroundColor,
              titleTextStyle: TextStyle(
                color: greenColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: greenColor, //change your color here
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSelected = !isSelected;
                      setState(() {
                        widget.isSaved = isSelected;
                      });
                      if (isSelected == true) {
                        JopCubit.get(context).saveJop(jop: widget.jops!);
                      } else {
                        JopCubit.get(context).unSaveJop(jopid: widget.jops!.jopid!);
                      }
                    });
                  },
                  icon: Icon(widget.isSaved! ? Ionicons.bookmark :

                  isSelected ? Ionicons.bookmark : Ionicons.bookmark_outline, color: greenColor,),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                      width: 300,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greenColor,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,

                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: greenColor,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.jops!.companyImageUrl!,
                              placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
                                color: greenColor,
                                size: 100,
                              ),
                              imageBuilder: (context, imageProvider) => Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),

                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(widget.jops!.title!.toUpperCase(), style: TextStyle(

                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text(widget.jops!.companyname!, style: TextStyle(
                                color: greenColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                              Divider(
                                endIndent: 10,
                                indent: 10,
                              ),
                              Text("${widget.jops!.location}-${widget.jops!.country!}",
                                style: TextStyle(
                                  color: grayColor.withOpacity(0.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text('${widget.jops!.Salary}/ Month', style: TextStyle(
                                color: greenColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                              Wrap(
                                runSpacing: 5,
                                spacing: 5,
                                children: [
                                  Container(

                                    height: 30,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greenColor,
                                        width: 2,
                                      ),
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(widget.jops!.jopType!),
                                  ),
                                  Container(

                                    height: 30,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greenColor,
                                        width: 2,
                                      ),
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(widget.jops!.jobShift!),
                                  ),
                                  Container(

                                    height: 30,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greenColor,
                                        width: 2,
                                      ),
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(widget.jops!.Experience!),
                                  ),
                                  Container(

                                    height: 30,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greenColor,
                                        width: 2,
                                      ),
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(widget.jops!.jobLevel!),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),


                            ],
                          ),

                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Company Infomation', style: TextStyle(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(3),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${widget.jops!.companyInfo}'),

                          ),
                          Text('Jop Field ', style: TextStyle(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(3),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${widget.jops!.jopField}'),

                          ),


                          Text('Description', style: TextStyle(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(3),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greenColor,
                                  width: 2,
                                )
                            ),
                            child: Text('${widget.jops!.description}'),

                          ),
                          Text('Skills', style: TextStyle(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                          Wrap(
                            runSpacing: 5,
                            spacing: 5,
                            children: widget.jops!.Skills!.map((e) =>
                                Container(
                                  height: 30,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: greenColor,
                                      width: 2,
                                    ),
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(e),
                                )).toList(),
                          ),
                        ],
                      ),
                    ),
                    Divider(),


                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        buttonName: 'Applyed',
                        onPressed: () {
                          JopCubit.get(context).applyingjop(jop: widget.jops!,
                            companyUid: widget.jops!.companyUid!,
                            isApplyed: ( isApplyed) {
                              if(isApplyed==false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                  content: Text('You Applyed This Jop'),
                                  backgroundColor: greenColor,
                                ));

                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('You Already Applyed This Jop'),
                                      backgroundColor: Colors.red,
                                    ));
                              }



                            }

                          );
                        },
                      ),
                    )


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
