import 'constant.dart';

List<Device> filterData = deviceData;
void germanyData() {
  filterData = deviceData
      .where(
          (device) => device.deviceId == "D0315" || device.deviceId == "D0318")
      .toList();
}

void SpainData() {
  filterData = deviceData
      .where((device) =>
          device.deviceId == "D1003" ||
          device.deviceId == "D1004" ||
          device.deviceId == "D1005")
      .toList();
}

void FranceData() {
  filterData = deviceData
      .where((device) =>
          device.deviceId == "D0500" ||
          device.deviceId == "D0501" ||
          device.deviceId == "D0502" ||
          device.deviceId == "D0503" ||
          device.deviceId == "D0504" ||
          device.deviceId == "D0505")
      .toList();
}

void UKData() {
  filterData = deviceData
      .where(
          (device) => device.deviceId == "D0507" || device.deviceId == "D0508")
      .toList();
}

void USAData() {
  filterData = deviceData
      .where((device) =>
          device.deviceId == "02" ||
          device.deviceId == "05" ||
          device.deviceId == "04" ||
          device.deviceId == "06")
      .toList();
}

void LabData() {
  filterData = deviceData
      .where((device) =>
          device.deviceId == "D0506" ||
          device.deviceId == "07" ||
          device.deviceId == "08" ||
          device.deviceId == "09" ||
          device.deviceId == "10" ||
          device.deviceId == "11" ||
          device.deviceId == "12" ||
          device.deviceId == "S1" ||
          device.deviceId == "S2")
      .toList();
}

void allData() {
  filterData = deviceData;
}
