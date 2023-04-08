import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customtextfield.dart';

import '../../utils/constants.dart';
import '../../widgets/generalappbar.dart';

var user = FirebaseAuth.instance.currentUser?.uid;
class AddNotesPage extends StatelessWidget {
   AddNotesPage({super.key});

  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc(user).collection("AddNotes");

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: GeneralAppBar(
          islead: false,
          title: 'Batch',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Add Notes",
                style: bodyText22w600(color: black),
              ),
            ),
            addVerticalSpace(15),
            CustomTextField(
              hintText: 'Title',
              controller: titleController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: descriptionController,
                cursorColor: black,
                maxLines: 10,
                style: bodyText15normal(color: black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(232, 236, 244, 1),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: normalGray),
                        borderRadius: BorderRadius.circular(8.5)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: normalGray),
                        borderRadius: BorderRadius.circular(8.5)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: red),
                        borderRadius: BorderRadius.circular(8.5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: normalGray),
                        borderRadius: BorderRadius.circular(8.5)),
                    hintText: 'Description',
                    hintStyle: bodyText16normal(color: darkGray)),
              ),
            ),
            Spacer(),
            CustomButton(text: 'Add', onClick: () async{
              await ({
                fireStore.doc(user).set({
                  'Title': titleController.text.toString(),
                  'Description':descriptionController.text.toString(),
                }),});
            })
          ],
        ),
      ),
    );
  }
}
