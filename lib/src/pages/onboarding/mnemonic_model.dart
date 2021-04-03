class MnemonicModel {
  final List<String> _words = [];

  List<String> get words => _words;

  set words(List<String> words) {
    _words.clear();
    _words.addAll(words);
  }
}