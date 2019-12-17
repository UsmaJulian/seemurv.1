import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:shared_preferences/shared_preferences.dart';

class RangoPreciosPage extends StatefulWidget {
  @override
  _RangoPreciosPageState createState() => _RangoPreciosPageState();
}

class _RangoPreciosPageState extends State<RangoPreciosPage> {
  // List of RangeSliders to use, together with their parameters
  List<RangeSliderData> rangeSliders;

  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  @override
  void initState() {
    super.initState();
    rangeSliders = _rangeSliderDefinitions();
  }

  @override
  Widget build(BuildContext context) {
	  return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
        child: Column(children: <Widget>[]..addAll(_buildRangeSliders())),
      ),
    );
  }

  double miLower;
  double miUpper;
  
  List<Widget> _buildRangeSliders() {
	  List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
	      setState(() {
         
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
          setValuesSlider(lower, upper);
          
          
        });
      }));
    }

    return children;
  }

  List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0, max: 240.0, lowerValue: 10.0, upperValue: 240.0),
    ];
  }


  Future<List<double>> getSelectedRangoPrecios() async {
	  SharedPreferences prefs = await SharedPreferences.getInstance();
	  List<double> listRangoPrecio = [];
	
	  miUpper = await prefs.getDouble('max');
	  miLower = await prefs.getDouble('min');
	
	  listRangoPrecio.add(miLower);
	  listRangoPrecio.add(miUpper);
	
	  print('menor: ' + miLower.toString());
	  print('mayor: ' + miUpper.toString());
	  print(listRangoPrecio.toString());
	
	
	  return listRangoPrecio;
  }

  void setValuesSlider(double lower, double upper) async {
	  SharedPreferences prefs = await SharedPreferences.getInstance();
	  await prefs.setDouble('max', upper);
	  await prefs.setDouble('min', lower);
  }
}

class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xfff8c300);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0xff16202c);
  static const Color defaultThumbColor = const Color(0xff16202c);
  static const Color defaultValueIndicatorColor = const Color(0xff16202c);
  static const Color defaultOverlayColor = const Color(0xff16202c);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  Widget build(BuildContext context, frs.RangeSliderCallback callback) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(lowerValueText,
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff16202c),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                overlayColor: overlayColor,
                activeTickMarkColor: activeTickMarkColor,
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                trackHeight: 6.0,
                thumbColor: thumbColor,
                valueIndicatorColor: valueIndicatorColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: frs.RangeSlider(
                min: min,
                max: max,
                lowerValue: lowerValue,
                upperValue: upperValue,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 60.0,
              maxWidth: 60.0,
            ),
            child: Text(upperValueText,
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff16202c),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )),
          ),
        ],
      ),
    );
  }
}
