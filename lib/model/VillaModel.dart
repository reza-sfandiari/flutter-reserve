class VillaModel {
  String _villa_rname;
  String _villa_rfamily;
  String _villa_rphone;
  String _villa_rid;
  String _villa_code;
  String _villa_subject;
  String _province;
  String _city;
  String _money;
  String _address;
  String _emkanat;
  String _min_Guest;
  String _max_Guest;
  String _rooms;
  String _floors;
  String _estate_area;
  String _spachial;
  String _longitude;
  String _latitude;
  String _text1;
  String _text2;
  String _date_update;
  String _totalvisit;
  String _image_code;
  List _image_slider;

  bool isLoad = false;
  int _liked = 0;

  VillaModel.loadMore() {
    isLoad = true;
  }


  int get liked => _liked;

  set liked(int value) {
    _liked = value;
  }

  String get villa_rname => _villa_rname;

  String get villa_rfamily => _villa_rfamily;

  List get image_slider =>  _image_slider;

  String get image_code => _image_code;

  String get totalvisit => _totalvisit;

  String get date_update => _date_update;

  String get text2 => _text2;

  String get text1 => _text1;

  String get latitude => _latitude;

  String get longitude => _longitude;

  String get spachial => _spachial;

  int get estate_area => int.parse(double.parse(_estate_area).round().toString());

  String get floors => _floors;

  String get rooms => _rooms;

  String get max_Guest => _max_Guest;

  String get min_Guest => _min_Guest;

  String get emkanat => _emkanat;

  String get address => _address;

  String get money => _money;

  String get city => _city;

  String get province => _province;

  String get villa_subject => _villa_subject;

  String get villa_code => _villa_code;

  String get villa_rid => _villa_rid;

  String get villa_rphone => _villa_rphone;

  VillaModel(
      this._villa_rname,
      this._villa_rfamily,
      this._villa_rphone,
      this._villa_rid,
      this._villa_code,
      this._villa_subject,
      this._province,
      this._city,
      this._money,
      this._address,
      this._emkanat,
      this._min_Guest,
      this._max_Guest,
      this._rooms,
      this._floors,
      this._estate_area,
      this._spachial,
      this._longitude,
      this._latitude,
      this._text1,
      this._text2,
      this._date_update,
      this._totalvisit,
      this._image_code,
      this._image_slider);

  factory VillaModel.fromJson(Map<String, dynamic> Json) {
    return VillaModel(
        Json['villa_rname'],
        Json['villa_rfamily'],
        Json['villa_rphone'],
        Json['villa_rid'],
        Json['villa_code'],
        Json['villa_subject'],
        Json['province'],
        Json['city'],
        Json['money'],
        Json['address'],
        Json['emkanat'],
        Json['min_Guest'],
        Json['max_Guest'],
        Json['rooms'],
        Json['floors'],
        Json['estate_area'],
        Json['spachial'],
        Json['longitude'],
        Json['latitude'],
        Json['text1'],
        Json['text2'],
        Json['date_update'],
        Json['totalvisit'],
        Json['image_code'],
        Json['image_slider']);
  }
}
