import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/screens/farmsettings/addincomecat.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/floatbutton.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

import '../batches/addeggs.dart';

int length = 0;
List<String> incomeCategoryList = [];

class IncomeCategoryPage extends StatelessWidget {
  const IncomeCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    fetchLength();
    fetchData();
    return Scaffold(
      floatingActionButton: FloatedButton(onTap: () {
        NextScreen(context, AddIncomeCategory());
      }),
      appBar: PreferredSize(
        child: GeneralAppBar(
          islead: false,
          bottom: true,
          title: "Income Category",
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(15),
            Divider(
              height: 0,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0,
                  );
                },
                itemBuilder: (context, index) {
                  print(incomeCategoryList);
                  return ListTile(
                    title: Text(
                      incomeCategoryList[index],
                      style: bodyText17w500(color: black),
                    ),
                  );
                }),
            const Divider(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
void fetchLength() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore.collection('users').doc(user).collection("Income Category").get();
  querySnapshot.docs.forEach((doc) {
    //   print("int "+doc.get("date").toString());
    // });
    //print("length "+querySnapshot.size.toString());
    length = querySnapshot.size;
  });
}
void fetchData() async {
  incomeCategoryList.clear();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore.collection('users').doc(
      user).collection("Income Category").get();
  for (var doc in querySnapshot.docs) {
    //print("int " + doc.get("BatchName").toString());
    incomeCategoryList.add(doc.get("IncomeCategory").toString());
  }
  print(incomeCategoryList);
}


