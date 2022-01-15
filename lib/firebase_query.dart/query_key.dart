class UserKey {
  static const userId = 'userId';
  static const userName = 'userName';
  static const userMail = 'userMail';
  static const userProfile = 'userProfile';
  static const userImage = 'userImage';
  static const userImageHash = 'userImageHash';
  static const userSearch = 'userSearch';
  static const userPhone = 'userPhone';
  static const onlineStatus = 'onlineStatus';
  static const userAlamat = 'userAlamat';
}

class Col {
  static const users = 'Users';
  static const shop = 'Shop';
  static const product = 'Product';
  static const productList = 'ProductList';
  static const onlineStatus = 'OnlineStatus';
  static const friends = 'Friends';
  static const cart = 'Cart';
  static const cartItem = 'CartItem';
  static const shopList = 'ShopList';
  static const orderList = 'OrderList';
  static const chatRoom = 'ChatRoom';
  static const friendList = 'FriendList';
  static const allChats = 'AllChats';
  static const chatData = 'ChatData';
  static const isInRoom = 'IsInRoom';
  static const productSearch = 'ProductSearch';
  static const incomingOrder = 'IncomingOrder';
  static const outComingOrder = 'OutComingOrder';
  static const order = 'Order';
}

class ProdKey {
  static const productId = 'productId';
}

class ShopKey {
  static const shopDesc = 'shopDesc';
  static const shopImage = 'shopImage';
  static const shopImageAs = 'shopImageAs';
  static const shopName = 'shopName';
}

getChatRoomId(String? a, String? b) {
  if (a!.substring(0, 1).codeUnitAt(0) > b!.substring(0, 1).codeUnitAt(0)) {
    return b + "_" + a;
  } else {
    return a + "_" + b;
  }
}

List<String> generateStringKey(String? data) {
  List<String> caseSearchList = [''];
  String temp = "";
  for (int i = 0; i < data!.length; i++) {
    temp = (temp + data[i]).toLowerCase();
    caseSearchList.add(temp);
  }
  return caseSearchList;
}
