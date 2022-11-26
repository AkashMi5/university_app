class UniversityModel {
  String? country;
  List<String>? domains;
  List<String>? webPages;
  String? alphaTwoCode;
  String? name;
  String? stateProvince;

  UniversityModel(
      {this.country,
      this.domains,
      this.webPages,
      this.alphaTwoCode,
      this.name,
      this.stateProvince});

  UniversityModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    domains = json['domains'].cast<String>();
    webPages = json['web_pages'].cast<String>();
    alphaTwoCode = json['alpha_two_code'];
    name = json['name'];
    stateProvince = json['state-province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['country'] = country;
    data['domains'] = domains;
    data['web_pages'] = webPages;
    data['alpha_two_code'] = alphaTwoCode;
    data['name'] = name;
    data['state-province'] = stateProvince;
    return data;
  }

  Map<String, dynamic> toLocalJson() {
    final Map<String, dynamic> data = {};
    data['country'] = country;
    data['domains'] = domains!.join('_');
    data['web_pages'] = webPages!.join('_');
    data['alpha_two_code'] = alphaTwoCode;
    data['name'] = name;
    data['state_province'] = stateProvince;
    return data;
  }
}
