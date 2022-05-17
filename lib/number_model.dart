class Number {
  late String number;
  late String content;

  Number(this.number, this.content);

  Number.fromJson(Map<dynamic, dynamic> json) {
    number = json['number'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['content'] = content;
    return data;
  }
}
