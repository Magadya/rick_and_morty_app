extension IterableExt<T> on Iterable<T> {
  void forEachWithIndex(void Function(T, int) callback) {
    var index = 0;
    for (var element in this) {
      callback(element, index);
      index++;
    }
  }
}
