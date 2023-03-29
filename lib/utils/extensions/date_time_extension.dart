import 'package:intl/intl.dart';

extension DataTimeExtensions on DateTime {

  String getFormattedDateSlashes(){
    final f = DateFormat('dd/ MM /yyyy');
    return f.format(this);
  }

  String getFormattedDateSlashesWithTime(){
    final f = DateFormat('dd/MM/yy @ hh:mm a');
    return f.format(this);
  }

  String getFormattedDateLocalWords({DateTime? localTime}){
    final f = DateFormat('MMMM dd, y');
    return f.format(toLocal());
  }
}