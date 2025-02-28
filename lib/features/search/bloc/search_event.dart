abstract class SearchEvent {
  const SearchEvent();
}

class SearchAnime extends SearchEvent {
  final String query;

  const SearchAnime(this.query);
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}
