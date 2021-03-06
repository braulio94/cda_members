
class Member {

  String beltColor;
  int concludedProjects;
  Object disponibilities;
  String id;
  String name;
  String email;
  String photoUri;
  Object programmingLangs;
  Object technologies;


  Member(this.beltColor, this.id, this.name, this.photoUri, this.email);

  Member.fromJson(Map value){
    beltColor = value["beltColor"];
    concludedProjects = value["concludedProjects"];
    disponibilities = value["disponibilities"];
    id = value["id"];
    name = value["name"];
    photoUri = value["photoUri"];
    programmingLangs = value["programmingLangs"];
    technologies = value["technologies"];
    email = value["email"];
  }

}