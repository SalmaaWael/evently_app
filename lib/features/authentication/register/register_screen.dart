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
import 'package:evently_app/l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text(AppLocalizations.of(context)!.register),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Image.asset(ImageAssets.eventlyLogo, height:150.h)),
                SizedBox(height: 24.h),
                CustomTextFormFeild(
                  keyboardType: TextInputType.name,
                  prefixIcon: Icons.person_2_rounded,
                  label: AppLocalizations.of(context)!.name,
                ),
                SizedBox(height: 16.h),
                CustomTextFormFeild(
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_rounded,
                  label: AppLocalizations.of(context)!.email,
                ),
                SizedBox(height: 16.h),

                CustomPasswordFormField(
                  label: AppLocalizations.of(context)!.password,
                ),

                SizedBox(height: 16.h),

                CustomPasswordFormField(
                  label: AppLocalizations.of(context)!.repassword,
                ),



                SizedBox(height: 24.h),
                CustomElevatedButton(
                  title: AppLocalizations.of(context)!.create_account,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_an_account,
                      style: Theme.of(context).textTheme.bodySmall,),

                    CustomTextButton(title: AppLocalizations.of(context)!.login,

                    onPressed: (){

                      Navigator.pushReplacementNamed(context, RoutesManager.login);
                    },),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
