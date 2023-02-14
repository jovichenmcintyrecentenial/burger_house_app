// Package imports:
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'helper.dart';

class LogConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    var lineCount = 0;
    for (var line in event.lines) {
      if (kDebugMode) {
        print(line);
      }
      if (lineCount == 1) {
        //This is for formatting to log file
        final text = line.contains('💡')
            ? '💡 ${line.split('💡')[1]}'
            : line.contains('⛔')
                ? '⛔ ${line.split('⛔')[1]}'
                : line;
        final logOutput = '[${DateTime.now()}] - ${text.split('')[0]}';
        Helper.logHistory +=
            '\n$logOutput \n------------------------------------';
      }
      lineCount++;
    }
  }
}
