import 'package:flutter/material.dart';
import 'package:poultry_app/screens/mainscreens/aboutus.dart';
import 'package:poultry_app/screens/mainscreens/networkerror.dart';
import 'package:poultry_app/screens/mainscreens/subscription.dart';
import 'package:poultry_app/screens/mainscreens/termscondition.dart';
import 'package:poultry_app/screens/profile/createprofile.dart';
import 'package:poultry_app/utils/constants.dart';
import 'package:poultry_app/widgets/custombutton.dart';
import 'package:poultry_app/widgets/navigation.dart';

class GeneralAppBar extends StatelessWidget {
  final String? title;
  final bool? islead;
  final String? text;
  final bool? bottom;
  final bool? isNav;

  const GeneralAppBar(
      {super.key, this.text, this.title, this.islead, this.bottom, this.isNav});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparent,
      foregroundColor: black,
      // automaticallyImplyLeading: islead ?? true,
      elevation: 0,
      title: Text(
        title ?? '',
        style: bodyText18w500(color: black),
      ),
      // bottom: bottom == true
      //     ? PreferredSize(
      //         child: Row(children: [
      //           IconButton(
      //               onPressed: () {
      //                 goBack(context);
      //               },
      //               icon: Icon(Icons.arrow_back)),
      //           Text(
      //             text ?? "",
      //             style: bodyText18w500(color: black),
      //           )
      //         ]),
      //         preferredSize: Size.fromHeight(20),
      //       )
      //     : null,
      actions: [
        PopupMenuButton(
          offset: Offset(0.0, 50),
          padding: EdgeInsets.zero,
          iconSize: 25,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          itemBuilder: (context) => [
            PopupMenuItem(
                height: 40,
                value: 1,
                child: Text(
                  "About Us",
                  style: bodyText14normal(color: black),
                )),
            PopupMenuItem(
                height: 40,
                value: 2,
                child: Text(
                  "Terms & Conditions",
                  style: bodyText14normal(color: black),
                )),
            PopupMenuItem(
                height: 40,
                value: 3,
                child: Text(
                  "Subscription",
                  style: bodyText14normal(color: black),
                )),
            PopupMenuItem(
                height: 40,
                value: 4,
                child: Text(
                  "Profile",
                  style: bodyText14normal(color: black),
                )),
            PopupMenuItem(
                height: 40,
                value: 5,
                child: Text(
                  "Logout",
                  style: bodyText12normal(color: black),
                )),
          ],
          onSelected: (value) {
            switch (value) {
              case 1:
                NextScreen(context, AboutUsPage());
                break;
              case 2:
                NextScreen(context, TermsandConditions());
                break;
              case 3:
                NextScreen(context, SubscriptionPage());
                break;
              case 4:
                NextScreen(context, CreateProfilePage());
                ;
                break;
              case 5:
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => logoutDialog(context));
            }
          },
        ),
      ],
    );
  }

  logoutDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        height: 286,
        width: width(context) * .95,
        child: Column(
          children: [
            Image.asset("assets/images/logout.png"),
            addVerticalSpace(35),
            Text(
              "Are you sure you want to logout?",
              style: bodyText15w500(color: black),
            ),
            addVerticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    buttonColor: white,
                    text: "Cancel",
                    textStyle: bodyText16Bold(color: darkGray),
                    onClick: () {
                      goBack(context);
                    },
                    radius: 8.42,
                    width: width(context) * .32,
                    height: 40),
                CustomButton(
                    text: "Logout",
                    textStyle: bodyText16Bold(color: white),
                    onClick: () {
                      NextScreen(context, NetworkErrorPage());
                    },
                    radius: 8.42,
                    width: width(context) * .32,
                    height: 40),
              ],
            )
          ],
        ),
      ),
    );
  }
}
