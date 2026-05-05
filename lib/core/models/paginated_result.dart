class PaginatedResult<T> {
  final List<T> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  PaginatedResult({
    required this.items,
    required this.total,
    this.page = 1,
    this.limit = 20,
    this.totalPages = 1,
  });

  factory PaginatedResult.empty() => PaginatedResult(items: [], total: 0);
}
