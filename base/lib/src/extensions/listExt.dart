part of base;

extension ListExt<T> on List<T> {
  List<T> addBetweenEvery(T value) {
    List<T> r = [];
    this.asMap().forEach(
        (i, e) => i < this.length - 1 ? r.addAll([e, value]) : r.add(e));
    return r;
  }

  T getAt(int index) {
    if (length - 1 < index) return null;
    return elementAt(index);
  }

  bool get isExistAndNotEmpty => this != null && this.isNotEmpty;
}
