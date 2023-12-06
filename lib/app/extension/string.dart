extension StringExtension on String {
  String capitalize({bool eachWorld = true}) {
    if (trim().isNotEmpty) {
      if (eachWorld) {
        // Split string into multiple words
        final List<String> words = split(' ');

        // Capitalize first letter of each words
        final capitalizedWords = words.map((word) {
          if (word.trim().isNotEmpty) {
            final String firstLetter =
                word.trim().substring(0, 1).toUpperCase();
            final String remainingLetters = word.trim().substring(1);

            return '$firstLetter$remainingLetters';
          }
          return '';
        });

        // Join/Merge all words back to one String
        return capitalizedWords.join(' ');
      } else {
        return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
      }
    }
    return this;
  }
}
