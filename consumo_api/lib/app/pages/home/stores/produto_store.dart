import 'package:consumo_api/app/data/http/exceptions.dart';
import 'package:consumo_api/app/data/models/produto_model.dart';
import 'package:consumo_api/app/data/repositories/produto_repository.dart';
import 'package:flutter/material.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;
    try {
      final result = await repository.getProducts();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
