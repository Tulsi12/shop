import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/Helpers/DeBouncer.dart';
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/Response/ImagesProductsResponse.dart';
import 'package:restaurant/Models/Response/ProductsTopHomeResponse.dart';
import 'package:restaurant/Models/Response/ResponseDefault.dart';
import 'package:restaurant/Services/url.dart';

class ProductsController {
  final debouncer = DeBouncer(duration: Duration(milliseconds: 800));
  final StreamController<List<Productsdb>> _streamController =
      StreamController<List<Productsdb>>.broadcast();
  Stream<List<Productsdb>> get searchProducts => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  Future<ResponseDefault> addNewProduct(
      String name,
      String description,
      String price,
      List<XFile> images,
      String category,
      String brand,
      String quantity) async {
    final token = await secureStorage.readToken();
    var request =
        await http.post(Uri.parse('${URLS.URL_API}/products'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'brand': brand,
      'quantity': quantity
    });
    return ResponseDefault.fromJson(jsonDecode(request.body));
  }

  Future<List<Productsdb>> getProductsTopHome() async {
    final token = await secureStorage.readToken();

    final response = await http.get(Uri.parse('${URLS.URL_API}/products'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    return ProductsTopHomeResponse.fromJson(jsonDecode(response.body))
        .productsdb;
  }

  Future<String> getImagesProducts(String id) async {
    final response = id;
    return response;
  }

  void searchProductsForName(String productName) async {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final token = await secureStorage.readToken();

      final response = await http.get(
          Uri.parse('${URLS.URL_API}/search-product-for-name/' + productName),
          headers: {'Accept': 'application/json', 'xx-token': token!});

      final listProduct =
          ProductsTopHomeResponse.fromJson(jsonDecode(response.body))
              .productsdb;

      this._streamController.add(listProduct);
    };
    final timer =
        Timer(Duration(milliseconds: 200), () => debouncer.value = productName);
    Future.delayed(Duration(milliseconds: 400)).then((_) => timer.cancel());
  }

  Future<List<Productsdb>> searchPorductsForCategory(String idCategory) async {
    print(idCategory);
    final token = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse('${URLS.URL_API}/products/' +
            idCategory +
            '/get-product-by-category'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    return ProductsTopHomeResponse.fromJson(jsonDecode(resp.body)).productsdb;
  }

  Future<List<Productsdb>> listProductsAdmin() async {
    final token = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse('${URLS.URL_API}/products/list-porducts-admin'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    return ProductsTopHomeResponse.fromJson(jsonDecode(resp.body)).productsdb;
  }

  Future<ResponseDefault> updateStatusProduct(
      String idProduct, String status) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${URLS.URL_API}/update-status-product'),
        headers: {'Accept': 'application/json', 'xx-token': token!},
        body: {'idProduct': idProduct, 'status': status});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> deleteProduct(String idProduct) async {
    final token = await secureStorage.readToken();
    final resp = await http
        .delete(Uri.parse('${URLS.URL_API}/products/' + idProduct), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }
}

final productController = ProductsController();
