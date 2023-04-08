import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

class AddEggsPage extends StatefulWidget {
  const AddEggsPage({super.key});

  @override
  State<AddEggsPage> createState() => _AddEggsPageState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _AddEggsPageState extends State<AddEggsPage> {

  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc(user).collection("AddEggs");

  final dateController = TextEditingController();
  final eggTrayCollectionController = TextEditingController();
  final pulletEggsController = TextEditingController();
  final brokenController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: GeneralAppBar(
          islead: false,
          bottom: true,
          title: "Batch",
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height(context) * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      addVerticalSpace(15),
                      Text(
                        "Add Eggs",
                        style: bodyText22w600(color: black),
                      ),
                      addVerticalSpace(20),
                      CustomTextField(
                        hintText: "Date",
                        suffix: true,
                        controller: dateController,
                      ),
                      CustomTextField(hintText: "Egg Tray Collection",controller: eggTrayCollectionController,textType: TextInputType.number,),
                      CustomTextField(hintText: "Pullet Eggs",controller: pulletEggsController,textType: TextInputType.number,),
                      CustomTextField(hintText: "Broken",controller: brokenController,textType: TextInputType.number,),
                      CustomTextField(hintText: "Description",controller: descriptionController,)
                    ]),
                  ),
                ],
              ),
              addVerticalSpace(height(context) * 0.16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomButton(
                    text: "Save",
                    onClick: () async{
                      await ({
                        fireStore.doc(user).set({
                          'Date': dateController.text.toString(),
                          'EggTrayCollection':eggTrayCollectionController.text.toString(),
                          'PulletEggs':pulletEggsController.text.toString(),
                          'Broken':brokenController.text.toString(),
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
