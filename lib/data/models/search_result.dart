class SearchResult {
  final String type;
  final String typeAr;
  final String id;
  final String title;
  final String snippet;
  final String? route;

  const SearchResult({
    required this.type,
    required this.typeAr,
    required this.id,
    required this.title,
    required this.snippet,
    this.route,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'typeAr': typeAr,
    'id': id,
    'title': title,
    'snippet': snippet,
    'route': route,
  };

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    type: json['type'] as String,
    typeAr: json['typeAr'] as String,
    id: json['id'] as String,
    title: json['title'] as String,
    snippet: json['snippet'] as String,
    route: json['route'] as String?,
  );
}
