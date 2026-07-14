class WishlistModel {
  final String bookId;
  final DateTime addedAt;

  WishlistModel({
    required this.bookId,
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'addedAt': addedAt,
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      bookId: map['bookId'] ?? '',
      addedAt: map['addedAt'].toDate(),
    );
  }
}