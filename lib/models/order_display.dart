class OrderList {
  String? oid;
  String? range;
  int? time;
  String? status;
  String? info;
  String? price;
  String? img;
  OrderList();

  Map<String, dynamic> toJson() => {
        'oid': oid,
        'range': range,
        'time': time,
        'status': status,
        'info': info,
        'price': price,
        'image url': img,
      };
  OrderList.fromSnapshot(snapshot)
      : oid = snapshot.data()['oid'],
        range = snapshot.data()['range'],
        time = snapshot.data()['time'],
        status = snapshot.data()['status'],
        info = snapshot.data()['info'],
        price = snapshot.data()['price'],
        img = snapshot.data()['image url'];
}
