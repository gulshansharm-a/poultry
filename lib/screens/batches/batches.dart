import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/screens/batches/batchrecord.dart';
import 'package:poultry_app/screens/batches/newbatch.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/floatbutton.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../DataBase/batch_model.dart';



class BatchPage extends StatefulWidget {
  const BatchPage({super.key});



  @override
  State<BatchPage> createState() => _BatchPageState();
}



String Bname = " ";
int Length = 0;
List<String> BatchName = [];

class _BatchPageState extends State<BatchPage> with TickerProviderStateMixin {
  int index = 0;
  final FFInstance = FirebaseFirestore.instance;


  // Future<BatchModel> getUserDetails (String batchName) async {
  //   final snapshot = await FFInstance.collection('users').doc(user).collection("Batches")
  //       .doc("BVd0YvbKBfacEmMJIzrD")
  //       .get();
  //
  //   snapshot.data()!.map((key, value) =>{
  //   print("dsajf");
  //   }
  //   );
  //   return Bname;
  // }


// without loop fetching
  // void fetchData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final querySnapshot = await firestore.collection('users').doc(user.toString()).collection("Batches").doc("BVd0YvbKBfacEmMJIzrD").get();
  //   // List<QueryDocumentSnapshot> docs = querySnapshot.('BVd0YvbKBfacEmMJIzrD');
  //
  //   print("int "+querySnapshot.get("date").toString());
  // }

// length of data
// void fetchData() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final querySnapshot = await firestore.collection('users').doc(user.toString()).collection("Batches").get();
//   // querySnapshot.docs.forEach((doc) {
//   //   print("int "+doc.get("date").toString());
//   // });
//   print("length "+querySnapshot.size.toString());
//
//   }


    @override
    Widget build(BuildContext context) {
      final TabController _tabController = TabController(
          length: 2, vsync: this);


      fetchLength();
      print(BatchName.length);
      if(BatchName.length < Length) {
        fetchData();
      }
      print(BatchName);

      return Scaffold(
        floatingActionButton: FloatedButton(onTap: () {
          NextScreen(
              context,
              const NewBatch(
                title: 'New Batch',
              ));
        }),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: GeneralAppBar(
            islead: false,
            title: "Batches",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            buttonColor: index == 0 ? yellow : normalGray,
                            textStyle: bodyText16w600(
                                color: index == 0 ? white : darkGray),
                            text: "Active Batch",
                            onClick: () {
                              setState(() {
                                index = 0;
                              });
                            },
                            width: width(context) * .35,
                            height: 40)),
                    addHorizontalySpace(15),
                    Expanded(
                        child: CustomButton(
                            buttonColor: index == 1 ? yellow : normalGray,
                            text: "Closed Batch",
                            textStyle: bodyText16w600(
                                color: index == 1 ? white : darkGray),
                            onClick: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            width: width(context) * .35,
                            height: 40)),
                  ],
                ),
              ),


              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70),

                    child: Text(
                      "Total Batches: $Length",
                      textAlign: TextAlign.start,
                      style: bodyText18w400(color: darkGray),

                    ),
                  ),
                  addVerticalSpace(10),
                  Divider(),
                  ListView.separated(

                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Length,
                      itemBuilder: (context, index) {

                        return ListTile(

                          onTap: () {
                            NextScreen(context, BatchRecordPage());
                          },
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: yellow,
                            child: Image.asset("assets/images/henI.png"),
                          ),
                          title: Text(
                            BatchName[index],
                            style: bodyText16w500(color: black),
                          ),
                          subtitle: Text(
                            "6 Weeks : 5 Days",
                            style: bodyText12normal(color: darkGray),
                          ),
                        );
                      }),
                  Divider(),
                ],


              ),


            ],
          ),
        ),
      );
    }
  }


// fetch data with loop
void fetchData() async {
  BatchName.clear();
  print(BatchName);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore.collection('users').doc(
      user.toString()).collection("Batches").get();
  querySnapshot.docs.forEach((doc) {
    //print("int " + doc.get("BatchName").toString());
    Bname = doc.get("BatchName").toString();
    BatchName.add(Bname);

  });
  print(Bname);
  }



// length of data
void fetchLength() async {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore.collection('users').doc(user.toString()).collection("Batches").get();
   querySnapshot.docs.forEach((doc) {
    //   print("int "+doc.get("date").toString());
    // });
    //print("length "+querySnapshot.size.toString());
    Length = querySnapshot.size;


   });

      }

