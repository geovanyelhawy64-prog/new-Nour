enum CopticMonth {
  tout(1, 'توت', 'Ⲑⲱⲟⲩⲧ', 'Thout'),
  baba(2, 'بابه', 'Ⲡⲁⲟⲡⲓ', 'Paopi'),
  hator(3, 'هاتور', 'Ⲁⲑⲱⲣ', 'Hathor'),
  kiahk(4, 'كيهك', 'Ⲭⲟⲓⲁⲕ', 'Kiahk'),
  toba(5, 'طوبة', 'Ⲧⲱⲃⲓ', 'Tobi'),
  amshir(6, 'أمشير', 'Ⲙⲉϣⲓⲣ', 'Meshir'),
  baramhat(7, 'برمهات', 'Ⲡⲁⲣⲉⲙϩⲟⲧⲡ', 'Paremhat'),
  baramouda(8, 'برمودة', 'Ⲫⲁⲣⲙⲟⲩⲑⲓ', 'Paremoude'),
  bashans(9, 'بشنس', 'Ⲡⲁϣⲟⲛⲥ', 'Pashons'),
  paona(10, 'بؤونة', 'Ⲡⲁⲱⲛⲓ', 'Paoni'),
  epip(11, 'أبيب', 'Ⲉⲡⲓⲡ', 'Epip'),
  mesra(12, 'مسرى', 'Ⲙⲉⲥⲱⲣⲏ', 'Mesori'),
  nasie(13, 'النسيء', 'Ⲡⲓⲕⲟⲩϫⲓ', 'Nasie');

  final int number;
  final String nameAr;
  final String nameCoptic;
  final String nameEn;

  const CopticMonth(this.number, this.nameAr, this.nameCoptic, this.nameEn);

  static CopticMonth fromNumber(int number) {
    assert(number >= 1 && number <= 13, 'Month must be between 1 and 13');
    return CopticMonth.values[number - 1];
  }
}
