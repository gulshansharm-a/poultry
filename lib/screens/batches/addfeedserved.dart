import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customdropdown.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

class AddFeedServedPage extends StatefulWidget {
  const AddFeedServedPage({super.key});

  @override
  State<AddFeedServedPage> createState() => _AddFeedServedPageState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _AddFeedServedPageState extends State<AddFeedServedPage> {

  final _formKey = GlobalKey<FormState>();


  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc(user).collection("AddFeedServed");

  final dateController = TextEditingController();
  final feedTypeController = TextEditingController();
  final totalFeedController = TextEditingController();

  List list = ["lorem", "lorem", "lorem", "lorem"];

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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "Add Feed Served",
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
                        CustomDropdown(
                          list: list,
                          height: 58,
                          hint: "Feed Type",


                        ),
                        CustomTextField(hintText: "Total Feed given in Kg",
                          controller: totalFeedController,
                          textType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Total Feed';
                              }
                              return null;
                            })
                      ]),
                ),
              ),
            ]),
            addVerticalSpace(height(context) * .39),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: CustomButton(
                  text: "Add",
                  onClick: () async{

                    if (_formKey.currentState!.validate()) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                    await ({
                      fireStore.doc(user).set({
                        'Date': dateController.text.toString(),
                        'FeedType':feedTypeController.text.toString(),
                        'TotalFeed':totalFeedController.text.toString(),

                      }),});
                  }},
                  width: width(context),
                  height: 55),
            )
          ],
        ),
      ),
    );
  }
}
