import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
   String get toFormatDate {
      final formater = DateFormat("yMMMMEEEEd");
      return formater.format(this);
   }
   String get viewMonthText{
      DateFormat formater= DateFormat("MMMM");
     String month= formater.format(this);
    return month.substring(0,3);
   }
}
