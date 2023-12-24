import 'package:intl/intl.dart';

import 'account.dart';

class User {
  late final String? avatar;
  late final String? accountNr;
  late final String? firstName;
  late final String? middleName;
  late final String? lastName;
  late final String? email;
  late final String? dialCode;
  late final String? iso2;
  late final String? iso3;
  late final String? phone;
  late final String? dob;
  late final String? type;
  late final String? lastLoginAt;
  late final String? loginCount;
  late final String? defaultLang;
  late List<Account>? accounts = [];

  User({
    this.avatar,
    this.accountNr,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.dialCode,
    this.iso2,
    this.iso3,
    this.phone,
    this.dob,
    this.type,
    this.lastLoginAt,
    this.loginCount,
    this.defaultLang,
    this.accounts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<Account> acc = [];
    if (json['accounts'] != null) {
      json['accounts'].forEach((v) {
        acc.add(Account.fromJson(v));
      });
    }
    return User(
      avatar: json['avatar'].toString(),
      accountNr: json['account_nr'].toString(),
      firstName: json['first_name'].toString(),
      middleName: json['middle_name'].toString(),
      lastName: json['last_name'].toString(),
      email: json['email'].toString(),
      dialCode: json['dial_code'].toString(),
      iso2: json['iso2'].toString(),
      iso3: json['iso3'].toString(),
      phone: json['phone'].toString(),
      dob: json['dob'].toString(),
      type: json['type'].toString(),
      lastLoginAt: json['last_login_at'].toString(),
      loginCount: json['login_count'].toString(),
      defaultLang: json['default_lang'].toString(),
      accounts: acc,
    );
  }

  String fullPhone() {
    return "+${dialCode!}${phone!}";
  }

  String fullName() {
    return "${firstName!} ${middleName!} ${lastName!}";
  }

  Account? firstAccount() {
    if (accounts!.isEmpty) {
      return null;
    }
    return accounts!.first;
  }

  String lastLoginAtFormat() {
    if (lastLoginAt == null) {
      return '';
    }
    return DateFormat("d-M-y").format(DateTime.parse(lastLoginAt!).toLocal());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['account_nr'] = accountNr;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dial_code'] = dialCode;
    data['iso2'] = iso2;
    data['iso3'] = iso3;
    data['phone'] = phone;
    data['dob'] = dob;
    data['type'] = type;
    data['last_login_at'] = lastLoginAt;
    data['login_count'] = loginCount;
    data['default_lang'] = defaultLang;
    data['accounts'] = accounts?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'User{ avatar: $avatar, accountNr: $accountNr, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, dialCode: $dialCode, iso2: $iso2, iso3: $iso3, phone: $phone, dob: $dob, type: $type, lastLoginAt: $lastLoginAt, loginCount: $loginCount, defaultLang: $defaultLang, accounts: $accounts}';
  }
}
