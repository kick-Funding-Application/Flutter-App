class Donator {
  final String name;
  final String phone;
  final String price;
  final String date;

  Donator({
    required this.name,
    required this.phone,
    required this.price,
    required this.date,
  });
}

// List<Donator> donators = [
//   Donator(
//     name: 'Donator',
//     phone: 'phone number',
//     price: '50',
//     date: DateTime(
//       2023,
//       5,
//       8,
//     ),
//   ),
//   Donator(
//     name: 'Donator',
//     phone: 'phone number',
//     price: '50',
//     date: DateTime(
//       2023,
//       5,
//       10,
//     ),
//   ),
//   Donator(
//     name: 'Donator',
//     phone: 'phone number',
//     price: '50',
//     date: DateTime(
//       2023,
//       5,
//       19,
//     ),
//   ),
//   Donator(
//     name: 'Donator',
//     phone: 'phone number',
//     price: '50',
//     date: DateTime(
//       2023,
//       5,
//       22,
//     ),
//   ),
//   Donator(
//     name: 'Donator',
//     phone: 'phone number',
//     price: '50',
//     date: DateTime(
//       2023,
//       5,
//       20,
//     ),
//   ),
// ];

// List<DateTime> donatorsDates = filterDonatorsDate();

// List<DateTime> filterDonatorsDate() {
//   List<DateTime> filteredDates = [];

//   for (int i = 0; i < donators.length; i++) {
//     if (i + 1 >= donators.length) {
//       break;
//     }
//     if (donators[i].date.millisecondsSinceEpoch ==
//         donators[i + 1].date.millisecondsSinceEpoch) {
//       continue;
//     }

//     filteredDates.add(donators[i].date);
//     filteredDates.add(donators[i + 1].date);
//   }

//   return filteredDates;
// }

// List<Donator> filterDonators(DateTime date) {
//   return donators.where((element) => element.date == date).toList();
// }
