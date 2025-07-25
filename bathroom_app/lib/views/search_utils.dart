List<String> filterSearchResults(String query, List<String> data) {
  return data
      .where((item) => item.toLowerCase().contains(query.toLowerCase()))
      .toList();
}