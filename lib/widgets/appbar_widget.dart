import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/colors.dart';

AppBar buildAppBar(BuildContext context, String title) {



  return AppBar(
    leading: BackButton(),
    title: Text(title,  style: TextStyle(color: Colors.black, fontSize: 16.0)),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(
      color: AppColors.colorPrimary, //change your color here
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
