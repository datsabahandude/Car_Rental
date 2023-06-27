class OrderList {
  String? oid;
  String? cid;
  int? time;
  String? status;
  String? customer;
  String? price;
  String? location;
  String? img;
  OrderList();

  Map<String, dynamic> toJson() => {
        'oid': oid,
        'cid': cid,
        'time': time,
        'status': status,
        'name': customer,
        'price': price,
        'location': location,
        'image url': img,
      };
  OrderList.fromSnapshot(snapshot)
      : oid = snapshot.data()['oid'],
        cid = snapshot.data()['cid'],
        time = snapshot.data()['time'],
        status = snapshot.data()['status'],
        customer = snapshot.data()['name'],
        price = snapshot.data()['price'],
        location = snapshot.data()['location'],
        img = snapshot.data()['image url'];
}
