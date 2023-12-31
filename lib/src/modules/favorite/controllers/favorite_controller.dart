import 'package:get/get.dart';
import 'package:shop_app/src/controller/app_controller.dart';
import 'package:shop_app/src/modules/favorite/repositories/favorite_repository.dart';

import '../../../models/product_model.dart';

import 'package:dio/dio.dart' as diox;

import '../../../public/components.dart';
import '../../../public/constants.dart';
import '../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';

class FavoriteController extends GetxController {
  final FavoriteRepository favoriteRepository;
  FavoriteController(this.favoriteRepository);

  @override
  void onInit() {
    fetchProductFavorites();
    super.onInit();
  }

  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  List<ProductModel> carts = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel> productFavorites = [];

  Future<void> fetchProductFavorites() async {
    try {
      _isLoading = true;
      diox.Response response = await favoriteRepository.fetchProductFavorites();

      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          List rawData = response.data;
          productFavorites =
              rawData.map((e) => ProductModel.fromMap(e)).toList();

          for (var i = 0; i < productFavorites.length; i++) {
            _cart.getCartList().forEach(
              (element) {
                if (productFavorites[i].id == element.id) {
                  cartProducts.putIfAbsent(
                    productFavorites[i].id,
                    () => element.userQuant!,
                  );
                } else {
                  cartProducts.putIfAbsent(
                    productFavorites[i].id,
                    () {
                      return 0;
                    },
                  );
                }
              },
            );
            // if (_cart.items.containsKey(productFavorites[i].id)) {
            //   cartProducts.putIfAbsent(
            //     productFavorites[i].id,
            //     () => _cart.getQuantity(
            //       productFavorites[i],
            //     ),
            //   );
            // } else {
            //   cartProducts.putIfAbsent(
            //     productFavorites[i].id,
            //     () {
            //       return 0;
            //     },
            //   );
            // }
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showSnackBar(title: "Favorites", e.toString());
    }
  }

  void changeMealFavorite(String mealId) async {
    try {
      productFavorites.removeWhere((element) => element.id == mealId);
      update();
      diox.Response response =
          await favoriteRepository.changeMealFavorite(mealId);

      AppConstants.handleApi(
        response: response,
        onSuccess: () {},
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Change Meal Favorite");
    }
  }

  ///////

  final Rx<int> _quantity = 0.obs;
  Rx<int> get quantity => _quantity;

  Map<String?, int> cartProducts = {}; // id , quantity

  CartController _cart = AppGet.CartGet;

  void setQuantity(bool isIncrement, ProductModel product) {
    if (isIncrement) {
      cartProducts[product.id] =
          checkQuantity(cartProducts[product.id]! + 1, product.quantity);
    } else {
      cartProducts[product.id] =
          checkQuantity(cartProducts[product.id]! - 1, product.quantity);
    }
    update();
  }

  int checkQuantity(int quantity, int productQuantity) {
    if (quantity < 0) {
      Components.showSnackBar(
        title: "Item count",
        "You can't reduce more !",
      );
      return 0;
    } else if (quantity > productQuantity) {
      Components.showSnackBar(
        title: "Item count",
        "You ordered more than the available quantity !",
      );
      return productQuantity;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, cartProducts[product.id]!);
    cartProducts[product.id] = _cart.getQuantity(product);
    update();
  }

  void addItems(List<ProductModel> products) {
    for (var i = 0; i < products.length; i++) {
      _cart.addItem(products[i], cartProducts[products[i].id]!);
      cartProducts[products[i].id] = _cart.getQuantity(products[i]);
    }
    isSelectionMode = false;
    update();
  }

  void onTap(
    bool isSelected,
    int index,
    ProductModel product,
  ) {
    if (isSelectionMode) {
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
      if (selectedFlag[index] == true) {
        cartProducts[product.id] = cartProducts[product.id]! + 1;
        carts.add(product);
      } else {
        cartProducts[product.id] = cartProducts[product.id]! - 1;
      }
      update();
    } else {
      AppNavigator.push(
        AppRoutes.DETAILS_PRODUCT_RATING,
        arguments: {
          'product': product,
          'ratings': product.ratings,
        },
      );
    }
  }

  void onLongPress(
    bool isSelected,
    int index,
    ProductModel product,
  ) {
    selectedFlag[index] = !isSelected;
    isSelectionMode = selectedFlag.containsValue(true);
    cartProducts[product.id] = cartProducts[product.id]! + 1;
    carts
      ..clear()
      ..add(product);
    update();
  }

  void changeIsSelectedMode() {
    isSelectionMode = selectedFlag.containsValue(true);
    update();
  }
}
