class Donation {
  final String organization;
  final String desc;
  final String total;
  final String date;

  Donation({
    required this.organization,
    required this.desc,
    required this.total,
    required this.date,
  });
}

// List<Donation> donations = [
//   Donation(
//     organization: 'project',
//     desc: 'description',
//     total: '100',
//     date: DateTime(
//       2023,
//       5,
//       1,
//     ),
//   ),
//   Donation(
//     organization: 'project',
//     desc: 'description',
//     total: '100',
//     date: DateTime(
//       2023,
//       5,
//       1,
//     ),
//   ),
//   Donation(
//     organization: 'project',
//     desc: 'description',
//     total: '100',
//     date: DateTime(
//       2022,
//       5,
//       2,
//     ),
//   ),
//   Donation(
//     organization: 'project',
//     desc: 'description',
//     total: '100',
//     date: DateTime(
//       2021,
//       5,
//       3,
//     ),
//   ),
//   Donation(
//     organization: 'project',
//     desc: 'description',
//     total: '100',
//     date: DateTime(
//       2023,
//       5,
//       4,
//     ),
//   ),
//   Donation(
//     organization: 'project',
//     desc: 'description',
//     total: '100',
//     date: DateTime(
//       2023,
//       5,
//       4,
//     ),
//   ),
// ];

// List<DateTime> dates = filterDate();

// List<DateTime> filterDate() {
//   List<DateTime> filteredDates = [];

//   for (int i = 0; i < donations.length; i++) {
//     if (i + 1 >= donations.length) {
//       break;
//     }
//     if (donations[i].date.millisecondsSinceEpoch ==
//         donations[i + 1].date.millisecondsSinceEpoch) {
//       continue;
//     }

//     filteredDates.add(donations[i].date);
//     filteredDates.add(donations[i + 1].date);
//   }

//   return filteredDates;
// }

// List<Donation> filterDonation(DateTime date) {
//   return donations.where((element) => element.date == date).toList();
// }
