class AboutUsModel {
  dynamic aboutCompany;
  dynamic agreementConditionTerms;
  dynamic facebook;
  dynamic twitter;
  dynamic whatsApp;
  dynamic instegram;
  dynamic privacyPolicy;

  AboutUsModel({
    this.aboutCompany,
    this.agreementConditionTerms,
    this.facebook,
    this.twitter,
    this.whatsApp,
    this.instegram,
    this.privacyPolicy,
  });

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    aboutCompany = json['aboutCompany'];
    agreementConditionTerms = json['agreementConditionTerms'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instegram = json['instegram'];
    privacyPolicy = json['privacyPolicy'];
  }
}
