class PaginatedData<T> {
  final List<T> items;
  final int totalElements;
  final int currentPage;
  final int pageSize;
  final int totalPages;

  const PaginatedData({
    required this.items,
    required this.totalElements,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
  });

  bool get hasNextPage => currentPage < totalPages - 1;
  bool get hasPreviousPage => currentPage > 0;
  bool get isFirstPage => currentPage == 0;
  bool get isLastPage => currentPage >= totalPages - 1;
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  PaginatedData<T> copyWith({
    List<T>? items,
    int? totalElements,
    int? currentPage,
    int? pageSize,
    int? totalPages,
  }) {
    return PaginatedData<T>(
      items: items ?? this.items,
      totalElements: totalElements ?? this.totalElements,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  String toString() {
    return 'PaginatedData(items: ${items.length}, page: $currentPage/$totalPages, total: $totalElements)';
  }
}