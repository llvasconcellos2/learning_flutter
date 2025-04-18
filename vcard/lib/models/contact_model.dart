const String tableContact = 'contacts';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColMobile = 'mobile';
const String tblContactColEmail = 'email';
const String tblContactColAddress = 'address';
const String tblContactColCompany = 'company';
const String tblContactColDesignation = 'designation';
const String tblContactColWebsite = 'website';
const String tblContactColPhone = 'phone';
const String tblContactColImage = 'image';
const String tblContactColFavorite = 'favorite';

class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String address;
  String company;
  String designation;
  String website;
  String phone;
  String image;
  bool favorite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.email = '',
    this.address = '',
    this.company = '',
    this.designation = '',
    this.website = '',
    this.phone = '',
    this.image = '',
    this.favorite = false,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
    id: map[tblContactColId],
    name: map[tblContactColName],
    mobile: map[tblContactColMobile],
    email: map[tblContactColEmail],
    address: map[tblContactColAddress],
    company: map[tblContactColCompany],
    designation: map[tblContactColDesignation],
    website: map[tblContactColWebsite],
    phone: map[tblContactColPhone],
    image: map[tblContactColImage],
    favorite: map[tblContactColFavorite] == 1 ? true : false,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColName: name,
      tblContactColMobile: mobile,
      tblContactColEmail: email,
      tblContactColAddress: address,
      tblContactColCompany: company,
      tblContactColDesignation: designation,
      tblContactColWebsite: website,
      tblContactColPhone: phone,
      tblContactColImage: image,
      tblContactColFavorite: favorite ? 1 : 0,
    };

    if (id > 0) {
      map[tblContactColId] = id;
    }

    return map;
  }
}
