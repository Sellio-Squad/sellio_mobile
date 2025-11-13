class PaginatedResponse<T> {
  final List<T> data;
  final int totalElements;
  final int page;
  final int pageSize;
  final int totalPages;

  const PaginatedResponse({
    required this.data,
    required this.totalElements,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return PaginatedResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      totalElements: json['totalElements'] as int,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  bool get hasMore => page < totalPages - 1;
  bool get isFirstPage => page == 0;
  bool get isLastPage => page == totalPages - 1;
}