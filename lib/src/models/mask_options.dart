class MaskOptions {
  final bool moneyMask;
  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;
  final String mask;

  MaskOptions({
    this.moneyMask = false,
    this.mask = '',
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    this.rightSymbol = '',
    this.leftSymbol = '',
    this.precision = 2,
  }) : assert((moneyMask == true && mask.length == 0) || (moneyMask == false && mask.length != 0));
}