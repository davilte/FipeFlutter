import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Consulta FIPE';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title, style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: MyItemView(),
      ),
    );
  }
}

class MyItemView extends StatelessWidget {
  var list;
  var stage = 1;
  var brand;
  var model;
  var modalVisible = false;
  var car;

  void choose(codigo) {
    if (stage == 1) {
      selectBrand(codigo);
    } else if (stage == 2) {
      selectYear(codigo);
    } else if (stage == 3) {
      getPrice(codigo);
    }
  }

  Future<List<Car>> getBrands() async {
    var response =
        await Dio().get('https://parallelum.com.br/fipe/api/v1/carros/marcas');

    if (response.statusCode == 200) {
      print(response);

      var listCars = (response.data as List).map((e) {
        return Car.fromJson(e);
      }).toList();
      list = listCars;
      return listCars;
    } else {
      throw Exception();
    }
  }

  Future<List<Car>> selectBrand(codigo) async {
    var response = await Dio().get(
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/' +
            codigo +
            '/modelos');

    if (response.statusCode == 200) {
      print(response);

      var listCars = (response.data as List).map((e) {
        return Car.fromJson(e);
      }).toList();

      return listCars;
    } else {
      throw Exception();
    }
  }

  Future<List<Car>> selectYear(codigo2) async {
    var response = await Dio().get(
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/' +
            codigo2 +
            '/modelos');

    if (response.statusCode == 200) {
      print(response);

      var listCars = (response.data as List).map((e) {
        return Car.fromJson(e);
      }).toList();

      return listCars;
    } else {
      throw Exception();
    }
  }

  Future<List<Car>> getPrice(codigo3) async {
    var response = await Dio().get(
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/' +
            codigo3 +
            '/modelos');

    if (response.statusCode == 200) {
      print(response);

      var listCars = (response.data as List).map((e) {
        return Car.fromJson(e);
      }).toList();

      return listCars;
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
        future: getBrands(),
        builder: (context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return ListTile(
                    title: Text(item.nome.toString()),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class Car {
  String? nome;
  String? codigo;

  Car({required this.nome, required this.codigo});

  Car.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    codigo = json['codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    return data;
  }
}
