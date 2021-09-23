class Offre {
  String _ref;
  String _societe;
  String _fonction;
  String _lieu;
  String _validite;
  String _nbrePoste;

  Offre(
    this._ref,
    this._societe,
    this._fonction,
    this._lieu,
    this._validite,
    this._nbrePoste,
  );

  Offre.fromMap(dynamic obj) {
    //this._id=obj['id'];

    this._ref = obj['reference_offre'].toString().toUpperCase();
    this._societe = obj['societe'].toString().toUpperCase();
    this._fonction = obj['fonction'].toString().toUpperCase();
    this._lieu = obj['lieu_travail'].toString().toUpperCase();
    this._validite = obj['validite_offre'].toString().toUpperCase();
    this._nbrePoste = obj['nbre_poste'].toString().toUpperCase();
  }

  factory Offre.fromJson(json) {
    return Offre(
      json['reference_offre'] as String,
      json['ref_sssociete'] as String,
      json['fonction'] as String,
      json['lieu_travail'] as String,
      json['validite_offre'] as String,
      json['nbre_poste'] as String,
    );
  }

  String get reference => _ref;
  String get societe => _societe;
  String get fonction => _fonction;
  String get lieu => _lieu;
  String get validite => _validite;
  String get nbreposte => _nbrePoste;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["reference_offre"] = _ref;
    map["societe"] = _societe;
    map["fonction"] = _fonction;
    map["lieu_travail"] = _lieu;
    map["validite_offre"] = _validite;
    map["nbre_poste"] = _nbrePoste;

    return map;
  }
}
