class Farm {
  final String name;
  final String city;
  final String description;
  final String email;
  final String image;
  final String owner;
  final String phone;
  final String produce;
  final String province;
  final String address;

  Farm({
    required this.name, required this.city, required this.description,
    required this.email, required this.image, required this.owner,
    required this.phone, required this.produce, required this.province,
    required this.address
});

  Map<String,dynamic> toJson(){
    return {
      'name' : name ,
      'city' : city,
      'description' : description,
      'email' :email,
      'image' : image,
      'owner' : owner,
      'phone' : phone,
      'produce' : produce,
      'province' : province,
      'address' : address
    };
  }

  Farm fromJson(var map){
    return Farm(
        name:map['name'] , city: map['city'], description: map['description'],
        email:map['email'] , image: map['image'], owner: map['owner'],
        phone:map['phone'] , produce: map['produce'],
        province:map['province'] , address: map['address']);
  }
}