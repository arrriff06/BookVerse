class LibraryModel {
  final String bookId;
  final String status;
  final DateTime? addedAt;

  LibraryModel({
    required this.bookId,
    required this.status,
    this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'status': status,
      'addedAt': addedAt,
    };
  }

  factory LibraryModel.fromMap(Map<String, dynamic> map) {
    return LibraryModel(
      bookId: map['bookId'] ?? '',
      status: map['status'] ?? 'reading',
      addedAt: map['addedAt']?.toDate(),
    );
  }
}