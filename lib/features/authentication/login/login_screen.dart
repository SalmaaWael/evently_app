import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/assets_manager/assests_manager.dart';
import '../../../core/colors_manager.dart';
import '../../../core/routes_manager/routes_manager.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_password_feild.dart';
import '../../../core/widgets/custom_text_form_feild.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import '../../../providers/lang_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Scaffold(

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(ImageAssets.eventlyLogo, height: 150.h),
                  SizedBox(height: 16.h),

                  CustomTextFormFeild(
                    label: AppLocalizations.of(context)!.email,
                    prefixIcon: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
                  ),
                  SizedBox(height: 16.h),

                  CustomPasswordFormField(
                    label: AppLocalizations.of(context)!.password,
                    controller: passwordController,
                    validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
                  ),

                  // زرار Forget Password
                  Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forget_password,
                          style: TextStyle(
                              color: ColorsManager.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      )),

                  SizedBox(height: 16.h),

                  CustomElevatedButton(
                    title: AppLocalizations.of(context)!.login,
                    onPressed: login,
                  ),

                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        AppLocalizations.of(context)!.dont_have_an_account,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.register);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style: TextStyle(
                              color: ColorsManager.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),


                  Row(
                    children: [
                      Expanded(child: Divider(color: ColorsManager.blue, thickness: 1, endIndent: 10)),
                      Text(
                          "Or",
                          style: Theme.of(context).textTheme.bodyMedium
                      ),
                      Expanded(child: Divider(color: ColorsManager.blue, thickness: 1, indent: 10)),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // زرار جوجل
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorsManager.blue, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageAssets.googleIcon, height: 25.h),
                        SizedBox(width: 10.w),
                        Text(
                          "Login With Google",
                          style: TextStyle(color: ColorsManager.blue, fontSize: 16.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // زرار تغيير اللغة
                  Center(
                    child: InkWell(
                      onTap: () {
                        langProvider.changeAppLang(langProvider.isEnglish ? 'ar' : 'en');
                      },
                      child: Container(
                        width: 80.w,
                        height: 40.h,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(color: ColorsManager.blue, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 32.w,
                              height: 32.h,
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: langProvider.isEnglish ? ColorsManager.blue : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset("assets/images/us_flag.png", fit: BoxFit.cover),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 32.w,
                              height: 32.h,
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: !langProvider.isEnglish ? ColorsManager.blue : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset("assets/images/eg_flag.png", fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, RoutesManager.Mainlayout);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }
  }
}