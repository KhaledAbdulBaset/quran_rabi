class SearchModel{
  String? surahName;
  String? aya;
  int pageNumber=0;
  SearchModel({String? surahName, String? aya,int pageNumber=0}){
    this.surahName=surahName;
    this.aya=aya;
    this.pageNumber=pageNumber;
  }
}