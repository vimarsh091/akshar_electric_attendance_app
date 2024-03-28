class AppVersionResponse {
  String? version;
  String? plateform;
  bool? forceUpdateable;

  AppVersionResponse({this.version, this.plateform, this.forceUpdateable});

  AppVersionResponse.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    plateform = json['plateform'];
    forceUpdateable = json['force_updateable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['plateform'] = plateform;
    data['force_updateable'] = forceUpdateable;
    return data;
  }
}
