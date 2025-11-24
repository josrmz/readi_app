class Book {
  final String title;
  final String author;
  final String image;
  final String status;
  final int pagesTotal;
  final int pagesRead;

  Book({
    required this.title,
    required this.author,
    required this.image,
    required this.status,
    required this.pagesTotal,
    required this.pagesRead,
  });

  factory Book.initial() {
    return Book(
      title: '',
      author: '',
      image: "assets/welcome.png",
      status: 'Pendiente',
      pagesTotal: 0,
      pagesRead: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'image': image,
      'status': status,
      'pagesTotal': pagesTotal,
      'pagesRead': pagesRead,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      image: map['image'] ?? '',
      status: map['status'] ?? 'Pendiente',
      pagesTotal: map['pagesTotal'] ?? 0,
      pagesRead: map['pagesRead'] ?? 0,
    );
  }
}
