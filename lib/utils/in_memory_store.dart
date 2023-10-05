import 'package:rxdart/rxdart.dart';

class InMemoryStore<T> {
  final BehaviorSubject<T> _subject;

  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  void close()=> _subject.close();
}
