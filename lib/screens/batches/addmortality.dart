import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

class AddMortalityPage extends StatefulWidget {
  const AddMortalityPage({super.key});

  @override
  State<AddMortalityPage> createState() => _AddMortalityPageState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _AddMortalityPageState extends State<AddMortalityPage> {

  final _formKey = GlobalKey<FormState>();


  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc(user).collection("AddMortality");

  final dateController = TextEditingController();
  final mortalityController = TextEditingController();
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
      body: Column(
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(20),
                      Center(
                        child: Text(
                          "Add Mortality",
                          style: bodyText22w600(color: black),
                        ),
                      ),
                      addVerticalSpace(20),
                      CustomTextField(
                        hintText: "Date",
                        suffix: true,
                        controller: dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Date';
                            }
                            return null;
                          }
                      ),
                      CustomTextField(hintText: "Mortality",controller: mortalityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Mortality';
                            }
                            return null;
                          }),
                      CustomTextField(hintText: "Description",controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Description';
                            }
                            return null;
                          }
                      )
                    ]),
              ),
            ),
          ]),
          // addVerticalSpace(height(context) * .22),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CustomButton(
                text: "Add", onClick: () async{
              if (_formKey.currentState!.validate()) {

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              await ({
                fireStore.doc(user).set({
                  'Date': dateController.text.toString(),
                  'Mortality':mortalityController.text.toString(),
                  'Description':descriptionController.text.toString(),
                }),});
            }}, width: width(context), height: 55),
          )
        ],
      ),
    );
  }
}
