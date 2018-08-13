import 'dart:collection';

import 'package:flutter/material.dart';
import 'item_reviews_page.dart';
import 'dart:math' as math;

//enums
enum BetLevel { Start, Betting, Done }

var PlayTypeTheme = new CircleAvatarTheme(
    disabledColor: Colors.grey,
    backgroundColor: Colors.grey[200],
    selectedColor: Colors.black,
    avatarBackgroundColor: Colors.amber[800],
    avatarForegroundColor: Colors.white);
var PlayResultsTheme = new CircleAvatarTheme(
    disabledColor: Colors.grey,
    backgroundColor: Colors.grey[200],
    selectedColor: Colors.black,
    avatarBackgroundColor: Colors.indigo[800],
    avatarForegroundColor: Colors.white);
var PlayResultsDetailsTheme = new CircleAvatarTheme(
    disabledColor: Colors.grey,
    backgroundColor: Colors.grey[200],
    selectedColor: Colors.black,
    avatarBackgroundColor: Colors.blue[800],
    avatarForegroundColor: Colors.white);
var PlayCostTheme = new CircleAvatarTheme(
    disabledColor: Colors.grey,
    backgroundColor: Colors.grey[200],
    selectedColor: Colors.black,
    avatarBackgroundColor: Colors.green[800],
    avatarForegroundColor: Colors.white);


//main page
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
  static const String routeName = '/Landing';
}

class _LandingPageState extends State<LandingPage> {
  VoidCallback _showBottomSheetCallback;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

   void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return new Container(
            height: 285.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                  border: new Border(
                      top: new BorderSide(color: Colors.grey[200]))),
              child: new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Row(
                  children: <Widget>[
                    Text('flexin'),
                  ],
                ),
              ));
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Image
                .asset('res/nfl.png'), // Icon(Icons.nfl, color: Colors.black),
          ),
          title: Text('Patriots vs Eagles',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('raysh.io',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            child: new Flex(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: <Widget>[

              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _showBottomSheet,
                      color: Colors.black38),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child:
                        Text('up: \$ 5', style: TextStyle(color: Colors.green)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text('total: \$ 20',
                        style: TextStyle(color: Colors.grey[800])),
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: _showBottomSheet,
                    color: Colors.black38,
                  ),
                ],
              ),
            ])),
        body: Column(
          children: <Widget>[
            SinglePlay(),
            Spacer(),
            BetPocket(),
            Spacer(),
          ],
        ));
  }
}

//each play's data leads to animated result of said play
class SinglePlay extends StatefulWidget {
  @override
  _SinglePayState createState() => _SinglePayState();
  static const String routeName = '/Bet';
}

