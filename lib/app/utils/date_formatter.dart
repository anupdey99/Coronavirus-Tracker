import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter({this.lastUpdated});
  final String? lastUpdated;

  String lastUpdatedStatusText() {
    if (lastUpdated != null) {
      final DateTime? date = DateTime.tryParse(lastUpdated!);
      if (date != null) {
        final formatter = DateFormat.yMd().add_Hms();
        final formatted = formatter.format(date);
        return 'Last updated: $formatted';
      }
      return '';
    }
    return '';
  }
}
