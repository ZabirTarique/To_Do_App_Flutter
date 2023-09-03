class TaskTag{
  String? name;

  TaskTag( {
    this.name,
  });

  factory TaskTag.fromJson(Map<String?, dynamic> json){
    return TaskTag(
        name: json["name"],
    );
  }
  factory TaskTag.fromMap(Map<String, dynamic> map) {
    return TaskTag(
      name: map['sn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;

    return data;
  }
}