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

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'data': data.map(toJsonT).toList(),
      'totalElements': totalElements,
      'page': page,
      'pageSize': pageSize,
      'totalPages': totalPages,
    };
  }

  bool get hasMore => page < totalPages - 1;
  bool get hasNextPage => page < totalPages - 1;
  bool get hasPreviousPage => page > 0;
  bool get isFirstPage => page == 0;
  bool get isLastPage => page >= totalPages - 1;
  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => data.isNotEmpty;

  PaginatedResponse<R> map<R>(R Function(T) transform) {
    return PaginatedResponse<R>(
      data: data.map(transform).toList(),
      totalElements: totalElements,
      page: page,
      pageSize: pageSize,
      totalPages: totalPages,
    );
  }

  PaginatedResponse<T> copyWith({
    List<T>? data,
    int? totalElements,
    int? page,
    int? pageSize,
    int? totalPages,
  }) {
    return PaginatedResponse<T>(
      data: data ?? this.data,
      totalElements: totalElements ?? this.totalElements,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  String toString() {
    return 'PaginatedResponse(items: ${data.length}, page: $page/$totalPages, total: $totalElements)';
  }
}
