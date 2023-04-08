import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/generalappbar.dart';
import 'package:poultry_app/widgets/userdatawidget.dart';

import '../../utils/constants.dart';
import '../../widgets/customdropdown.dart';
import '../../widgets/customtextfield.dart';
import '../../widgets/navigation.dart';
import '../batches/addeggs.dart';
import '../profile/editprofile.dart';

List list = ["Broiler", "Deshi", "Layer", "Breeder Farm"];
String name = " ";
String email = " ";
String farmName = " ";
String country = " ";
String state = " ";
String city = " ";
String Village = " ";
String farmCapacity = " ";



class UserInformationPage extends StatelessWidget {
  const UserInformationPage({super.key});


  @override
  Widget build(BuildContext context) {
    fetchData();
    print(name);
    return Scaffold(
      appBar: PreferredSize(
        child: GeneralAppBar(
          islead: false,
          bottom: true,
          title: "User Information",
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Column(
              children: [
              addVerticalSpace(10),
          Container(
            height: 80,
            width: 85,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: white,
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: GestureDetector(
                        onTap: () {
                          NextScreen(context, EditProfilePage());
                        },
                        child: CircleAvatar(
                            backgroundColor: yellow,
                            radius: 14,
                            child: Icon(
                              Icons.edit,
                              size: 17,
                              color: white,
                            )),
                      ),
                    ))
              ],
            ),
          ),
          addVerticalSpace(10),
          CustomTextField(hintText: name,enabled: false,),
          CustomTextField(hintText: email),
          CustomTextField(hintText: farmName),
          Row(
            children: [
              Expanded(child: CustomTextField(hintText: country)),
              addHorizontalySpace(20),
              Expanded(child: CustomTextField(hintText: state)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    hintText: city,
                  )),
              addHorizontalySpace(20),
              Expanded(
                  child: CustomTextField(
                    hintText: "Village",
                  )),
            ],
          ),
          CustomTextField(hintText: farmCapacity),
          CustomDropdown(list: list, height: 58, hint: "Farm")
          ],
        ),
              CustomButton(text: "Save", onClick: () {})
            ],
          ),
        ),
      ),
    );
  }
}

void fetchData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore.collection('users').doc(user).get();
  // List<QueryDocumentSnapshot> docs = querySnapshot.('BVd0YvbKBfacEmMJIzrD');

  //print("int "+querySnapshot.get("date").toString());
  name = querySnapshot.get("name").toString();
  email = querySnapshot.get("email").toString();
  farmName = querySnapshot.get("FarmName").toString();
  country = querySnapshot.get("Country").toString();
  state = querySnapshot.get("State").toString();
  city = querySnapshot.get("City").toString();
  farmCapacity = querySnapshot.get("Farm Capacity").toString();
}
