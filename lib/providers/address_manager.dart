import 'package:flutter/material.dart';

class Address {
  final String id;
  final String title;
  final String name;
  final String address;
  final bool selected;

  const Address({
    required this.id,
    required this.title,
    required this.name,
    required this.address,
    this.selected = false,
  });

  Address copyWith({
    String? id,
    String? title,
    String? name,
    String? address,
    bool? selected,
  }) {
    return Address(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      address: address ?? this.address,
      selected: selected ?? this.selected,
    );
  }
}

class AddressManager extends ValueNotifier<List<Address>> {
  static final AddressManager _instance = AddressManager._internal();
  factory AddressManager() => _instance;

  AddressManager._internal() : super([
    const Address(
      id: "1",
      title: "Home",
      name: "Akash Pandey",
      address: "House No. 101\nSector 62\nNoida, Uttar Pradesh - 201309",
      selected: true,
    ),
    const Address(
      id: "2",
      title: "Office",
      name: "Akash Pandey",
      address: "ACME Infosoft Pvt. Ltd.\nGreater Noida\nUttar Pradesh",
      selected: false,
    ),
  ]);

  Address? get selectedAddress {
    try {
      return value.firstWhere((addr) => addr.selected);
    } catch (_) {
      return value.isNotEmpty ? value.first : null;
    }
  }

  void selectAddress(String id) {
    value = value.map((addr) {
      return addr.copyWith(selected: addr.id == id);
    }).toList();
  }

  void addAddress(String title, String name, String addressText) {
    final newAddress = Address(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      name: name,
      address: addressText,
      selected: value.isEmpty, // select it if it's the only one
    );
    value = [...value, newAddress];
  }
}
