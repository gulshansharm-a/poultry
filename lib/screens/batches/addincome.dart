import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/screens/farmsettings/addincomecat.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/customdropdown.dart';
import 'package:poultry_app/widgets/customtextfield.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/navigation.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}
var user = FirebaseAuth.instance.currentUser?.uid;
class _AddIncomePageState extends State<AddIncomePage> {

  final _formKey = GlobalKey<FormState>();

  final fireStore = FirebaseFirestore.instance.collection('users').doc(user).collection("Batches").doc().collection("AddIncome");

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final incomeCategoryController = TextEditingController();
  final QuantityController = TextEditingController();
  final WeightController = TextEditingController();
  final RateController = TextEditingController();
  final BillAmountController = TextEditingController();
  final PaymentMethodController = TextEditingController();
  final AmountPaidController = TextEditingController();
  final AmountDueController = TextEditingController();
  final DescriptionController = TextEditingController();


  List list = ["lorem", "lorem", "lorem", "lorem"];
  List paymentList = ['Cash', 'Online', 'Unpaid'];
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  int selectedIndex = 0;
  String? method;
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(10),
                      Center(
                        child: Text(
                          "Add Income",
                          style: bodyText22w600(color: black),
                        ),
                      ),
                      addVerticalSpace(15),
                      CustomTextField(hintText: "Name",controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          }),
                      CustomTextField(hintText: "Contact",controller: contactController,textType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Contact';
                            }
                            return null;
                          }),
                      Row(
                        children: [
                          Expanded(
                              child: CustomDropdown(
                                  list: list,
                                  height: 58,
                                  hint: "Income Category")),
                          addHorizontalySpace(15),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => AddIncomeCategory()));
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
                      Row(
                        children: [
                          Expanded(child: CustomTextField(hintText: "Quantity",controller: QuantityController,textType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Quantity';
                                }
                                return null;
                              })),
                          addHorizontalySpace(10),
                          Expanded(child: CustomTextField(hintText: "Weight",controller: WeightController,textType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Weight';
                                }
                                return null;
                              })),
                          addHorizontalySpace(10),
                          Expanded(child: CustomTextField(hintText: "Rate",controller: RateController,textType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rate';
                                }
                                return null;
                              })),
                        ],
                      ),
                      CustomTextField(hintText: "Bill Amount",controller: BillAmountController,textType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bill Amount';
                            }
                            return null;
                          }),
                      addVerticalSpace(5),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Payment Method:",
                          style: bodyText15w500(color: black),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                            itemCount: paymentList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return InkWell(
                                onTap: () {
                                  selectedIndex = i;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 25.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        selectedIndex == i
                                            ? Icons.radio_button_checked_outlined
                                            : Icons.radio_button_off_outlined,
                                        color: selectedIndex == i
                                            ? yellow
                                            : Colors.grey,
                                      ),
                                      addHorizontalySpace(6),
                                      Text(
                                        paymentList[i],
                                        style: bodyText15normal(
                                            color: black.withOpacity(0.6)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      CustomTextField(hintText: "Amount Paid",controller: AmountPaidController,textType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Amount Paid';
                            }
                            return null;
                          }),
                      CustomTextField(hintText: "Amount Due",controller: AmountDueController,textType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Amount Due';
                            }
                            return null;
                          }),
                      CustomTextField(hintText: "Description",controller: DescriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description';
                            }
                            return null;
                          }),
                      CustomButton(
                          text: "Cash In",
                          onClick: () async{

                            if (_formKey.currentState!.validate()) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );

                            await ({
                              fireStore.doc().set({
                                'name': nameController.text.toString(),
                                'Contact':contactController.text.toString(),
                                'IncomeCategory':incomeCategoryController.text.toString(),
                                'Quantity':QuantityController.text.toString(),
                                'Weight':WeightController.text.toString(),
                                'BillAmount':BillAmountController.text.toString(),
                                'PaymentMethod':PaymentMethodController.text.toString(),
                                'AmountPaid':AmountPaidController.text.toString(),
                                'AmountDue':AmountDueController.text.toString(),
                                'Description':DescriptionController.text.toString(),
                              }),});
                            Navigator.pop(context);
                          }},
                          width: width(context),
                          height: 55)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
