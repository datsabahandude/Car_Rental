class OrderModel {
  // String? uid;
  String? oid;
  int? time;
  String? range;
  String? status;
  String? price;
  String? info;
  String? img;
  OrderModel(
      {
      // this.uid,
      this.oid,
      this.time,
      this.range,
      this.status,
      this.price,
      this.info,
      this.img});

  //retrieve data from server
  factory OrderModel.fromMap(map) {
    return OrderModel(
      // uid: map['uid'],
      oid: map['oid'],
      time: map['time'],
      range: map['range'],
      status: map['status'],
      price: map['price'],
      info: map['info'],
      img: map['image url'],
    );
  }
//send data to server
  Map<String, dynamic> toMap() {
    return {
      // 'uid': uid,
      'oid': oid,
      'time': time,
      'range': range,
      'status': status,
      'price': price,
      'info': info,
      'image url': img,
    };
  }
}
