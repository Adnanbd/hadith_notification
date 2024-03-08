const baseUrl = 'https://cdn.jsdelivr.net/gh/md-rifatkhan/hadithbangla@main';

const bukhari = '/Bukhari/Chapter/1.json';
const muslim = '/Muslim/Chapter/1.json';
const abuDaud = '/AbuDaud/Chapter/1.json';
const nasai = '/Al-Nasai/Chapter/1.json';
const tirmidzi = '/At-tirmizi/Chapter/1.json';
const majah = '/Majah/Chapter/1.json';

String bukhariHadith(int no) {
  return '$baseUrl/Bukhari/hadith/$no.json';
}

String muslimHadith(int no) {
  return '$baseUrl/Muslim/hadith/$no.json';
}

String abuDaudHadith(int no) {
  return '$baseUrl/AbuDaud/hadith/$no.json';
}

String nasaiHadith(int no) {
  return '$baseUrl/Al-Nasai/hadith/$no.json';
}

String tirmidziHadith(int no) {
  return '$baseUrl/At-tirmizi/hadith/$no.json';
}

const excludeHadithKey = 'excludeHadithKey';
