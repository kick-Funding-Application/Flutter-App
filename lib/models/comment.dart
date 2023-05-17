class Comment {
  final String comment;
  final String userimage;
  final String username;
  final String date;
  final int days;
  final double rate;
  final bool submitted;

  Comment({
    required this.comment,
    required this.userimage,
    required this.date,
    required this.days,
    required this.rate,
    required this.username,
    required this.submitted,
  });
}
