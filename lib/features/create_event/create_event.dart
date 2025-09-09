import 'package:evently_app/core/assets_manager/assests_manager.dart';
import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/core/extension/date_extension.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../l10n/app_localizations.dart';
import '../../models/category_model.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  DateTime? selectedDate=DateTime.now();
  TimeOfDay? selectedTime=TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_event),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(ImageAssets.birthday)),
              SizedBox(height: 4.h,),
              CustomTabBar(categories: CategoryModel.getCategories(context),
                selectedBackgroundColor: ColorsManager.blue,
                unselectedBackgroundColor: Colors.transparent,
                selectedForegroundColor: ColorsManager.white,
                unselectedForegroundColor: ColorsManager.blue,

              ),
              SizedBox(height: 16.h,),
              Text(AppLocalizations.of(context)!.title, style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall,),
              SizedBox(height: 8.h,),
              CustomTextFormFeild(
                prefixIcon: Icons.edit_note,
                hint: AppLocalizations.of(context)!.event_title,
                hintstyle: null,
              ),
              Text(AppLocalizations.of(context)!.description, style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall,),
              SizedBox(height: 8.h,),
              CustomTextFormFeild(
                hint: AppLocalizations.of(context)!.event_description,
                maxLines: 5, hintstyle: null,

              ),
              SizedBox(height: 16.h,),
              Row(
                children: [
                  Icon(Icons.date_range_rounded),
                  SizedBox(width: 8.w,),
                  Text(
                    selectedDate!.toFormatDate,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  Spacer(),
                  CustomTextButton(
                      title: AppLocalizations.of(context)!.choose_date,
                      onPressed: () {
                        chooseEventDate();
                      })

                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time_outlined),
                  SizedBox(width: 8.w,),
                  Text(AppLocalizations.of(context)!.event_time, style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,),
                  Spacer(),
                  CustomTextButton(
                      title: AppLocalizations.of(context)!.choose_time,
                      onPressed: () {
                        showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                      }),


                ],
              ),
              SizedBox(height: 18),
              CustomElevatedButton(
                  title: AppLocalizations.of(context)!.add_event),


            ],
          ),
        ),
      ),

    );
  }


  void chooseEventDate() async{
   selectedDate= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))??selectedDate;
   setState(() {

   });
  }
}