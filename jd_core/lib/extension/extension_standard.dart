///dart常使用的高阶函数
extension AlsoExtension<T> on T {
  T also(void Function(T it) block) {
    block(this);
    return this;
  }
}

extension LetExtension<T> on T {
  R let<R>(R Function(T it) block) {
    return block(this);
  }
}

extension RunExtension<T> on T {
  R run<R>(R Function() block) {
    return block();
  }
}

extension ApplyExtension<T> on T {
  T apply<R>(void Function() block) {
    block();
    return this;
  }
}

extension TakeIfExtension<T> on T {
  T? takeIf<R>(bool Function(T it) predicate) {
    return predicate(this) ? this : null;
  }
}

extension TakeUnlessExtension<T> on T {
  T? takeUnless<R>(bool Function(T it) predicate) {
    return !predicate(this) ? this : null;
  }
}

extension RepeatExtension<T> on T {}
