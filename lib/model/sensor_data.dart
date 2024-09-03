class SensorsData {
  final String? tempCelsiusValue;
  final String? phValue;

  final String? tdsData;
  final String? dateTime;

  // final String? doData;
  // final String ec;
  // final String salanity;

  SensorsData({
    this.tempCelsiusValue,
    this.phValue,
    // this.ec,
    this.tdsData,
    // this.salanity
    this.dateTime,
  });

  static SensorsData fromMap(Map<String, dynamic> map) => SensorsData(
        tempCelsiusValue: map['field1'],
        phValue: map['field2'],
        tdsData: map['field3'],
        dateTime: map['created_at'],
      );
}
