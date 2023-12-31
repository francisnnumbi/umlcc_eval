class Account {
  late final String? avatar;
  late final String? accountNr;
  late final String? name;
  late final bool? active;
  late final String? type;

  Account({
    this.avatar,
    this.accountNr,
    this.name,
    this.active,
    this.type,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      avatar: json['avatar'] != null ? json['avatar'].toString() : "",
      accountNr:
          json['account_nr'] != null ? json['account_nr'].toString() : "",
      name: json['name'] != null ? json['name'].toString() : "",
      active: json['active'] ?? false,
      type: json['type'] != null ? json['type'].toString() : "",
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['account_nr'] = accountNr;
    data['name'] = name;
    data['active'] = active;
    data['type'] = type;
    return data;
  }

  String activeToString() {
    return active! ? 'Active' : 'Inactive';
  }

  @override
  String toString() {
    return 'Account{avatar: $avatar, accountNr: $accountNr, name: $name, active: $active, type: $type}';
  }
}
