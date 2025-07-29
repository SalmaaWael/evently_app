import 'package:evently_app/core/assets_manager/assests_manager.dart';
import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/routes_manager/routes_manager.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_password_feild.dart';
import '../../../core/widgets/custom_text_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Image.asset(ImageAssets.eventlyLogo, height:150.h)),
              SizedBox(height: 24.h),
              CustomTextFormFeild(
                keyboardType: TextInputType.name,
                prefixIcon: Icons.person_2_rounded,
                label: "Name",
              ),
              SizedBox(height: 16.h),
              CustomTextFormFeild(
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_rounded,
                label: "Email",
              ),
              SizedBox(height: 16.h),

              CustomPasswordFormField(
                label: "Password",
              ),

              SizedBox(height: 16.h),

              CustomPasswordFormField(
                label: "Re-Password",
              ),



              SizedBox(height: 24.h),
              CustomElevatedButton(
                title: "Create Account",
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500,color: ColorsManager.balck)
                  ),
                  CustomTextButton(title: "Login",

                  onPressed: (){

                    Navigator.pushReplacementNamed(context, RoutesManager.login);
                  },),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
