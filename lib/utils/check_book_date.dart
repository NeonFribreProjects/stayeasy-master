class DateUtil {
  static bool isPastDate(String isoDate) {
    final currentDateTime = DateTime.now().toUtc();
    final providedDateTime = DateTime.parse(isoDate).toUtc();
    return providedDateTime.isBefore(currentDateTime);
  }
}
