class SurahModel{
  String? surahName;
  String? surahJoza;
  String? surahHazb;
  String? pageImage;
  String pageNumber='0';
  String? pageSide;
  String? text;

  SurahModel( String? surahName,
  String? surahJoza,
  String? surahHazb,
  String? pageImage,
  String PageNumber,
  String? PageSide,
  String? text
      ){
    this.surahName= surahName;
    this.surahJoza=  surahJoza;
    this.surahHazb=  surahHazb;
    this.pageImage=  pageImage;
    this.pageNumber=  PageNumber;
    this.pageSide=  PageSide;
    this.text=text;
  }

}

