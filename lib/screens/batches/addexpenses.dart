import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/screens/farmsettings/addexpensescat.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customdropdown.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

class AddExpensesPage extends StatefulWidget {
  const AddExpensesPage({super.key});

  @override
  State<AddExpensesPage> createState() => _AddExpensesPageState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _AddExpensesPageState extends State<AddExpensesPage> {

  final _formKey = GlobalKey<FormState>();


  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc(user).collection("AddExpenses");

  final dateController = TextEditingController();
  final expensesCategoryController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();


  List list = ["lorem", "lorem", "lorem", "lorem"];
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
          height: height(context) * 0.9,
          child: Column(
            children: [
              addVerticalSpace(15),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key:_formKey ,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Add Expenses",
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
                          Row(
                            children: [
                              Expanded(
                                  child: CustomDropdown(
                                      list: list,
                                      height: 58,
                                      hint: "Expenses Category",
                                  )),
                              addHorizontalySpace(15),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              AddExpensesCategory()));
                                },
                                child: Container(
                                  height: 58,
                                  width: 58,
                                  decoration: shadowDecoration(10, 0, yellow),
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    color: white,
                                  )),
                                ),
                              )
                            ],
                          ),
                          CustomTextField(hintText: "Amount",
                          controller: amountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Amount';
                                }
                                return null;
                              }),
                          CustomTextField(hintText: "Description",
                          controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Description';
                                }
                                return null;
                              }),
                        ]),
                  ),
                ),
              ]),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomButton(
                    text: "Cash Out",
                    onClick: () async{

                      if (_formKey.currentState!.validate()) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                      await
                        fireStore.doc(user).set({
                          'Date': dateController.text.toString(),
                          'Expenses Category':expensesCategoryController.text.toString(),
                          'Amount':amountController.text.toString(),
                          'Description':descriptionController.text.toString(),
                        });
                      Navigator.pop(context);
                    }},
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
