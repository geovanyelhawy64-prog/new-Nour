T requireDatabaseValue<T>(T? value, String column) {
  if (value == null) {
    throw StateError('قيمة مطلوبة مفقودة في عمود قاعدة البيانات: $column');
  }
  return value;
}
