extension StringExtention on String {
  String trimText() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }
}
