import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _AddMedicinePageState extends State<AddMedicinePage> {

  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc(user).collection("AddMedicine");

  final dateController = TextEditingController();
  final medicineController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: GeneralAppBar(
          islead: false,
          bottom: true,
          title: "Batch",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height(context) - 135,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [
                    Text(
                      "Add Medicine",
                      style: bodyText22w600(color: black),
                    ),
                    addVerticalSpace(20),
                    CustomTextField(
                      hintText: "Date",
                      suffix: true,
                      controller: dateController,
                    ),
                    CustomTextField(hintText: "Medicine",controller: medicineController,),
                    CustomTextField(hintText: "Description",controller: descriptionController,)
                  ]),
                ),
              ]),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomButton(
                    text: "Save",
                    onClick: () async{
                      await ({
                        fireStore.doc(user).set({
                          'Date': dateController.text.toString(),
                          'Medicine':medicineController.text.toString(),
                          'Description':descriptionController.text.toString(),
                        }),});
                    },
                    width: width(context),
                    height: 55),
              )
            ],
          ),
        ),
      ),
    );
  }
}
