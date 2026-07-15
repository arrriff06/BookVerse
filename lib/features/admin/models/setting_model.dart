class SettingModel {
  final String appName;
  final String logo;
  final String banner;
  final String supportEmail;
  final String supportPhone;
  final String website;
  final String facebook;
  final String instagram;
  final String youtube;

  final int membershipPrice;
  final int borrowDays;
  final int finePerDay;

  const SettingModel({
    required this.appName,
    required this.logo,
    required this.banner,
    required this.supportEmail,
    required this.supportPhone,
    required this.website,
    required this.facebook,
    required this.instagram,
    required this.youtube,
    required this.membershipPrice,
    required this.borrowDays,
    required this.finePerDay,
  });

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      appName: map["appName"] ?? "",
      logo: map["logo"] ?? "",
      banner: map["banner"] ?? "",
      supportEmail: map["supportEmail"] ?? "",
      supportPhone: map["supportPhone"] ?? "",
      website: map["website"] ?? "",
      facebook: map["facebook"] ?? "",
      instagram: map["instagram"] ?? "",
      youtube: map["youtube"] ?? "",
      membershipPrice: map["membershipPrice"] ?? 0,
      borrowDays: map["borrowDays"] ?? 0,
      finePerDay: map["finePerDay"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "appName": appName,
      "logo": logo,
      "banner": banner,
      "supportEmail": supportEmail,
      "supportPhone": supportPhone,
      "website": website,
      "facebook": facebook,
      "instagram": instagram,
      "youtube": youtube,
      "membershipPrice": membershipPrice,
      "borrowDays": borrowDays,
      "finePerDay": finePerDay,
    };
  }
}