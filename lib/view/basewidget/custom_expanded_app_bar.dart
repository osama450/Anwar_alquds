import 'package:Anwar/provider/auth_provider.dart';
import 'package:Anwar/provider/splash_provider.dart';
import 'package:Anwar/provider/theme_provider.dart';
import 'package:Anwar/utill/color_resources.dart';
import 'package:Anwar/utill/custom_themes.dart';
import 'package:Anwar/utill/dimensions.dart';
import 'package:Anwar/utill/images.dart';
import 'package:Anwar/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomExpandedAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget bottomChild;
  final bool isGuestCheck;
  CustomExpandedAppBar(
      {@required this.title,
      @required this.child,
      this.bottomChild,
      this.isGuestCheck = false});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    return Scaffold(
      floatingActionButton: isGuestCheck
          ? isGuestMode
              ? null
              : bottomChild
          : bottomChild,
      body: Stack(children: [
        // Background
        Image.asset(
          Images.more_page_header,
          height: 150,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Colors.black
              : Color(0xffD97224),
        ),

        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Row(children: [
            CupertinoNavigationBarBackButton(
                color: Colors.white,
                onPressed: () {
                  Provider.of<SplashProvider>(context, listen: false)
                      .setFromSetting(false);
                  Navigator.pop(context);
                }),
            Text(title,
                style: titilliumRegular.copyWith(
                    fontSize: 20, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: isGuestCheck
              ? isGuestMode
                  ? NotLoggedInWidget()
                  : child
              : child,
        ),
      ]),
    );
  }
}