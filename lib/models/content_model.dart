class ContentModel{
  String? surahNumber;
  String? surahName;
  String? ayaNumber;
  String? surahTypeImage;
  int surahStartPage=0;


  ContentModel({
  String? surahNumber,
  String? surahName,
  String? ayaNumber,
  String? surahTypeImage,
  int surahStartPage=0
}){
    this.surahName=surahName;
    this.surahNumber=surahNumber;
    this.ayaNumber=ayaNumber;
    this.surahTypeImage=surahTypeImage;
    this.surahStartPage=surahStartPage;
  }

}