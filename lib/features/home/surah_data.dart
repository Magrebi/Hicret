// lib/features/home/surah_data.dart

class SurahData {
  final int number;
  final String transliteration;
  final String englishMeaning;
  final String arabicName;
  final int totalAyahs;

  const SurahData({
    required this.number,
    required this.transliteration,
    required this.englishMeaning,
    required this.arabicName,
    required this.totalAyahs,
  });
}

const List<SurahData> allSurahsStaticData = [
  SurahData(number: 1, transliteration: 'Al-Fatihah', englishMeaning: 'The Opening', arabicName: 'الفاتحة', totalAyahs: 7),
  SurahData(number: 2, transliteration: 'Al-Baqarah', englishMeaning: 'The Cow', arabicName: 'البقرة', totalAyahs: 286),
  SurahData(number: 3, transliteration: "Ali 'Imran", englishMeaning: 'Family of Imran', arabicName: 'آل عمران', totalAyahs: 200),
  SurahData(number: 4, transliteration: 'An-Nisa', englishMeaning: 'The Women', arabicName: 'النساء', totalAyahs: 176),
  SurahData(number: 5, transliteration: "Al-Ma'idah", englishMeaning: 'The Table Spread', arabicName: 'المائدة', totalAyahs: 120),
  SurahData(number: 6, transliteration: "Al-An'am", englishMeaning: 'The Cattle', arabicName: 'الأنعام', totalAyahs: 165),
  SurahData(number: 7, transliteration: "Al-A'raf", englishMeaning: 'The Heights', arabicName: 'الأعراف', totalAyahs: 206),
  SurahData(number: 8, transliteration: 'Al-Anfal', englishMeaning: 'The Spoils of War', arabicName: 'الأنفال', totalAyahs: 75),
  SurahData(number: 9, transliteration: 'At-Tawbah', englishMeaning: 'The Repentance', arabicName: 'التوبة', totalAyahs: 129),
  SurahData(number: 10, transliteration: 'Yunus', englishMeaning: 'Jonah', arabicName: 'يونس', totalAyahs: 109),
  SurahData(number: 11, transliteration: 'Hud', englishMeaning: 'Hud', arabicName: 'هود', totalAyahs: 123),
  SurahData(number: 12, transliteration: 'Yusuf', englishMeaning: 'Joseph', arabicName: 'يوسف', totalAyahs: 111),
  SurahData(number: 13, transliteration: "Ar-Ra'd", englishMeaning: 'The Thunder', arabicName: 'الرعد', totalAyahs: 43),
  SurahData(number: 14, transliteration: 'Ibrahim', englishMeaning: 'Abraham', arabicName: 'إبراهيم', totalAyahs: 52),
  SurahData(number: 15, transliteration: 'Al-Hijr', englishMeaning: 'The Rocky Tract', arabicName: 'الحجر', totalAyahs: 99),
  SurahData(number: 16, transliteration: 'An-Nahl', englishMeaning: 'The Bee', arabicName: 'النحل', totalAyahs: 128),
  SurahData(number: 17, transliteration: 'Al-Isra', englishMeaning: 'The Night Journey', arabicName: 'الإسراء', totalAyahs: 111),
  SurahData(number: 18, transliteration: 'Al-Kahf', englishMeaning: 'The Cave', arabicName: 'الكهف', totalAyahs: 110),
  SurahData(number: 19, transliteration: 'Maryam', englishMeaning: 'Mary', arabicName: 'مريم', totalAyahs: 98),
  SurahData(number: 20, transliteration: 'Taha', englishMeaning: 'Ta-Ha', arabicName: 'طه', totalAyahs: 135),
  SurahData(number: 21, transliteration: 'Al-Anbiya', englishMeaning: 'The Prophets', arabicName: 'الأنبياء', totalAyahs: 112),
  SurahData(number: 22, transliteration: 'Al-Hajj', englishMeaning: 'The Pilgrimage', arabicName: 'الحج', totalAyahs: 78),
  SurahData(number: 23, transliteration: "Al-Mu'minun", englishMeaning: 'The Believers', arabicName: 'المؤمنون', totalAyahs: 118),
  SurahData(number: 24, transliteration: 'An-Nur', englishMeaning: 'The Light', arabicName: 'النور', totalAyahs: 64),
  SurahData(number: 25, transliteration: 'Al-Furqan', englishMeaning: 'The Criterion', arabicName: 'الفرقان', totalAyahs: 77),
  SurahData(number: 26, transliteration: "Ash-Shu'ara", englishMeaning: 'The Poets', arabicName: 'الشعراء', totalAyahs: 227),
  SurahData(number: 27, transliteration: 'An-Naml', englishMeaning: 'The Ant', arabicName: 'النمل', totalAyahs: 93),
  SurahData(number: 28, transliteration: 'Al-Qasas', englishMeaning: 'The Stories', arabicName: 'القصص', totalAyahs: 88),
  SurahData(number: 29, transliteration: 'Al-Ankabut', englishMeaning: 'The Spider', arabicName: 'العنكبوت', totalAyahs: 69),
  SurahData(number: 30, transliteration: 'Ar-Rum', englishMeaning: 'The Romans', arabicName: 'الروم', totalAyahs: 60),
  SurahData(number: 31, transliteration: 'Luqman', englishMeaning: 'Luqman', arabicName: 'لقمان', totalAyahs: 34),
  SurahData(number: 32, transliteration: 'As-Sajdah', englishMeaning: 'The Prostration', arabicName: 'السجدة', totalAyahs: 30),
  SurahData(number: 33, transliteration: 'Al-Ahzab', englishMeaning: 'The Combined Forces', arabicName: 'الأحزاب', totalAyahs: 73),
  SurahData(number: 34, transliteration: 'Saba', englishMeaning: 'Sheba', arabicName: 'سبأ', totalAyahs: 54),
  SurahData(number: 35, transliteration: 'Fatir', englishMeaning: 'Originator', arabicName: 'فاطر', totalAyahs: 45),
  SurahData(number: 36, transliteration: 'Ya-Sin', englishMeaning: 'Ya-Sin', arabicName: 'يس', totalAyahs: 83),
  SurahData(number: 37, transliteration: 'As-Saffat', englishMeaning: 'Those who set the Ranks', arabicName: 'الصافات', totalAyahs: 182),
  SurahData(number: 38, transliteration: 'Sad', englishMeaning: 'The Letter Sad', arabicName: 'ص', totalAyahs: 88),
  SurahData(number: 39, transliteration: 'Az-Zumar', englishMeaning: 'The Troops', arabicName: 'الزمر', totalAyahs: 75),
  SurahData(number: 40, transliteration: 'Ghafir', englishMeaning: 'The Forgiver', arabicName: 'غافر', totalAyahs: 85),
  SurahData(number: 41, transliteration: 'Fussilat', englishMeaning: 'Explained in Detail', arabicName: 'فصلت', totalAyahs: 54),
  SurahData(number: 42, transliteration: 'Ash-Shura', englishMeaning: 'The Consultation', arabicName: 'الشورى', totalAyahs: 53),
  SurahData(number: 43, transliteration: 'Az-Zukhruf', englishMeaning: 'The Ornaments of Gold', arabicName: 'الزخرف', totalAyahs: 89),
  SurahData(number: 44, transliteration: 'Ad-Dukhan', englishMeaning: 'The Smoke', arabicName: 'الدخان', totalAyahs: 59),
  SurahData(number: 45, transliteration: 'Al-Jathiyah', englishMeaning: 'The Crouching', arabicName: 'الجاثية', totalAyahs: 37),
  SurahData(number: 46, transliteration: 'Al-Ahqaf', englishMeaning: 'The Wind-Curved Sandhills', arabicName: 'الأحقاف', totalAyahs: 35),
  SurahData(number: 47, transliteration: 'Muhammad', englishMeaning: 'Muhammad', arabicName: 'محمد', totalAyahs: 38),
  SurahData(number: 48, transliteration: 'Al-Fath', englishMeaning: 'The Victory', arabicName: 'الفتح', totalAyahs: 29),
  SurahData(number: 49, transliteration: 'Al-Hujurat', englishMeaning: 'The Dwellings', arabicName: 'الحجرات', totalAyahs: 18),
  SurahData(number: 50, transliteration: 'Qaf', englishMeaning: 'The Letter Qaf', arabicName: 'ق', totalAyahs: 45),
  SurahData(number: 51, transliteration: 'Adh-Dhariyat', englishMeaning: 'The Winnowing Winds', arabicName: 'الذاريات', totalAyahs: 60),
  SurahData(number: 52, transliteration: 'At-Tur', englishMeaning: 'The Mount', arabicName: 'الطور', totalAyahs: 49),
  SurahData(number: 53, transliteration: 'An-Najm', englishMeaning: 'The Star', arabicName: 'النجم', totalAyahs: 62),
  SurahData(number: 54, transliteration: 'Al-Qamar', englishMeaning: 'The Moon', arabicName: 'القمر', totalAyahs: 55),
  SurahData(number: 55, transliteration: 'Ar-Rahman', englishMeaning: 'The Beneficent', arabicName: 'الرحمن', totalAyahs: 78),
  SurahData(number: 56, transliteration: "Al-Waqi'ah", englishMeaning: 'The Inevitable', arabicName: 'الواقعة', totalAyahs: 96),
  SurahData(number: 57, transliteration: 'Al-Hadid', englishMeaning: 'The Iron', arabicName: 'الحديد', totalAyahs: 29),
  SurahData(number: 58, transliteration: 'Al-Mujadilah', englishMeaning: 'The Pleading Woman', arabicName: 'المجادلة', totalAyahs: 22),
  SurahData(number: 59, transliteration: 'Al-Hashr', englishMeaning: 'The Exile', arabicName: 'الحشر', totalAyahs: 24),
  SurahData(number: 60, transliteration: 'Al-Mumtahanah', englishMeaning: 'She that is to be examined', arabicName: 'الممتحنة', totalAyahs: 13),
  SurahData(number: 61, transliteration: 'As-Saff', englishMeaning: 'The Ranks', arabicName: 'الصف', totalAyahs: 14),
  SurahData(number: 62, transliteration: "Al-Jumu'ah", englishMeaning: 'The Congregation, Friday', arabicName: 'الجمعة', totalAyahs: 11),
  SurahData(number: 63, transliteration: 'Al-Munafiqun', englishMeaning: 'The Hypocrites', arabicName: 'المنافقون', totalAyahs: 11),
  SurahData(number: 64, transliteration: 'At-Taghabun', englishMeaning: 'The Mutual Disillusion', arabicName: 'التغابن', totalAyahs: 18),
  SurahData(number: 65, transliteration: 'At-Talaq', englishMeaning: 'The Divorce', arabicName: 'الطلاق', totalAyahs: 12),
  SurahData(number: 66, transliteration: 'At-Tahrim', englishMeaning: 'The Prohibition', arabicName: 'التحريم', totalAyahs: 12),
  SurahData(number: 67, transliteration: 'Al-Mulk', englishMeaning: 'The Sovereignty', arabicName: 'الملك', totalAyahs: 30),
  SurahData(number: 68, transliteration: 'Al-Qalam', englishMeaning: 'The Pen', arabicName: 'القلم', totalAyahs: 52),
  SurahData(number: 69, transliteration: 'Al-Haqqah', englishMeaning: 'The Inevitable Reality', arabicName: 'الحاقة', totalAyahs: 52),
  SurahData(number: 70, transliteration: "Al-Ma'arij", englishMeaning: 'The Ascending Stairways', arabicName: 'المعارج', totalAyahs: 44),
  SurahData(number: 71, transliteration: 'Nuh', englishMeaning: 'Noah', arabicName: 'نوح', totalAyahs: 28),
  SurahData(number: 72, transliteration: 'Al-Jinn', englishMeaning: 'The Jinn', arabicName: 'الجن', totalAyahs: 28),
  SurahData(number: 73, transliteration: 'Al-Muzzammil', englishMeaning: 'The Enshrouded One', arabicName: 'المزمل', totalAyahs: 20),
  SurahData(number: 74, transliteration: 'Al-Muddaththir', englishMeaning: 'The Cloaked One', arabicName: 'المدثر', totalAyahs: 56),
  SurahData(number: 75, transliteration: 'Al-Qiyamah', englishMeaning: 'The Resurrection', arabicName: 'القيامة', totalAyahs: 40),
  SurahData(number: 76, transliteration: 'Al-Insan', englishMeaning: 'Man', arabicName: 'الإنسان', totalAyahs: 31),
  SurahData(number: 77, transliteration: 'Al-Mursalat', englishMeaning: 'The Emissaries', arabicName: 'المرسلات', totalAyahs: 50),
  SurahData(number: 78, transliteration: 'An-Naba', englishMeaning: 'The Tidings', arabicName: 'النبأ', totalAyahs: 40),
  SurahData(number: 79, transliteration: "An-Nazi'at", englishMeaning: 'Those who drag forth', arabicName: 'النازعات', totalAyahs: 46),
  SurahData(number: 80, transliteration: "'Abasa',", englishMeaning: 'He Frowned', arabicName: 'عبس', totalAyahs: 42),
  SurahData(number: 81, transliteration: 'At-Takwir', englishMeaning: 'The Overthrowing', arabicName: 'التكوير', totalAyahs: 29),
  SurahData(number: 82, transliteration: 'Al-Infitar', englishMeaning: 'The Cleaving', arabicName: 'الانفطار', totalAyahs: 19),
  SurahData(number: 83, transliteration: 'Al-Mutaffifin', englishMeaning: 'The Defrauding', arabicName: 'المطففين', totalAyahs: 36),
  SurahData(number: 84, transliteration: 'Al-Inshiqaq', englishMeaning: 'The Sundering', arabicName: 'الانشِقاق', totalAyahs: 25),
  SurahData(number: 85, transliteration: 'Al-Buruj', englishMeaning: 'The Mansions of the Stars', arabicName: 'البروج', totalAyahs: 22),
  SurahData(number: 86, transliteration: 'At-Tariq', englishMeaning: 'The Nightcomer', arabicName: 'الطارق', totalAyahs: 17),
  SurahData(number: 87, transliteration: "Al-A'la", englishMeaning: 'The Most High', arabicName: 'الأعلى', totalAyahs: 19),
  SurahData(number: 88, transliteration: 'Al-Ghashiyah', englishMeaning: 'The Overwhelming', arabicName: 'الغاشية', totalAyahs: 26),
  SurahData(number: 89, transliteration: 'Al-Fajr', englishMeaning: 'The Dawn', arabicName: 'الفجر', totalAyahs: 30),
  SurahData(number: 90, transliteration: 'Al-Balad', englishMeaning: 'The City', arabicName: 'البلد', totalAyahs: 20),
  SurahData(number: 91, transliteration: 'Ash-Shams', englishMeaning: 'The Sun', arabicName: 'الشمس', totalAyahs: 15),
  SurahData(number: 92, transliteration: 'Al-Layl', englishMeaning: 'The Night', arabicName: 'الليل', totalAyahs: 21),
  SurahData(number: 93, transliteration: 'Ad-Duha', englishMeaning: 'The Morning Hours', arabicName: 'الضحى', totalAyahs: 11),
  SurahData(number: 94, transliteration: 'Ash-Sharh', englishMeaning: 'The Relief', arabicName: 'الشرح', totalAyahs: 8),
  SurahData(number: 95, transliteration: 'At-Tin', englishMeaning: 'The Fig', arabicName: 'التين', totalAyahs: 8),
  SurahData(number: 96, transliteration: "Al-'Alaq", englishMeaning: 'The Clot', arabicName: 'العلق', totalAyahs: 19),
  SurahData(number: 97, transliteration: 'Al-Qadr', englishMeaning: 'The Power', arabicName: 'القدر', totalAyahs: 5),
  SurahData(number: 98, transliteration: 'Al-Bayyinah', englishMeaning: 'The Clear Proof', arabicName: 'البينة', totalAyahs: 8),
  SurahData(number: 99, transliteration: 'Az-Zalzalah', englishMeaning: 'The Earthquake', arabicName: 'الزلزلة', totalAyahs: 8),
  SurahData(number: 100, transliteration: "Al-'Adiyat", englishMeaning: 'The Courser', arabicName: 'العاديات', totalAyahs: 11),
  SurahData(number: 101, transliteration: "Al-Qari'ah", englishMeaning: 'The Calamity', arabicName: 'القارعة', totalAyahs: 11),
  SurahData(number: 102, transliteration: 'At-Takathur', englishMeaning: 'The Rivalry in World Increase', arabicName: 'التكاثر', totalAyahs: 8),
  SurahData(number: 103, transliteration: "Al-'Asr", englishMeaning: 'The Declining Day', arabicName: 'العصر', totalAyahs: 3),
  SurahData(number: 104, transliteration: 'Al-Humazah', englishMeaning: 'The Traducer', arabicName: 'الهمزة', totalAyahs: 9),
  SurahData(number: 105, transliteration: 'Al-Fil', englishMeaning: 'The Elephant', arabicName: 'الفيل', totalAyahs: 5),
  SurahData(number: 106, transliteration: 'Quraysh', englishMeaning: 'Quraysh', arabicName: 'قريش', totalAyahs: 4),
  SurahData(number: 107, transliteration: "Al-Ma'un", englishMeaning: 'Small Kindnesses', arabicName: 'الماعون', totalAyahs: 7),
  SurahData(number: 108, transliteration: 'Al-Kawthar', englishMeaning: 'Abundance', arabicName: 'الكوثر', totalAyahs: 3),
  SurahData(number: 109, transliteration: 'Al-Kafirun', englishMeaning: 'The Disbelievers', arabicName: 'الكافرون', totalAyahs: 6),
  SurahData(number: 110, transliteration: 'An-Nasr', englishMeaning: 'The Help', arabicName: 'النصر', totalAyahs: 3),
  SurahData(number: 111, transliteration: 'Al-Masad', englishMeaning: 'The Palm Fiber', arabicName: 'المسد', totalAyahs: 5),
  SurahData(number: 112, transliteration: 'Al-Ikhlas', englishMeaning: 'The Sincerity', arabicName: 'الإخلاص', totalAyahs: 4),
  SurahData(number: 113, transliteration: 'Al-Falaq', englishMeaning: 'The Daybreak', arabicName: 'الفلق', totalAyahs: 5),
  SurahData(number: 114, transliteration: 'An-Nas', englishMeaning: 'Mankind', arabicName: 'الناس', totalAyahs: 6),
];

