enum TransactionType { income, expense }

class TransactionModel {
  final int id;
  final String title;
  final String subtitle;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String category;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    final String typeString =
        json["type"]?.toString() ?? "expense";

    return TransactionModel(
      id: json["id"] as int,
      title: json["title"]?.toString() ?? "",
      subtitle: json["subtitle"]?.toString() ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
      type: typeString.toLowerCase() == "income"
          ? TransactionType.income
          : TransactionType.expense,
      date: DateTime.parse(json["date"].toString()),
      category: json["category"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "amount": amount,
      "type": type.name,
      "date": date.toIso8601String(),
      "category": category,
    };
  }
}