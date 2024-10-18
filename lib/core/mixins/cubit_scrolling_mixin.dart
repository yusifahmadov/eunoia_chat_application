/// A mixin to handle scrolling logic for a Cubit.
mixin CubitScrollingMixin<T, C> {
  // Indicates if the first fetch is in progress.
  bool _isFirstFetching = true;

  // Indicates if data is currently being loaded.
  bool _isLoading = false;

  // Getter for the loading state.
  bool get isLoading => this._isLoading;

  // Setter for the loading state.
  set isLoading(bool value) => this._isLoading = value;

  // Indicates if there is more data to fetch.
  bool _hasMore = true;

  // List to store fetched data.
  final List<T> _fetchedData = [];

  // A dynamic helper class instance.
  dynamic _helperClass;

  // Getter for the helper class.
  C get helperClass => _helperClass;

  // Getter for the first fetching state.
  bool get isFirstFetching => _isFirstFetching;

  // Getter for the hasMore state.
  bool get hasMore => _hasMore;

  // Getter for the fetched data.
  List<T> get fetchedData => _fetchedData;

  /// Refreshes the state by resetting the relevant variables.
  void refresh() {
    hasMore = true;
    _fetchedData.clear();
    isFirstFetching = true;
  }

  // Setter for the helper class.
  set helperClass(dynamic helperModel) => _helperClass = helperModel;

  // Setter for the hasMore state.
  set hasMore(bool value) => _hasMore = value;

  // Setter for the first fetching state.
  set isFirstFetching(bool value) => _isFirstFetching = value;
}
