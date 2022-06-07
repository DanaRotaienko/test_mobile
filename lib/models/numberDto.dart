class NumberDto {
  final int? id;
  final String number;

  NumberDto(
      { this.id,
        required this.number,});

  factory NumberDto.fromMap(Map<String, dynamic> json) => NumberDto(
    id: json['id'],
    number: json['number'],
  );

  Map<String, dynamic> toMap() {
    return {
    'id': id,
    'number': number};
  }
}