int getJuzForSurah(int surahNum) {
  if (surahNum == 1) return 1;
  if (surahNum == 2) return 1;
  if (surahNum == 3) return 3;
  if (surahNum == 4) return 4;
  if (surahNum == 5) return 6;
  if (surahNum == 6) return 7;
  if (surahNum == 7) return 8;
  if (surahNum == 8) return 9;
  if (surahNum == 9) return 10;
  if (surahNum <= 11) return 11;
  if (surahNum == 12) return 12;
  if (surahNum <= 14) return 13;
  if (surahNum == 15) return 14;
  if (surahNum == 16) return 14;
  if (surahNum == 17) return 15;
  if (surahNum == 18) return 15;
  if (surahNum <= 20) return 16;
  if (surahNum <= 22) return 17;
  if (surahNum <= 25) return 18;
  if (surahNum <= 27) return 19;
  if (surahNum <= 29) return 20;
  if (surahNum <= 32) return 21;
  if (surahNum <= 34) return 22;
  if (surahNum <= 36) return 22;
  if (surahNum <= 38) return 23;
  if (surahNum <= 41) return 24;
  if (surahNum <= 45) return 25;
  if (surahNum <= 50) return 26;
  if (surahNum <= 57) return 27;
  if (surahNum <= 66) return 28;
  if (surahNum <= 77) return 29;
  return 30; // Surah 78-114 are in Juz 30
}
