class Club {
  int id;
  String name;
  String code;

  Club({this.id, this.name, this.code});
  Club.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }
}

class DataMaster {
  List<Club> clubs;

  DataMaster({this.clubs});

  DataMaster.fromJson(Map<String, dynamic> json){
    if(json['clubs'] != null){
      clubs = <Club>[];
      json['clubs'].forEach((value){
        clubs.add(new Club.fromJson(value));
      });
    }
  }
}

List<Club> getClubSuggestions(String query, List<Club> clubs){
  List<Club> matchedClubs = [];

  matchedClubs.addAll(clubs);
  matchedClubs.retainWhere((club) => club.name.toLowerCase().contains(query.toLowerCase()));

  if(query == ''){
    return clubs;
  } else {
    return matchedClubs;
  }
}