class _SinglePayState extends State<SinglePlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize(
            size: Size.fromHeight(270.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 0.0),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(0.0),
                    shadowColor: Color(0x808080ff),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// Title and rating
                          ///
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 25.0),
                                      child: Text(_getQuarter(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 20.0),
                                      child: Icon(Icons.access_time)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 5.0),
                                      child: Text(_getClockTime(),
                                          style: TextStyle())),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 45.0),
                                      child: Text(_getAwayTeam(),
                                          style:
                                              TextStyle(color: Colors.blue))),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20.0, left: 0.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(20.0),
                                        child: Material(
                                          elevation: 0.0,
                                          color: Colors.white,
                                          shadowColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          child: Icon(Icons.arrow_right),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 0.0),
                                      child: Text(_getHomeTeam(),
                                          style:
                                              TextStyle(color: Colors.green))),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 60.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(15.0),
                                        child: Material(
                                          elevation: 8.0,
                                          color: Colors.white,
                                          shadowColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          child: Image.asset('res/tb.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 30.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(15.0),
                                        child: Icon(Icons.arrow_right,
                                            color: Colors.grey, size: 28.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(15.0),
                                        child: Material(
                                          elevation: 8.0,
                                          color: Colors.white,
                                          shadowColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          child: Image.asset('res/bg.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              Text(_getPlayDescription(),
                                  style: TextStyle(
                                      fontFamily: 'Monsterrat-Thin',
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Item image
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(35.0),
                      child: Material(
                        elevation: 0.0,
                        color: Colors.indigo,
                        shadowColor: Colors.grey[300],
                        shape: CircleBorder(),
                        child: Center(
                            child: Icon(
                          Icons.blur_off,
                          color: Colors.black,
                          size: 45.0,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String _getQuarter() {
    return 'Q2';
  }

  String _getClockTime() {
    return '10:30';
  }

  String _getAwayTeam() {
    return 'PH';
  }

  String _getHomeTeam() {
    return 'NE';
  }

  String _getPlayDescription() {
    return 'T.Brady sacked at NE 26 for -4 yards (B.Graham) T.Brady FUMBLES, forced by B.Graham. Fumble RECOVERED by PHI-D.Barnett at NE 29.                                         Tackled by D.Andrews at NE 31.';
  }

  String _getPlayTypeLetter() {
    return 'F';
  }
}

//Betting section for next play, quarter, half
class BetPocket extends StatefulWidget {

  @override
  _BetPocketState createState() => _BetPocketState();
  static const String routeName = '/Bet';
}

class _BetPocketState extends State<BetPocket> with TickerProviderStateMixin {
  bool FortyYdsSelected = false;
  bool PassTouchdownSelected = false;
  bool FirstDownSelected = false;
  bool FumbleSelected = false;
  bool PersonalFoulSelected = false;
  bool SafetySelected = false;
  bool SackSelected = false;
  bool PuntSelected = false;
  bool KickSelected = false;
  bool KickPuntSelected = false;
  bool FieldGoalSelected = false;
  bool InterceptionSelected = false;
  bool RushTouchdownSelected = false;
  bool FiveYdsSelected = false;
  bool TenYdsSelected = false;
  bool FifteenYdsSelected = false;
  bool DefenseSelected = false;
  bool GainSelected = false;
  bool TwentyYdsSelected = false;
  bool FumbleRecovered = false;
  bool FumbleLossed = false;
  bool TwentyFiveYdsSelected = false;
  bool ThirtyYdsSelected = false;
  bool FiftyYdsSelected = false;
  bool CompletionSelected = false;
  bool KickReturnTouchdownSelected = false;
  bool PuntReturnTouchdownSelected = false;
  bool LossSelected = false;
  bool YdsLostSelected = false;
  bool RecoveredSelected = false;
  bool FieldGoalGoodSelected = false;
  bool FieldGoalNoGoodSelected = false;
  bool FGReturnTouchdownSelected = false;
  bool RunSelected = false;
  bool BlockLost = false;
  bool BlockRecovered = false;
  bool PassSelected = false;
  bool PlayActionSelected = false;
  bool TurnoverSelected = false;
  bool TouchdownSelected = false;
  bool PlayTypeSelected = false;
  bool IncompletionSelected = false;
  bool ScoreSelected = false;
  bool BlockSelected = false;
  bool PuntReturnSelected = false;
  bool KickoffSelected = false;
  bool OnsideSelected = false;
  bool OnsideRecoveredSelected = false;
  bool OnsideLostSelected = false;
  bool TouchBackSelected = false;
  bool OutOfBoundsSelected = false;

  bool IntReturn15PlusSelected = false;
  bool IntReturn20PlusSelected = false;
  bool IntReturn25PlusSelected = false;
  bool IntReturn30PlusSelected = false;
  bool IntReturn40PlusSelected = false;
  bool IntReturn50PlusSelected = false;
  bool IntReturnTDSelected = false;
  bool DownSelected = false;

  bool KickReturn15PlusSelected = false;
  bool KickReturn20PlusSelected = false;
  bool KickReturn25PlusSelected = false;
  bool KickReturn30PlusSelected = false;
  bool KickReturn40PlusSelected = false;
  bool KickReturn50PlusSelected = false;
  bool KickReturnTDSelected = false;

  bool PuntReturn15PlusSelected = false;
  bool PuntReturn20PlusSelected = false;
  bool PuntReturn25PlusSelected = false;
  bool PuntReturn30PlusSelected = false;
  bool PuntReturn40PlusSelected = false;
  bool PuntReturn50PlusSelected = false;
  bool PuntReturnTDSelected = false;

  bool Rush5YdsSelected = false;
  bool Rush10YdsSelected = false;
  bool Rush15YdsSelected = false;
  bool Rush20YdsSelected = false;
  bool Rush25YdsSelected = false;
  bool Rush30YdsSelected = false;
  bool Rush40YdsSelected = false;
  bool Rush50YdsSelected = false;

  bool Pass5YdsSelected = false;
  bool Pass10YdsSelected = false;
  bool Pass15YdsSelected = false;
  bool Pass20YdsSelected = false;
  bool Pass25YdsSelected = false;
  bool Pass30YdsSelected = false;
  bool Pass40YdsSelected = false;
  bool Pass50YdsSelected = false;

  List<Widget> defList;
  List<Widget> blockList;
  List<Widget> runList;
  List<Widget> passList;
  List<Widget> playActionList;
  List<Widget> puntList;
  List<Widget> fieldGoalList;
  List<Widget> kickList;
  List<Widget> onsideList;
  List<Widget> defenseList;
  List<Widget> ydsList;
  List<Widget> retList;
  List<Widget> sackList;
  List<Widget> fumbleList;
  BetLevel _betLevel;

  List<bool> selections = new List<bool>();
  Widget betOptionsList;
  Widget betOptionsSummary;

  Widget betPocketList;

  LinkedHashMap<String, Widget> selectedBets = new LinkedHashMap();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize(
            size: Size.fromHeight(270.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                /// Item description inside a material
                Container(
                  height: 50.0,
                  margin: EdgeInsets.all(0.0),
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(0.0),
                    color: Colors.grey[100],
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 3.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox.fromSize(
                              size: Size.fromHeight(50.0),
                              child: betPocketList != null
                                  ? betPocketList
                                  : new Row(
                                      children: <Widget>[
                                        Text(
                                            'click play type below to start a bet!')
                                      ],
                                    )),
                          Spacer(),
                          SizedBox.fromSize(
                            size: Size.fromHeight(220.0),
                            child: AnimatedContainer(
                              curve: ElasticInCurve(),
                              duration: new Duration(seconds: 3),
                              child: _betLevel ==
                                      BetLevel
                                          .Done //if the we;re at the last level then show the summary if not show the bet options
                                  ? betOptionsSummary
                                  : betOptionsList != null
                                      ? betOptionsList
                                      : new Wrap(
                                          runSpacing: 10.0,
                                          spacing: 10.0,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: _getDefaultList(),
                                        ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildBetPocketList() {
    List<Widget> wids = new List<Widget>();

    wids.add(new RaisedButton.icon(
      splashColor: Colors.grey[100],
      textColor: Colors.grey[800],
      color: Colors.grey[100],
      shape: CircleBorder(side: BorderSide.none),
      icon: Icon(
        Icons.refresh,
        size: 28.0,
        color: Colors.grey[600],
      ),
      label: Text(''),
      elevation: 0.0,
      onPressed: () => setState(
            () => (_resetSelections()),
          ),
    ));

    var cnt = 0;
    for (var w in selectedBets.keys) {
      wids.add(Text(w));
      if ((cnt + 1) < selectedBets.values.length) {
        wids.add(Icon(Icons.arrow_right));
        cnt++;
      }
    }

    wids.add(new Spacer());
    return new Row(children: wids);
  }

  List<Widget> _getIntReturnYdsList() {
    var rList = new List<Widget>();

    var returnTheme = PlayTypeTheme;
    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'int ret 15', Icon(Icons.border_clear), Colors.grey[200]));
    returnTheme.isSelected = IntReturn15PlusSelected;
    returnTheme.icon = Icon(Icons.border_clear);
    returnTheme.label = 'ret 15yds +';
    rList.add(_buildChoiceChip(returnTheme));

    var return2Theme = PlayTypeTheme;
    return2Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'int ret 20', Icon(Icons.border_clear), Colors.grey[200]));
    return2Theme.isSelected = IntReturn20PlusSelected;
    return2Theme.label = 'ret 20yds +';
    rList.add(_buildChoiceChip(return2Theme));

    var return3Theme = PlayTypeTheme;
    return3Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'int ret 25', Icon(Icons.border_clear), Colors.grey[200]));
    return3Theme.isSelected = IntReturn25PlusSelected;
    return3Theme.label = 'ret 25yds +';
    rList.add(_buildChoiceChip(return3Theme));

    var return4Theme = PlayTypeTheme;
    return4Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'int ret 30', Icon(Icons.border_clear), Colors.grey[200]));
    return4Theme.isSelected = IntReturn30PlusSelected;
    return4Theme.label = 'ret 30yds +';
    rList.add(_buildChoiceChip(return4Theme));

    var return8Theme = PlayTypeTheme;
    return8Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'int ret 40', Icon(Icons.border_clear), Colors.grey[200]));
    return8Theme.isSelected = IntReturn40PlusSelected;
    return8Theme.label = 'ret 40yds +';
    rList.add(_buildChoiceChip(return8Theme));

    var return5Theme = PlayTypeTheme;
    return5Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'int ret 50', Icon(Icons.border_clear), Colors.grey[200]));
    return5Theme.isSelected = IntReturn50PlusSelected;
    return5Theme.label = 'ret 50yds +';
    rList.add(_buildChoiceChip(return5Theme));

    var return7Theme = PlayTypeTheme;
    return7Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret TD', Icon(Icons.border_clear), Colors.grey[200]));
    return7Theme.isSelected = IntReturnTDSelected;
    return7Theme.label = 'ret TD';
    rList.add(_buildChoiceChip(return7Theme));

    var return9Theme = PlayTypeTheme;
    return9Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'down', Icon(Icons.border_clear), Colors.grey[200]));
    return9Theme.isSelected = DownSelected;
    return9Theme.label = 'down';
    rList.add(_buildChoiceChip(return9Theme));

    retList = rList;
    return rList;
  }

  List<Widget> _getKickReturnList() {
    var rList = new List<Widget>();

    var returnTheme = PlayTypeTheme;
    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret 15',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    returnTheme.isSelected = KickReturn15PlusSelected;
    returnTheme.icon = Icon(Icons.airline_seat_flat);
    returnTheme.avatarBackgroundColor = Colors.yellow[800];
    returnTheme.label = 'ret 15yds +';
    rList.add(_buildChoiceChip(returnTheme));

    var return2Theme = PlayTypeTheme;
    return2Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret 20',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    return2Theme.isSelected = KickReturn20PlusSelected;
    return2Theme.label = 'ret 20yds +';
    rList.add(_buildChoiceChip(return2Theme));

    var return3Theme = PlayTypeTheme;
    return3Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret 25',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    return3Theme.isSelected = KickReturn25PlusSelected;
    return3Theme.label = 'ret 25yds +';
    rList.add(_buildChoiceChip(return3Theme));

    var return4Theme = PlayTypeTheme;
    return4Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret 30',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    return4Theme.isSelected = KickReturn30PlusSelected;
    return4Theme.label = 'ret 30yds +';
    rList.add(_buildChoiceChip(return4Theme));

    var return6Theme = PlayTypeTheme;
    return6Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret 40',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    return6Theme.isSelected = KickReturn30PlusSelected;
    return6Theme.label = 'ret 40yds +';
    rList.add(_buildChoiceChip(return6Theme));

    var return5Theme = PlayTypeTheme;
    return5Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret 50',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    return5Theme.isSelected = KickReturn50PlusSelected;
    return5Theme.label = 'Ret 50yds +';
    rList.add(_buildChoiceChip(return5Theme));

    var return7Theme = PlayTypeTheme;
    return7Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'k ret TD',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    return7Theme.isSelected = KickReturnTDSelected;
    return7Theme.label = 'ret TD';
    rList.add(_buildChoiceChip(return7Theme));

    retList = rList;
    return rList;
  }

  List<Widget> _getPuntReturnList() {
    var rList = new List<Widget>();

    var returnTheme = PlayTypeTheme;
    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret 15', Icon(Icons.airline_seat_flat), Colors.lime));
    returnTheme.isSelected = PuntReturn15PlusSelected;
    returnTheme.icon = Icon(Icons.airline_seat_flat);
    returnTheme.avatarBackgroundColor = Colors.lime;
    returnTheme.label = '15yds +';
    rList.add(_buildChoiceChip(returnTheme));

    var return2Theme = PlayTypeTheme;
    return2Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret 20', Icon(Icons.airline_seat_flat), Colors.lime));
    return2Theme.isSelected = PuntReturn20PlusSelected;
    return2Theme.label = '20yds +';
    rList.add(_buildChoiceChip(return2Theme));

    var return3Theme = PlayTypeTheme;
    return3Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret 25', Icon(Icons.airline_seat_flat), Colors.lime));
    return3Theme.isSelected = PuntReturn25PlusSelected;
    return3Theme.label = '25yds +';
    rList.add(_buildChoiceChip(return3Theme));

    var return4Theme = PlayTypeTheme;
    return4Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret 30', Icon(Icons.airline_seat_flat), Colors.lime));
    return4Theme.isSelected = PuntReturn30PlusSelected;
    return4Theme.label = '30yds +';
    rList.add(_buildChoiceChip(return4Theme));

    var return6Theme = PlayTypeTheme;
    return6Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret 40', Icon(Icons.airline_seat_flat), Colors.lime));
    return6Theme.isSelected = PuntReturn40PlusSelected;
    return6Theme.label = '40yds +';
    rList.add(_buildChoiceChip(return6Theme));

    var return5Theme = PlayTypeTheme;
    return5Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret 50', Icon(Icons.airline_seat_flat), Colors.lime));
    return5Theme.isSelected = PuntReturn50PlusSelected;
    return5Theme.label = '50yds +';
    rList.add(_buildChoiceChip(return5Theme));

    var return7Theme = PlayTypeTheme;
    return7Theme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ret TD', Icon(Icons.airline_seat_flat), Colors.lime));
    return7Theme.isSelected = PuntReturnTDSelected;
    return7Theme.label = 'TD';
    rList.add(_buildChoiceChip(return7Theme));

    retList = rList;
    return rList;
  }

  List<Widget> _getYardageList() {
    var rList = new List<Widget>();

    var returnTheme = PlayTypeTheme;
    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 5', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = FiveYdsSelected;
    returnTheme.icon = Icon(Icons.border_clear);
    returnTheme.label = '5yds+';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 10', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = TenYdsSelected;
    returnTheme.label = '10yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 15', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = FifteenYdsSelected;
    returnTheme.label = '15yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 20', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = TwentyYdsSelected;
    returnTheme.label = '20yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rusht 25', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = TwentyFiveYdsSelected;
    returnTheme.label = '25yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 30', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = ThirtyYdsSelected;
    returnTheme.label = '30yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 40', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = FortyYdsSelected;
    returnTheme.label = '40yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 50', Icon(Icons.airline_seat_flat), Colors.grey[200]));
    returnTheme.isSelected = FiftyYdsSelected;
    returnTheme.label = '50yds +';
    rList.add(_buildChoiceChip(returnTheme));

    retList = rList;
    return rList;
  }

  List<Widget> _getRushYdsList() {
    var rList = new List<Widget>();

    var returnTheme = PlayTypeTheme;
    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 5', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush5YdsSelected;
    returnTheme.icon = Icon(Icons.border_clear);
    returnTheme.label = '5yds+';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 10', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush10YdsSelected;
    returnTheme.label = '10yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 15', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush15YdsSelected;
    returnTheme.label = '15yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 20', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush20YdsSelected;
    returnTheme.label = '20yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rusht 25', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush25YdsSelected;
    returnTheme.label = '25yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 30', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush30YdsSelected;
    returnTheme.label = '30yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 40', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush40YdsSelected;
    returnTheme.label = '40yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'rush 50', Icon(Icons.border_clear), Colors.blue[200]));
    returnTheme.isSelected = Rush50YdsSelected;
    returnTheme.label = '50yds +';
    rList.add(_buildChoiceChip(returnTheme));

    retList = rList;
    return rList;
  }

  List<Widget> _getPassYdsList() {
    var rList = new List<Widget>();

    var returnTheme = PlayTypeTheme;
    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 5', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass5YdsSelected;
    returnTheme.icon = Icon(Icons.border_clear);
    returnTheme.label = '5yds+';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 10', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass10YdsSelected;
    returnTheme.label = '10yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 15', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass15YdsSelected;
    returnTheme.label = '15yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 20', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass20YdsSelected;
    returnTheme.label = '20yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 25', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass25YdsSelected;
    returnTheme.label = '25yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 30', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass30YdsSelected;
    returnTheme.label = '30yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 40', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass40YdsSelected;
    returnTheme.label = '40yds +';
    rList.add(_buildChoiceChip(returnTheme));

    returnTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'pass 50', Icon(Icons.border_clear), Colors.red[200]));
    returnTheme.isSelected = Pass50YdsSelected;
    returnTheme.label = '50yds +';
    rList.add(_buildChoiceChip(returnTheme));

    retList = rList;
    return rList;
  }

  List<Widget> _getDefenseList() {
    var dList = new List<Widget>();

    var dTheme = PlayTypeTheme;
    dTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'fumble', Icon(Icons.border_clear), Colors.lightGreen));
    dTheme.isSelected = FumbleSelected;
    dTheme.icon = Icon(Icons.speaker_notes);
    dTheme.avatarBackgroundColor = Colors.lightGreen;
    dTheme.label = 'fumble';
    dList.add(_buildChoiceChip(dTheme));

    var dTheme2 = PlayTypeTheme;
    dTheme2.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'sack', Icon(Icons.border_clear), Colors.lightGreen));
    dTheme2.isSelected = SackSelected;
    dTheme2.label = 'sack';
    dList.add(_buildChoiceChip(dTheme2));

    dTheme2.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'interception', Icon(Icons.border_clear), Colors.lightGreen));
    dTheme2.isSelected = SackSelected;
    dTheme2.label = 'interception';
    dList.add(_buildChoiceChip(dTheme2));

    defenseList = dList;
    return dList;
  }

  List<Widget> _getKickList() {
    var kList = new List<Widget>();

    var koTheme = PlayTypeTheme;
    koTheme.onSel = (selected) => setState(() => _handleBetOptionClick(selected,
        'kick off', Icon(Icons.airline_seat_flat), Colors.yellow[800]));
    koTheme.isSelected = KickoffSelected;
    koTheme.icon = Icon(Icons.airline_seat_flat);
    koTheme.avatarBackgroundColor = Colors.yellow[800];
    koTheme.label = 'Kick off';
    kList.add(_buildChoiceChip(koTheme));

    koTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'onside', Icon(Icons.airline_seat_flat), Colors.yellow[800]));
    koTheme.isSelected = OnsideSelected;
    koTheme.label = 'Onside';
    kList.add(_buildChoiceChip(koTheme));

    koTheme.onSel = (selected) => setState(() => _handleBetOptionClick(selected,
        'kick return', Icon(Icons.airline_seat_flat), Colors.yellow[800]));
    koTheme.isSelected = OnsideSelected;
    koTheme.label = 'kick return';
    kList.add(_buildChoiceChip(koTheme));

    kickList = kList;
    return kList;
  }

  List<Widget> _getKickOffList() {
    var kList = new List<Widget>();

    var koTheme = PlayTypeTheme;
    koTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'touchback',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    koTheme.isSelected = TouchBackSelected;
    koTheme.icon = Icon(Icons.airline_seat_flat);
    koTheme.avatarBackgroundColor = Colors.yellow[800];
    koTheme.label = 'touchback';
    kList.add(_buildChoiceChip(koTheme));

    koTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'ob', Icon(Icons.airline_seat_flat), Colors.yellow[800]));
    koTheme.isSelected = OutOfBoundsSelected;
    koTheme.label = 'Out of bounds';
    kList.add(_buildChoiceChip(koTheme));

    kickList = kList;
    return kList;
  }

  List<Widget> _getOnsideList() {
    var kList = new List<Widget>();

    var kosTheme = PlayTypeTheme;
    kosTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'onside recovered',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    kosTheme.isSelected = OnsideRecoveredSelected;
    kosTheme.icon = Icon(Icons.airline_seat_flat);
    kosTheme.avatarBackgroundColor = Colors.yellow[800];
    kosTheme.label = 'onside recovered';
    kList.add(_buildChoiceChip(kosTheme));

    kosTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'onside lossed',
        Icon(Icons.airline_seat_flat),
        Colors.yellow[800]));
    kosTheme.isSelected = OnsideLostSelected;
    kosTheme.label = 'onside lossed';
    kList.add(_buildChoiceChip(kosTheme));

    onsideList = kList;
    return kList;
  }

  List<Widget> _getFumbleList() {
    var fList = new List<Widget>();

    var fumbleTheme = PlayTypeTheme;
    fumbleTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'recovered',
        Icon(Icons.airline_seat_flat),
        Colors.blue[800]));
    fumbleTheme.isSelected = FumbleRecovered;
    fumbleTheme.icon = Icon(Icons.ac_unit);
    fumbleTheme.label = 'Recovered';
    fList.add(_buildChoiceChip(fumbleTheme));

    var fumbleLostTheme = PlayTypeTheme;
    fumbleLostTheme.onSel = (selected) => setState(() =>
        _handleLastBetOptionClick(
            selected, 'loss', Icon(Icons.airline_seat_flat), Colors.blue[800]));
    fumbleLostTheme.isSelected = FumbleLossed;
    fumbleLostTheme.icon = Icon(Icons.ac_unit);
    fumbleLostTheme.label = 'Lost';
    fList.add(_buildChoiceChip(fumbleLostTheme));

    fumbleList = fList;
    return fList;
  }

  List<Widget> _getPlayActionList() {
    print('getting pass list');
    var pList = new List<Widget>();
    var passTheme = PlayTypeTheme;
    passTheme.isSelected = CompletionSelected;
    passTheme.icon = Icon(Icons.directions);
    passTheme.avatarBackgroundColor = Colors.blueGrey;
    passTheme.label = 'catch';
    passTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "catch", Icon(Icons.directions), Colors.blueGrey));
    pList.add(_buildChoiceChip(passTheme));

    var pTheme2 = passTheme;
    pTheme2.label = 'no catch';
    pTheme2.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, "no catch", Icon(Icons.directions), Colors.blueGrey));
    pTheme2.isSelected = IncompletionSelected;
    pList.add(_buildChoiceChip(pTheme2));

    var pTheme3 = pTheme2;
    pTheme3.label = 'Sack';
    pTheme3.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "sack", Icon(Icons.directions), Colors.blueGrey));
    pTheme3.isSelected = SackSelected;
    pList.add(_buildChoiceChip(pTheme3));

    var pTheme4 = pTheme3;
    pTheme4.label = 'Fumble';
    pTheme4.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "fumble", Icon(Icons.directions), Colors.blueGrey));
    pTheme4.isSelected = FumbleSelected;
    pList.add(_buildChoiceChip(pTheme4));

    var pTheme5 = pTheme4;
    pTheme5.label = '1st Down';
    pTheme5.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "firstdown", Icon(Icons.directions), Colors.blueGrey));
    pTheme5.isSelected = FirstDownSelected;
    pList.add(_buildChoiceChip(pTheme5));

    var pTheme6 = pTheme5;
    pTheme6.label = 'Score';
    pTheme6.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "score", Icon(Icons.directions), Colors.blueGrey));
    pTheme6.isSelected = ScoreSelected;
    pList.add(_buildChoiceChip(pTheme6));

    playActionList = pList;
    return pList;
  }

  List<Widget> _getSackList() {
    var sList = new List<Widget>();

    var sackTheme = PlayTypeTheme;
    sackTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'fumble', Icon(Icons.border_clear), Colors.grey[200]));
    sackTheme.isSelected = FumbleSelected;
    sackTheme.icon = Icon(Icons.border_clear);
    sackTheme.label = 'Fumble';
    sList.add(_buildChoiceChip(sackTheme));

    var ydsLostTheme = PlayTypeTheme;
    ydsLostTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'yds lost', Icon(Icons.border_clear), Colors.grey[200]));
    ydsLostTheme.isSelected = LossSelected;
    ydsLostTheme.icon = Icon(Icons.border_clear);
    sackTheme.label = 'Yds Lost';
    sList.add(_buildChoiceChip(ydsLostTheme));

    sackList = sList;
    return sList;
  }

  List<Widget> _getPuntList() {
    var pList = new List<Widget>();

    var puntTheme = PlayTypeTheme;
    puntTheme.icon = Icon(Icons.airline_seat_flat);
    puntTheme.avatarBackgroundColor = Colors.lime;
    puntTheme.isSelected = BlockSelected;
    puntTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'punt block', Icon(Icons.airline_seat_flat), Colors.lime));
    puntTheme.label = 'punt block';
    pList.add(_buildChoiceChip(puntTheme));

    puntTheme.isSelected = PuntReturnSelected;
    puntTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'punt return', Icon(Icons.airline_seat_flat), Colors.lime));
    puntTheme.label = 'punt return';
    pList.add(_buildChoiceChip(puntTheme));

    puntList = pList;
    return pList;
  }

  List<Widget> _getFieldGoalList() {
    var fgList = new List<Widget>();

    var fgTheme = PlayTypeTheme;
    fgTheme.icon = Icon(Icons.swap_vertical_circle);
    fgTheme.avatarBackgroundColor = Colors.pink[900];
    fgTheme.isSelected = FieldGoalGoodSelected;
    fgTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, 'fg good', Icon(Icons.airline_seat_flat), Colors.pink[900]));
    fgTheme.label = 'fg good';
    fgList.add(_buildChoiceChip(fgTheme));

    var fgngTheme = PlayTypeTheme;
    fgngTheme.isSelected = FieldGoalNoGoodSelected;
    fgngTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'fg no good',
        Icon(Icons.airline_seat_flat),
        Colors.pink[900]));
    fgngTheme.label = 'fg no good';
    fgList.add(_buildChoiceChip(fgngTheme));

    var retdTheme = PlayTypeTheme;
    retdTheme.isSelected = FGReturnTouchdownSelected;
    retdTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        'fg ret TD',
        Icon(Icons.airline_seat_flat),
        Colors.pink[900]));
    retdTheme.label = 'fg ret TD';
    fgList.add(_buildChoiceChip(retdTheme));

    fieldGoalList = fgList;
    return fgList;
  }

  List<Widget> _getPassList() {
    print('getting pass list');
    var pList = new List<Widget>();
    var passTheme = PlayTypeTheme;
    passTheme.isSelected = CompletionSelected;
    passTheme.icon = Icon(Icons.directions_walk);
    passTheme.avatarBackgroundColor = Colors.red;
    passTheme.label = 'catch';
    passTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "catch", Icon(Icons.directions_walk), Colors.red));
    pList.add(_buildChoiceChip(passTheme));

    var pTheme2 = passTheme;
    pTheme2.label = 'no catch';
    pTheme2.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected, "no catch", Icon(Icons.directions_walk), Colors.red));
    pTheme2.isSelected = IncompletionSelected;
    pList.add(_buildChoiceChip(pTheme2));

    var pTheme4 = passTheme;
    pTheme4.label = 'Fumble';
    pTheme4.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "fumble", Icon(Icons.directions_walk), Colors.red));
    pTheme4.isSelected = FumbleSelected;
    pList.add(_buildChoiceChip(pTheme4));

    var pTheme5 = pTheme4;
    pTheme5.label = '1st Down';
    pTheme5.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "firstdown", Icon(Icons.directions_walk), Colors.red));
    pTheme5.isSelected = FirstDownSelected;
    pList.add(_buildChoiceChip(pTheme5));

    var pTheme6 = pTheme5;
    pTheme6.label = 'Score';
    pTheme6.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "score", Icon(Icons.directions_walk), Colors.red));
    pTheme6.isSelected = ScoreSelected;
    pList.add(_buildChoiceChip(pTheme6));

    passList = pList;
    return pList;
  }

  List<Widget> _getRunList() {
    print('getting run list');
    var rList = new List<Widget>();

    var runTheme = PlayTypeTheme;
    runTheme.avatarBackgroundColor = Colors.blue;
    runTheme.icon = Icon(Icons.directions_run);
    runTheme.isSelected = FumbleSelected;
    runTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'fumble', Icon(Icons.directions_run), Colors.blue));
    runTheme.label = 'fumble';
    rList.add(_buildChoiceChip(runTheme));

    runTheme.isSelected = FirstDownSelected;
    runTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'gain', Icon(Icons.directions_run), Colors.blue));
    runTheme.label = 'gain';
    rList.add(_buildChoiceChip(runTheme));

    runTheme.isSelected = FirstDownSelected;
    runTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'firstdown', Icon(Icons.directions_run), Colors.blue));
    runTheme.label = 'firstdown';
    rList.add(_buildChoiceChip(runTheme));

    runTheme.isSelected = ScoreSelected;
    runTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, 'score', Icon(Icons.directions_run), Colors.blue));
    runTheme.label = 'score';
    rList.add(_buildChoiceChip(runTheme));

    runList = rList;
    return rList;
  }

  List<Widget> _getDefaultList() {
    var dList = new List<Widget>();
    var runTheme = PlayTypeTheme;
    runTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "run", Icon(Icons.directions_run), Colors.blue));
    runTheme.isSelected = RunSelected;
    runTheme.avatarBackgroundColor = Colors.blue;
    runTheme.icon = Icon(Icons.directions_run);
    runTheme.label = 'Run';
    dList.add(_buildChoiceChip(runTheme));

    var passTheme = PlayTypeTheme;
    passTheme.label = 'Pass';
    passTheme.isSelected = PassSelected;
    passTheme.icon = Icon(Icons.directions_walk);
    passTheme.avatarBackgroundColor = Colors.red;
    passTheme.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "pass", Icon(Icons.directions_run), Colors.red));
    dList.add(_buildChoiceChip(passTheme));

    var playAction = PlayTypeTheme;
    playAction.label = 'play action';
    playAction.isSelected = PlayActionSelected;
    playAction.icon = Icon(Icons.directions);
    passTheme.avatarBackgroundColor = Colors.blueGrey;
    playAction.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "pa", Icon(Icons.directions), Colors.blueGrey));
    dList.add(_buildChoiceChip(playAction));

    var KickPuntReturn = PlayTypeTheme;
    KickPuntReturn.label = 'Defense';
    KickPuntReturn.isSelected = KickPuntSelected;
    KickPuntReturn.icon = Icon(Icons.speaker_notes);
    KickPuntReturn.avatarBackgroundColor = Colors.lightGreen;
    KickPuntReturn.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "defense", Icon(Icons.speaker_notes), Colors.lightGreen));
    dList.add(_buildChoiceChip(KickPuntReturn));

    var kick = PlayTypeTheme;
    kick.label = 'Kick';
    kick.isSelected = KickSelected;
    kick.icon = Icon(Icons.airline_seat_flat);
    kick.avatarBackgroundColor = Colors.yellow[800];
    kick.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "kick", Icon(Icons.airline_seat_flat), Colors.yellow[800]));
    dList.add(_buildChoiceChip(kick));

    var punt = PlayTypeTheme;
    punt.label = 'Punt';
    punt.isSelected = PuntSelected;
    punt.icon = Icon(Icons.airline_seat_flat);
    punt.avatarBackgroundColor = Colors.lime[400];
    punt.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "punt", Icon(Icons.airline_seat_flat), Colors.lime[400]));
    dList.add(_buildChoiceChip(punt));

    var fieldGoal = PlayTypeTheme;
    fieldGoal.label = 'Field Goal';
    fieldGoal.isSelected = FieldGoalSelected;
    fieldGoal.icon = Icon(Icons.swap_vertical_circle);
    fieldGoal.avatarBackgroundColor = Colors.pink[900];
    fieldGoal.onSel = (selected) => setState(() => _handleBetOptionClick(
        selected, "fg", Icon(Icons.swap_vertical_circle), Colors.pink[900]));
    dList.add(_buildChoiceChip(fieldGoal));

    defList = dList;
    return dList;
  }

  List<Widget> _getBlockList() {
    var bList = new List<Widget>();

    var lossTheme = PlayTypeTheme;
    lossTheme.label = 'loss';
    lossTheme.onSel = (selected) => setState(() => _handleLastBetOptionClick(
        selected,
        "loss",
        Icon(Icons.swap_vertical_circle),
        Colors.indigo[200]));
    lossTheme.isSelected = BlockLost;
    bList.add(_buildChoiceChip(lossTheme));

    var recoveredTheme = PlayTypeTheme;
    recoveredTheme.label = 'recovered';
    recoveredTheme.onSel = (selected) => setState(() =>
        _handleLastBetOptionClick(selected, "recovered",
            Icon(Icons.swap_vertical_circle), Colors.deepPurple[200]));
    recoveredTheme.isSelected = BlockRecovered;
    bList.add(_buildChoiceChip(recoveredTheme));

    blockList = bList;
    return bList;
  }

  _resetSelections() {
    print('resetting selections');
    _betLevel = BetLevel.Start;
    selectedBets = new LinkedHashMap();
    FortyYdsSelected = false;
    PassTouchdownSelected = false;
    FirstDownSelected = false;
    FumbleSelected = false;
    PersonalFoulSelected = false;
    SafetySelected = false;
    SackSelected = false;
    PuntSelected = false;
    KickSelected = false;
    KickPuntSelected = false;
    FieldGoalSelected = false;
    InterceptionSelected = false;
    RushTouchdownSelected = false;
    FiveYdsSelected = false;
    TenYdsSelected = false;
    FifteenYdsSelected = false;
    DefenseSelected = false;
    GainSelected = false;
    TwentyYdsSelected = false;
    FumbleRecovered = false;
    FumbleLossed = false;
    TwentyFiveYdsSelected = false;
    ThirtyYdsSelected = false;
    FiftyYdsSelected = false;
    CompletionSelected = false;
    KickReturnTouchdownSelected = false;
    PuntReturnTouchdownSelected = false;
    LossSelected = false;
    YdsLostSelected = false;
    RecoveredSelected = false;
    FieldGoalGoodSelected = false;
    FieldGoalNoGoodSelected = false;
    FGReturnTouchdownSelected = false;
    RunSelected = false;
    BlockLost = false;
    BlockRecovered = false;
    PassSelected = false;
    PlayActionSelected = false;
    TurnoverSelected = false;
    TouchdownSelected = false;
    PlayTypeSelected = false;
    IncompletionSelected = false;
    ScoreSelected = false;
    BlockSelected = false;
    PuntReturnSelected = false;
    KickoffSelected = false;
    OnsideSelected = false;
    OnsideRecoveredSelected = false;
    OnsideLostSelected = false;
    TouchBackSelected = false;
    OutOfBoundsSelected = false;

    IntReturn15PlusSelected = false;
    IntReturn20PlusSelected = false;
    IntReturn25PlusSelected = false;
    IntReturn30PlusSelected = false;
    IntReturn40PlusSelected = false;
    IntReturn50PlusSelected = false;
    IntReturnTDSelected = false;
    DownSelected = false;

    KickReturn15PlusSelected = false;
    KickReturn20PlusSelected = false;
    KickReturn25PlusSelected = false;
    KickReturn30PlusSelected = false;
    KickReturn40PlusSelected = false;
    KickReturn50PlusSelected = false;
    KickReturnTDSelected = false;

    PuntReturn15PlusSelected = false;
    PuntReturn20PlusSelected = false;
    PuntReturn25PlusSelected = false;
    PuntReturn30PlusSelected = false;
    PuntReturn40PlusSelected = false;
    PuntReturn50PlusSelected = false;
    PuntReturnTDSelected = false;

    Rush5YdsSelected = false;
    Rush10YdsSelected = false;
    Rush15YdsSelected = false;
    Rush20YdsSelected = false;
    Rush25YdsSelected = false;
    Rush30YdsSelected = false;
    Rush40YdsSelected = false;
    Rush50YdsSelected = false;

    Pass5YdsSelected = false;
    Pass10YdsSelected = false;
    Pass15YdsSelected = false;
    Pass20YdsSelected = false;
    Pass25YdsSelected = false;
    Pass30YdsSelected = false;
    Pass40YdsSelected = false;
    Pass50YdsSelected = false;

    //reset options list
    betOptionsList = new Wrap(
        runSpacing: 10.0,
        spacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: _getDefaultList());

    //reset the bet pocket
    betPocketList = new Row(children: <Widget>[
      new Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('no bets!',
              style: TextStyle(
                  color: Colors.grey[600], fontStyle: FontStyle.italic)))
    ]);

    //reset the bet summary
    betOptionsSummary = new Wrap(
        runSpacing: 10.0,
        spacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _getSummary());
  }

  _buildCircleAvatar(CircleAvatarTheme theme) {
    return new CircleAvatar(
      backgroundColor: theme.avatarBackgroundColor,
      foregroundColor: theme.avatarForegroundColor,
      child: theme.icon,
      radius: 14.0,
      // new Text('2'),
    );
  }

  _buildChoiceChip(CircleAvatarTheme theme) {
    return new ChoiceChip(
      disabledColor: theme.disabledColor,
      selectedColor: theme.selectedColor,
      backgroundColor: theme.backgroundColor,
      labelPadding: EdgeInsets.all(6.0),
      avatar: new CircleAvatar(
        radius: 28.0,
        backgroundColor: theme.avatarBackgroundColor,
        foregroundColor: theme.avatarForegroundColor,
        child: theme.icon, // new Text('2'),
      ),
      label: new Text(
        theme.label,
        style: new TextStyle(color: Colors.grey),
      ),
      selected: theme.isSelected,
      onSelected: theme.onSel,
    );
  }

  _handleLastBetOptionClick(
      bool selected, String label, Icon icon, Color avatarColor) {
    _handleBetOptionClick(selected, label, icon, avatarColor);
    _betLevel = BetLevel.Done;
    print('bet level: ' + _betLevel.toString());
  }

  _handleBetOptionClick(
      bool selected, String label, Icon icon, Color avatarColor) {
    print(label);
    _betLevel = BetLevel.Betting;
    setState(() {
      _setSelectedByLabel(label, selected);
      _addAvatarIfNotPresent(label, icon, avatarColor);
      betOptionsList = new Wrap(
          runSpacing: 10.0,
          spacing: 10.0,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: _getListByLabel(label));

      betPocketList = _buildBetPocketList();

      betOptionsSummary = new Flex(
          verticalDirection: VerticalDirection.down,
          direction: Axis.vertical,
          children: _getSummary());
    });

    PlayTypeSelected = true;
  }

  _getListByLabel(String label) {
    switch (label) {
      case 'score':
        return _getYardageList();
      case 'firstdown':
        return _getRushYdsList();
      case 'fumble':
        return _getFumbleList();
      case 'sack':
        return _getSackList();
      case 'no catch':
        return _getEmptyList();
      case 'catch':
        return _getPassYdsList();
      case 'fg':
        return _getFieldGoalList();
      case 'punt':
        return _getPuntList();
      case 'kick':
        return _getKickList();
      case 'kick off':
        return _getKickOffList();
      case 'pa':
        return _getPlayActionList();
      case 'run':
        return _getRunList();
      case 'pass':
        return _getPassList();
      case 'block':
        return _getBlockList();
      case 'loss':
        return _getEmptyList();
      case 'yds lost':
        return _getEmptyList();
      case 'recovered':
        return _getEmptyList();
      case 'fg good':
        return _getEmptyList();
      case 'fg no good':
        return _getEmptyList();
      case 'k ret TD':
        return _getEmptyList();
      case 'p ret TD':
        return _getEmptyList();
      case 'fg ret TD':
        return _getEmptyList();
      case 'punt block':
        return _getBlockList();
      case 'kickoff':
        return _getKickList();
      case 'onside':
        return _getOnsideList();
      case 'onside recovered':
        return _getEmptyList();
      case 'onside lost':
        return _getEmptyList();
      case 'defense':
        return _getDefenseList();
      case 'kick return':
        return _getKickReturnList();
      case 'punt return':
        return _getPuntReturnList();
      case 'interception':
        return _getIntReturnYdsList();
      case 'gain':
        return _getRushYdsList();
      default:
        return _getEmptyList();
    }
  }

  _getSummary() {
    var wids = new List<Widget>();
    wids.add(Spacer());
    wids.add(Text('\$2.50',
        style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[400])));
    wids.add(Spacer());
    wids.add(RaisedButton(
      textColor: Colors.green,
      child: const Icon(Icons.check),
      onPressed: () => {},
    ));
    wids.add(Spacer());
    return wids;
  }

  _setSelectedByLabel(String label, bool selected) {
    switch (label) {
      case 'score':
        ScoreSelected = selected;
        break;
      case 'firstdown':
        FirstDownSelected = selected;
        break;
      case 'fumble':
        FumbleSelected = selected;
        break;
      case 'sack':
        SackSelected = selected;
        break;
      case 'no catch':
        IncompletionSelected = selected;
        break;
      case 'catch':
        CompletionSelected = selected;
        break;
      case 'fg':
        return FieldGoalSelected = selected;
        break;
      case 'punt':
        PuntSelected = selected;
        break;
      case 'kick':
        KickSelected = selected;
        break;
      case 'kickPunt':
        KickPuntSelected = selected;
        break;
      case 'pa':
        PlayActionSelected = selected;
        break;
      case 'run':
        RunSelected = selected;
        break;
      case 'pass':
        PassSelected = selected;
        break;
      case 'block':
        BlockSelected = selected;
        break;
      case 'loss':
        LossSelected = selected;
        break;
      case 'yds lost':
        YdsLostSelected = selected;
        break;
      case 'recovered':
        RecoveredSelected = selected;
        break;
      case 'fg good':
        FieldGoalGoodSelected = selected;
        break;
      case 'fg no good':
        FieldGoalNoGoodSelected = selected;
        break;
      case 'fg ret TD':
        FGReturnTouchdownSelected = selected;
        break;
      case 'punt block':
        BlockSelected = selected;
        break;
      case 'kickoff':
        KickoffSelected = selected;
        break;
      case 'onside':
        OnsideSelected = selected;
        break;
      case 'p ret 15':
        PuntReturn15PlusSelected = selected;
        break;
      case 'p ret 20':
        PuntReturn20PlusSelected = selected;
        break;
      case 'p ret 25':
        PuntReturn25PlusSelected = selected;
        break;
      case 'p ret 30':
        PuntReturn30PlusSelected = selected;
        break;
      case 'p ret 40':
        PuntReturn40PlusSelected = selected;
        break;
      case 'p ret 50':
        PuntReturn50PlusSelected = selected;
        break;
      case 'p ret TD':
        PuntReturnTDSelected = selected;
        break;
      case 'k ret 15':
        KickReturn15PlusSelected = selected;
        break;
      case 'k ret 20':
        KickReturn20PlusSelected = selected;
        break;
      case 'k ret 25':
        KickReturn25PlusSelected = selected;
        break;
      case 'k ret 30':
        KickReturn30PlusSelected = selected;
        break;
      case 'k ret 40':
        KickReturn40PlusSelected = selected;
        break;
      case 'k ret 50':
        KickReturn50PlusSelected = selected;
        break;
      case 'k ret TD':
        KickReturnTDSelected = selected;
        break;
      case 'int ret 15':
        IntReturn15PlusSelected = selected;
        break;
      case 'int ret 20':
        IntReturn20PlusSelected = selected;
        break;
      case 'int ret 25':
        IntReturn25PlusSelected = selected;
        break;
      case 'int ret 30':
        IntReturn30PlusSelected = selected;
        break;
      case 'int ret 40':
        IntReturn40PlusSelected = selected;
        break;
      case 'int ret 50':
        IntReturn50PlusSelected = selected;
        break;
      case 'int ret TD':
        IntReturnTDSelected = selected;
        break;
      case '20':
        TwentyYdsSelected = selected;
        break;
      case '25':
        TwentyFiveYdsSelected = selected;
        break;
      case '30':
        ThirtyYdsSelected = selected;
        break;
      case '40':
        FortyYdsSelected = selected;
        break;
      case '50':
        FiftyYdsSelected = selected;
        break;
      case '15':
        FifteenYdsSelected = selected;
        break;
      case 'defense':
        DefenseSelected = selected;
        break;
      case 'gain':
        GainSelected = selected;
        break;
    }
  }

  _getEmptyList() {
    return new List<Widget>();
  }

  _addAvatarIfNotPresent(String label, Icon icon, Color color) {
    var theme = new CircleAvatarTheme();
    theme.label = label;
    theme.avatarBackgroundColor = color;
    theme.avatarForegroundColor = Colors.grey[850];
    theme.backgroundColor = Colors.transparent;
    theme.icon = icon;
    selectedBets[label] = _buildCircleAvatar(theme);
  }
}

class CircleAvatarTheme {
  Color disabledColor;
  Color backgroundColor;
  Color selectedColor;
  Color avatarBackgroundColor;
  Color avatarForegroundColor;
  Icon icon;
  String label;
  bool isSelected;
  ValueChanged<bool> onSel;

  CircleAvatarTheme(
      {this.label,
      this.disabledColor,
      this.backgroundColor,
      this.selectedColor,
      this.avatarBackgroundColor,
      this.avatarForegroundColor});
}
