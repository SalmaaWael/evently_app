import 'package:evently_app/core/widgets/custom_password_feild.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/assets_manager/assests_manager.dart';
import '../../../core/colors_manager.dart';
import '../../../core/routes_manager/routes_manager.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_text_form_feild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(

          children: [
            Image.asset(ImageAssets.eventlyLogo,height: 150.h),
            SizedBox(height: 16.h),
            CustomTextFormFeild(label: 'Email',prefixIcon: Icons.email_rounded,keyboardType: TextInputType.emailAddress,),
            CustomPasswordFormField(label: 'Password',keyboardType: TextInputType.visiblePassword),
            Container(
                alignment: Alignment.centerRight,
                child: CustomTextButton(title: "Forget Password", onPressed: (){},)),
            SizedBox(height: 8.h),
           CustomElevatedButton(title: "Login",),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Don't have an account?",
                    style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500,color: ColorsManager.balck)
                ),
                CustomTextButton(title: "Create Account",

                  onPressed: (){

                    Navigator.pushReplacementNamed(context, RoutesManager.register);
                  },),
              ],
            )

          ],
        ),
      ),
    );
  }
}
