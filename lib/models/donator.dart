class Donator {
  final String name;
  final String phoneNo;
  final String total;
  final DateTime date;

  Donator({
    required this.name,
    required this.phoneNo,
    required this.total,
    required this.date,
  });
}

List<Donator> donators = [
  Donator(
    name: 'Donator',
    phoneNo: 'phone number',
    total: '50',
    date: DateTime(
      2023,
      5,
      8,
    ),
  ),
  Donator(
    name: 'Donator',
    phoneNo: 'phone number',
    total: '50',
    date: DateTime(
      2023,
      5,
      10,
    ),
  ),
  Donator(
    name: 'Donator',
    phoneNo: 'phone number',
    total: '50',
    date: DateTime(
      2023,
      5,
      19,
    ),
  ),
  Donator(
    name: 'Donator',
    phoneNo: 'phone number',
    total: '50',
    date: DateTime(
      2023,
      5,
      22,
    ),
  ),
  Donator(
    name: 'Donator',
    phoneNo: 'phone number',
    total: '50',
    date: DateTime(
      2023,
      5,
      20,
    ),
  ),
];

List<DateTime> donatorsDates = filterDonatorsDate();

List<DateTime> filterDonatorsDate() {
  List<DateTime> filteredDates = [];

  for (int i = 0; i < donators.length; i++) {
    if (i + 1 >= donators.length) {
      break;
    }
    if (donators[i].date.millisecondsSinceEpoch ==
        donators[i + 1].date.millisecondsSinceEpoch) {
      continue;
    }

    filteredDates.add(donators[i].date);
    filteredDates.add(donators[i + 1].date);
  }

  return filteredDates;
}

List<Donator> filterDonators(DateTime date) {
  return donators.where((element) => element.date == date).toList();
}
