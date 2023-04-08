import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customdropdown.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class NewBatch extends StatefulWidget {
  const NewBatch({super.key, required this.title});
  final String title;

  @override
  State<NewBatch> createState() => _NewBatchState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _NewBatchState extends State<NewBatch> {

  final _formKey = GlobalKey<FormState>();

  List breed = ["Broiler", "Deshi", "Layer", "Breeder Farm"];
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  final dateController = TextEditingController();
  final BatchNameController = TextEditingController();
  final BreedController = TextEditingController();
  final NoOfBirdsController = TextEditingController();
  final CostPerBirdController = TextEditingController();
  final SupplierController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection('Batches');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: GeneralAppBar(
          islead: true,
          bottom: true,
          title: widget.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height(context) - 135,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "Date",
                        suffix: true,
                        controller: dateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Date';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        hintText: "Batch Name",
                        controller: BatchNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Batch Name';
                          }
                          return null;
                        },),

                      CustomDropdown(
                        hint: "Breed",
                        height: 58,
                        list: breed,
                        dropdownColor: Color.fromRGBO(232, 236, 244, 1),
                      ),
                      CustomTextField(hintText: "Number of birds"
                      ,controller: NoOfBirdsController,
                        textType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Amount of Birds';
                          }
                          return null;
                        },),
                      CustomTextField(hintText: "Cost per bird",
                      controller: CostPerBirdController,
                          textType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Cost per Bird';
                          }
                          return null;
                        },),
                      CustomTextField(hintText: "Supplier",
                      controller: SupplierController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Supplier Name';
                          }
                          return null;
                        },),
                    ],
                  ),
                ),
                CustomButton(
                    text: "Submit",
                    onClick: () async {
                      if (_formKey.currentState!.validate()) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        await users.add({
                         fireStore.doc().set({
                        'date': dateController.text.toString(),
                        'BatchName':BatchNameController.text.toString(),
                        'Breed':BreedController.text.toString(),
                        'NoOfBirds':NoOfBirdsController.text.toString(),
                        'CostPerBird':CostPerBirdController.text.toString(),
                        'Supplier':SupplierController.text.toString(),
                        }),});
                        Navigator.pop(context);
                    }},
                    width: width(context),
                    height: 55)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
