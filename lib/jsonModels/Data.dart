import 'Links.dart';

class Data {
  int id;
  String commonName;
  String slug;
  String scientificName;
  int year;
  String bibliography;
  String author;
  String status;
  String rank;
  String familyCommonName;
  int genusId;
  String imageUrl;
  List<String> synonyms;
  String genus;
  String family;
  Links links;

  Data(
      {this.id,
        this.commonName,
        this.slug,
        this.scientificName,
        this.year,
        this.bibliography,
        this.author,
        this.status,
        this.rank,
        this.familyCommonName,
        this.genusId,
        this.imageUrl,
        this.synonyms,
        this.genus,
        this.family,
        this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commonName = json['common_name'];
    slug = json['slug'];
    scientificName = json['scientific_name'];
    year = json['year'];
    bibliography = json['bibliography'];
    author = json['author'];
    status = json['status'];
    rank = json['rank'];
    familyCommonName = json['family_common_name'];
    genusId = json['genus_id'];
    imageUrl = json['image_url'];
    synonyms = json['synonyms'].cast<String>();
    genus = json['genus'];
    family = json['family'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['common_name'] = this.commonName;
    data['slug'] = this.slug;
    data['scientific_name'] = this.scientificName;
    data['year'] = this.year;
    data['bibliography'] = this.bibliography;
    data['author'] = this.author;
    data['status'] = this.status;
    data['rank'] = this.rank;
    data['family_common_name'] = this.familyCommonName;
    data['genus_id'] = this.genusId;
    data['image_url'] = this.imageUrl;
    data['synonyms'] = this.synonyms;
    data['genus'] = this.genus;
    data['family'] = this.family;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}