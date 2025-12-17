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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.register),
          centerTitle: true,
          // 👇 تأكدي إن عنوان الأب بار لونه أزرق أو أسود عشان يبان
          titleTextStyle: TextStyle(color: ColorsManager.black, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: ColorsManager.black), // لون سهم الرجوع
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Image.asset(ImageAssets.eventlyLogo, height: 150.h)),
                  SizedBox(height: 24.h),

                  CustomTextFormFeild(
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person_2_rounded,
                    label: AppLocalizations.of(context)!.name,
                    controller: nameController,
                    validator: (value) => (value == null || value.isEmpty) ? "Required" : null,
                  ),
                  SizedBox(height: 16.h),

                  CustomTextFormFeild(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_rounded,
                    label: AppLocalizations.of(context)!.email,
                    controller: emailController,
                    validator: (value) => (value == null || value.isEmpty) ? "Required" : null,
                  ),
                  SizedBox(height: 16.h),

                  CustomPasswordFormField(
                    label: AppLocalizations.of(context)!.password,
                    controller: passwordController,
                    validator: (value) => (value == null || value.length < 6) ? "Weak Password" : null,
                  ),

                  SizedBox(height: 16.h),

                  CustomPasswordFormField(
                    label: AppLocalizations.of(context)!.repassword,
                    controller: rePasswordController,
                    validator: (value) => (value != passwordController.text) ? "Mismatch" : null,
                  ),

                  SizedBox(height: 24.h),

                  CustomElevatedButton(
                    title: AppLocalizations.of(context)!.create_account,
                    onPressed: createAccount,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_an_account,
                        // ⚫ لون أسود
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.login);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          // 🔵 لون أزرق
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

                  SizedBox(height: 24.h),

                  // 👇 زرار اللغة (نفس الكود)
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

  void createAccount() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

      // 1. إنشاء الحساب
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 👇👇 2. الخطوة الجديدة: تحديث اسم المستخدم في بروفايل الفايربيز
      await credential.user?.updateDisplayName(nameController.text.trim());

      // عشان التحديث يسمع فوراً في التطبيق
      await credential.user?.reload();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Created! 🎉')));
      Navigator.pushReplacementNamed(context, RoutesManager.login);

    } catch (e) {
      // ... (باقي الكود زي ما هو)
    }
  }
}