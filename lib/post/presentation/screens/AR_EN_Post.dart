//
// bool isArabic(String input) {
//   for (var codePoint in input.codeUnits) {
//     // Arabic Unicode ranges: 0600 - 06FF, 0750 - 077F, 08A0 - 08FF, FB50 - FDFF, FE70 - FEFF
//     if ((codePoint >= 0x0600 && codePoint <= 0x06FF) ||
//         (codePoint >= 0x0750 && codePoint <= 0x077F) ||
//         (codePoint >= 0x08A0 && codePoint <= 0x08FF) ||
//         (codePoint >= 0xFB50 && codePoint <= 0xFDFF) ||
//         (codePoint >= 0xFE70 && codePoint <= 0xFEFF)) {
//       return true;
//     }
//   }
//   return false;
// }

bool isEnglish(String input) {
  for (var codePoint in input.codeUnits) {
    // English Unicode range: 0020 - 007E (basic Latin characters)
    if (codePoint >= 0x0020 && codePoint <= 0x007E) {
      return true;
    }
  }
  return false;
}
