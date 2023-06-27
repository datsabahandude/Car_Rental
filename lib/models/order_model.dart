class OrderModel {
  String? uid;
  String? oid;
  String? cid;
  int? time;
  String? status;
  String? customer;
  String? price;
  String? location;
  String? img;
  OrderModel(
      {this.uid,
      this.oid,
      this.cid,
      this.time,
      this.status,
      this.customer,
      this.price,
      this.location,
      this.img});

  //retrieve data from server
  factory OrderModel.fromMap(map) {
    return OrderModel(
      uid: map['uid'],
      oid: map['oid'],
      cid: map['cid'],
      time: map['time'],
      status: map['status'],
      customer: map['name'],
      price: map['price'],
      location: map['location'],
      img: map['image url'],
    );
  }
//send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'oid': oid,
      'cid': cid,
      'time': time,
      'status': status,
      'name': customer,
      'price': price,
      'location': location,
      'image url': img,
    };
  }
}
