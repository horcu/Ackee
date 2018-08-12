import 'dart:collection';

import 'package:flutter/material.dart';
import 'item_reviews_page.dart';
import 'dart:math' as math;

//enums
enum BetLevel {Start, PlayType, PlayResult, PlayResultDetails, PlayCost , Done}
var PlayTypeTheme = new CircleAvatarTheme(disabledColor: Colors.grey, backgroundColor: Colors.grey[200], selectedColor: Colors.black, avatarBackgroundColor: Colors.amber[800], avatarForegroundColor: Colors.white);
var PlayResultsTheme = new CircleAvatarTheme(disabledColor: Colors.grey, backgroundColor: Colors.grey[200], selectedColor: Colors.black, avatarBackgroundColor: Colors.indigo[800], avatarForegroundColor: Colors.white);
var PlayResultsDetailsTheme = new CircleAvatarTheme(disabledColor: Colors.grey, backgroundColor: Colors.grey[200], selectedColor: Colors.black, avatarBackgroundColor: Colors.blue[800], avatarForegroundColor: Colors.white);
var PlayCostTheme = new CircleAvatarTheme(disabledColor: Colors.grey, backgroundColor: Colors.grey[200], selectedColor: Colors.black, avatarBackgroundColor: Colors.green[800], avatarForegroundColor: Colors.white);


//main page
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
  static const String routeName = '/Landing';
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showBottomSheetCallback;

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
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: themeData.disabledColor))),
              child: new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Row(
                  children: <Widget>[],
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
                  Text('beclothed.com',
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
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showBottomSheet,
                  color: Colors.black38),
              Padding(
                padding: EdgeInsets.only(left: 64.0),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.grey[400],
                    size: 16.0,
                  ),
                  Text('\$ 25', style: TextStyle(color: Colors.green)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child:
                        Text('\$ 200', style: TextStyle(color: Colors.green)),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.message),
                onPressed: _showBottomSheet,
                color: Colors.black38,
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            SinglePlay(),
            Spacer(),
            BetPocket(onBetChanged: (bool value) {},),
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
                              Padding(padding: EdgeInsets.only(top: 40.0)),
                              Text(_getPlayDescription(),
                                  style: TextStyle(
                                      fontFamily: 'Monsterrat-Thin',
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0)),
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
  var betChanged = false;
  final ValueChanged<bool> onBetChanged;

  BetPocket({Key key, this.betChanged: false, @required this.onBetChanged})
      : super(key: key);

  @override
  _BetPocketState createState() => _BetPocketState();
  static const String routeName = '/Bet';
}

class _BetPocketState extends State<BetPocket> {
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
  bool FifteenSelected = false;
  bool TwentyYdsSelected = false;
  bool FumbleRecovered = false;
  bool FumbleLossed = false;
  bool TwentyFiveYdsSelected = false;
  bool ThirtyYdsSelected = false;
  bool FiftyYdsSelected = false;
  bool CompletionSelected = false;
  bool ReturnTouchdownSelected = false;
  bool LossSelected = false;
  bool RunSelected = false;
  bool PassSelected = false;
  bool PlayactionSelected = false;
  bool TurnoverSelected = false;
  bool TouchdownSelected = false;
  bool PlayTypeSelected = false;
  bool IncompletionSelected = false;
  bool ScoreSelected = false;
  bool BlockSelected = false;

  List<Widget> defList;
  List<Widget> runList;
  List<Widget> passList;
  List<Widget> playActionList;
  List<Widget> puntList;
  List<Widget> fieldGoalList;
  List<Widget> kickList;
  List<Widget> ydsList;
  List<Widget> retList;
  List<Widget> sackList;
  List<Widget> fumbleList;
  BetLevel _betLevel = BetLevel.Start;

  List<bool> selections = new List<bool>();

  Widget betOptionsList ;
  LinkedHashMap<String, Widget> betPocketList;

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
                      child: _getBetPocketList()
                      ),
                      Spacer(),
                      SizedBox.fromSize(
                      size: Size.fromHeight(200.0),
                      child: betOptionsList != null ? betOptionsList :  new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getDefaultList(),
                      ),),
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

  _getBetPocketList() {

      betPocketList = new LinkedHashMap<String, Widget>();

     if(PassSelected) {
       var t = PlayTypeTheme;
       t.label = 'Pass';
       t.isSelected = PassSelected;
       t.icon = Icon(Icons.directions_run, color: Colors.white);
       betPocketList['play_type'] = _buildCircleAvatar(t);
     }

    if(RunSelected) {
      var t = PlayTypeTheme;
      t.label = 'Run';
      t.isSelected = RunSelected;
      t.icon = Icon(Icons.directions_walk, color: Colors.white);
      betPocketList['play_type'] = _buildCircleAvatar(t);
    }

    if(PlayactionSelected) {
      var t = PlayTypeTheme;
      t.label = 'Play Action';
      t.isSelected = PlayactionSelected;
      t.icon = Icon(Icons.directions, color: Colors.white);
      betPocketList['play_type'] = _buildCircleAvatar(t);
    }

    if(FifteenSelected) {
      var t = PlayCostTheme;
      t.label = '15 yds +';
      t.isSelected = FifteenSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_yds'] = _buildCircleAvatar(t);
    }

    if(TwentyYdsSelected) {
      var t = PlayCostTheme;
      t.label = '20 yds +';
      t.isSelected = TwentyYdsSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_yds'] = _buildCircleAvatar(t);
    }

    if(TwentyFiveYdsSelected) {
      var t = PlayCostTheme;
      t.label = '25 yds +';
      t.isSelected = TwentyFiveYdsSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_yds'] = _buildCircleAvatar(t);
    }

    if(ThirtyYdsSelected) {
      var t = PlayCostTheme;
      t.label = '30 yds +';
      t.isSelected = ThirtyYdsSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_yds'] = _buildCircleAvatar(t);
    }

    if(FortyYdsSelected) {
      var t = PlayTypeTheme;
      t.label = '40 yds +';
      t.isSelected = FortyYdsSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_yds'] = _buildCircleAvatar(t);
    }

    if(FiftyYdsSelected) {
      var t = PlayCostTheme;
      t.label = '50 yds +';
      t.isSelected = FiftyYdsSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_yds'] = _buildCircleAvatar(t);
    }

    if(RushTouchdownSelected) {
      var t = PlayResultsTheme;
      t.label = 'Rush TD';
      t.isSelected = RushTouchdownSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }

    if(PassTouchdownSelected) {
      var t = PlayResultsTheme;
      t.label = 'Pass TD';
      t.isSelected = PassTouchdownSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }

    if(FirstDownSelected) {
      var t = PlayResultsTheme;
      t.label = 'FirstDown';
      t.isSelected = FirstDownSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }

    if(PersonalFoulSelected) {
      var t = PlayResultsTheme;
      t.label = 'Person Foul';
      t.isSelected = PersonalFoulSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }
    if(PersonalFoulSelected) {
      var t = PlayResultsTheme;
      t.label = 'Score';
      t.isSelected = ScoreSelected;
      t.icon = Icon(Icons.arrow_upward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }


    if(FumbleSelected) {
      var t = PlayResultsTheme;
      t.label = 'Fumble';
      t.isSelected = FortyYdsSelected;
      t.isSelected = FumbleSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }

    if(SackSelected) {
      var t = PlayResultsTheme;
      t.label = 'Sack';
      t.isSelected = SackSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }
    if(BlockSelected) {
      var t = PlayResultsTheme;
      t.label = 'Block';
      t.isSelected = BlockSelected;
      t.icon = Icon(Icons.arrow_drop_up, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }

    if(PuntSelected) {
      var t = PlayResultsTheme;
      t.label = 'Punt';
      t.isSelected = PuntSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }
    if(SafetySelected) {
      var t = PlayResultsTheme;
      t.label = 'Safety';
      t.isSelected = SafetySelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }
    if(InterceptionSelected) {
      var t = PlayResultsTheme;
      t.label = 'Interception';
      t.isSelected = InterceptionSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_result'] = _buildCircleAvatar(t);
    }
    if(KickPuntSelected) {
      var t = PlayTypeTheme;
      t.label = 'Kick / Punt';
      t.isSelected = KickPuntSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_type'] = _buildCircleAvatar(t);
    }
    if(FieldGoalSelected) {
      var t = PlayTypeTheme;
      t.label = 'Field Goal';
      t.isSelected = FieldGoalSelected;
      t.icon = Icon(Icons.arrow_forward, color: Colors.white);
      betPocketList['play_type'] = _buildCircleAvatar(t);
    }

      List<Widget> wids = new List<Widget>();
      betPocketList.values.forEach((item) => wids.add(item));

      wids.add(new Spacer());
      wids.add(new AnimatedOpacity(
        opacity: PlayTypeSelected ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: Padding(

        padding: const EdgeInsets.all(0.0),
        child: new RaisedButton.icon(
          splashColor: Colors.grey[100],
          textColor: Colors.grey[800],
          color: Colors.grey[100],
          shape: CircleBorder(side: BorderSide.none),
          icon: Icon(Icons.clear),
          label: Text(''),
          elevation: 0.0,
          onPressed: ()=>  setState(() => (
                _resetBetLevel()),
            ),
          ),// n),ew Text('2'),
        ),
    ));
//      wids.add(new AnimatedOpacity(
//      opacity: _betLevel == BetLevel.Done ? 1.0 : 0.0,
//      duration: Duration(milliseconds: 300),
//      child: Padding(
//        padding: const EdgeInsets.only(right: 16.0),
//        child: new RaisedButton.icon(
//          splashColor: Colors.grey[100],
//          color: Colors.grey[100],
//          icon: Icon(Icons.check),
//          label: Text(''),
//          elevation: 0.0,
////          child: Icon(
////            Icons.arrow_back,
////            color: Colors.grey[600],
////          ),
//          onPressed: ()=>  setState(() => (
//              _lockInBet()),
//          ),
//        ),// n),ew Text('2'),
//      ),
//    ));

    return new Row(
      children: wids
    );
  }

  _resetBetLevel(){
    print('resetting selections');
    _betLevel = BetLevel.Start;

    PlayTypeSelected = false;
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
    FifteenSelected = false;
    TwentyYdsSelected = false;
    FumbleRecovered = false;
    FumbleLossed = false;
    TwentyFiveYdsSelected = false;
    ThirtyYdsSelected = false;
    FiftyYdsSelected = false;
    CompletionSelected = false;
    LossSelected = false;
    RunSelected = false;
    PassSelected = false;
    PlayactionSelected = false;
    TurnoverSelected = false;
    TouchdownSelected = false;
    IncompletionSelected = false;
    ScoreSelected = false;
    BlockSelected = false;

    betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getDefaultList());
  }

  List<Widget> _getPlayActionList(){
    print('getting pass list');
    var pList = new List<Widget>();
    var passTheme = new CircleAvatarTheme();
    passTheme.isSelected = CompletionSelected;
    passTheme.icon = Icon(Icons.arrow_upward);

    passTheme.label = 'Completion';
    passTheme.onSel = (selected) =>  setState(() => _completionClicked(selected));
    pList.add(_buildChoiceChip(passTheme));

    var pTheme2 = passTheme;
    pTheme2.label = 'Incompletion';
    pTheme2.onSel = (selected) =>  setState(() => _incompleteClicked(selected));
    pTheme2.isSelected = IncompletionSelected;
    pList.add(_buildChoiceChip(pTheme2));

    var pTheme3 = pTheme2;
    pTheme3.label = 'Sack';
    pTheme3.onSel = (selected) =>  setState(() => _sackClicked(selected));
    pTheme3.isSelected = SackSelected;
    pList.add(_buildChoiceChip(pTheme3));

    var pTheme4 = pTheme3;
    pTheme4.label = 'Fumble';
    pTheme4.onSel = (selected) =>  setState(() => _fumbleClicked(selected) );
    pTheme4.isSelected = FumbleSelected;
    pList.add(_buildChoiceChip(pTheme4));

    var pTheme5 = pTheme4;
    pTheme5.label = '1st Down';
    pTheme5.onSel = (selected) =>  setState(() => _firstDownClicked(selected));
    pTheme5.isSelected = FirstDownSelected;
    pList.add(_buildChoiceChip(pTheme5));

    var pTheme6 = pTheme5;
    pTheme6.label = 'Score';
    pTheme6.onSel = (selected) =>  setState(() => _scoreClicked(selected));
    pTheme6.isSelected = ScoreSelected;
    pList.add(_buildChoiceChip(pTheme6));

    playActionList = pList;
    return pList;
  }

  List<Widget> _getFumbleList() {
    var fList = new List<Widget>();

    var fumbleTheme = PlayTypeTheme;
    fumbleTheme.onSel = (selected) =>  setState(() => _getYardageList());
    fumbleTheme.isSelected = FumbleRecovered;
    fumbleTheme.icon = Icon(Icons.ac_unit);
    fumbleTheme.label = 'Recovered';
    fList.add(_buildChoiceChip(fumbleTheme));

    var fumbleLostTheme = PlayTypeTheme;
    fumbleLostTheme.onSel = (selected) =>  setState(() => _getYardageList());
    fumbleLostTheme.isSelected = FumbleLossed;
    fumbleLostTheme.icon = Icon(Icons.ac_unit);
    fumbleLostTheme.label = 'Lost';
    fList.add(_buildChoiceChip(fumbleLostTheme));

    fumbleList = fList;
    return fList;
  }

  List<Widget> _getSackList() {
     var sList = new List<Widget>();

     var sackTheme = PlayTypeTheme;
     sackTheme.onSel = (selected) =>  setState(() => _getSackList());
     sackTheme.isSelected = FumbleSelected;
     sackTheme.icon = Icon(Icons.border_clear);
     sackTheme.label = 'Fumble';
     sList.add(_buildChoiceChip(sackTheme));

     var ydsLostTheme = PlayTypeTheme;
     ydsLostTheme.onSel = (selected) =>  setState(() => _getFumbleList());
     ydsLostTheme.isSelected = LossSelected;
     ydsLostTheme.icon = Icon(Icons.border_clear);
     sackTheme.label = 'Yds Lost';
     sList.add(_buildChoiceChip(ydsLostTheme));


     sackList = sList;
    return sList;
  }

  List<Widget> _getReturnList() {
    var rList = new List<Widget>();
    rList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Ret 20 yds +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    rList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Ret 40 yds +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FortyYdsSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    rList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Ret TD',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: ReturnTouchdownSelected,
      onSelected: (selected) => setState(
              () => ReturnTouchdownSelected = selected),
    ));

    retList = rList;
    return rList;
  }

  List<Widget> _getYardageList() {
    var yList = new List<Widget>();
    yList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(FifteenSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '15 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FifteenSelected,
      onSelected: (selected) => setState(
              () => FifteenSelected = selected),
    ));
    yList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '20 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    yList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(TwentyFiveYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '25 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyFiveYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyFiveYdsSelected = selected),
    ));
    yList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(ThirtyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '30 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: ThirtyYdsSelected,
      onSelected: (selected) => setState(
              () => ThirtyYdsSelected = selected),
    ));
    yList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(FiftyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '50 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FiftyYdsSelected,
      onSelected: (selected) => setState(
              () => FiftyYdsSelected = selected),
    ));
    yList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(LossSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Loss',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: LossSelected,
      onSelected: (selected) => setState(
              () => LossSelected = selected),
    ));

    ydsList = yList;
    return yList;
  }

  List<Widget> _getKickList() {
     var kList = new List<Widget>();
    kList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Kick off',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    kList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Onside kick',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));

    kickList = kList;
    return kList;
  }

  List<Widget> _getPuntList() {
    var pList = new List<Widget>();
    pList = _getReturnList();
    pList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Punt block',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));

    puntList = pList;
    return pList;
  }

  List<Widget> _getFieldGoalList() {
    var fGoalList = new List<Widget>();
    fGoalList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fg good',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    fGoalList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fg no good',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    fGoalList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'ret TD',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));

    fieldGoalList = fGoalList;
    return fGoalList;
  }

  List<Widget> _getPassList() {
    print('getting pass list');
     var pList = new List<Widget>();
     var passTheme = PlayTypeTheme;
     passTheme.isSelected = CompletionSelected;
     passTheme.icon = Icon(Icons.arrow_upward);

     passTheme.label = 'Completion';
     passTheme.onSel = (selected) =>  setState(() => _completionClicked(selected));
     pList.add(_buildChoiceChip(passTheme));

     var pTheme2 = passTheme;
     pTheme2.label = 'Incompletion';
     pTheme2.onSel = (selected) =>  setState(() => _incompleteClicked(selected));
     pTheme2.isSelected = IncompletionSelected;
    passTheme.icon = Icon(Icons.swap_vert);
     pList.add(_buildChoiceChip(pTheme2));

     var pTheme3 = pTheme2;
     pTheme3.label = 'Sack';
     pTheme3.onSel = (selected) =>  setState(() => _sackClicked(selected));
     pTheme3.isSelected = SackSelected;
    passTheme.icon = Icon(Icons.speaker_notes);
     pList.add(_buildChoiceChip(pTheme3));

     var pTheme4 = pTheme3;
     pTheme4.label = 'Fumble';
     pTheme4.onSel = (selected) =>  setState(() => _fumbleClicked(selected) );
     pTheme4.isSelected = FumbleSelected;
    passTheme.icon = Icon(Icons.add_to_home_screen);
     pList.add(_buildChoiceChip(pTheme4));

     var pTheme5 = pTheme4;
     pTheme5.label = '1st Down';
     pTheme5.onSel = (selected) =>  setState(() => _firstDownClicked(selected));
     pTheme5.isSelected = FirstDownSelected;
    passTheme.icon = Icon(Icons.alarm_add);
     pList.add(_buildChoiceChip(pTheme5));

     var pTheme6 = pTheme5;
     pTheme6.label = 'Score';
     pTheme6.onSel = (selected) =>  setState(() => _scoreClicked(selected));
     pTheme6.isSelected = ScoreSelected;
    passTheme.icon = Icon(Icons.audiotrack);
     pList.add(_buildChoiceChip(pTheme6));

    passList = pList;
    return pList;
  }

  List<Widget> _getRunList() {
    print('getting run list');
    var rList = new List<Widget>();
    rList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Turnover',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    rList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fumble',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    rList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blueGrey[400],
        foregroundColor: Colors.white,
        child: Icon(FirstDownSelected ? Icons.check : Icons.all_out,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        '1st Down',
        style: new TextStyle(
            color: Colors.blueGrey[400]),
      ),
      selected: FirstDownSelected,
      onSelected: (selected) => setState(
              () => FirstDownSelected = selected),
    ));
    rList.add(new ChoiceChip(
      disabledColor: Colors.lime[800],
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blueGrey[400],
        foregroundColor: Colors.white,
        child: Icon(FirstDownSelected ? Icons.check : Icons.all_out,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Score',
        style: new TextStyle(
            color: Colors.blueGrey[400]),
      ),
      selected: ScoreSelected,
      onSelected: (selected) => setState(
              () => ScoreSelected = selected),
    ));

    runList = rList;
    return rList;
  }

  List<Widget> _getDefaultList() {
    var dList = new List<Widget>();
    var runTheme = PlayTypeTheme;
    runTheme.onSel = (selected) =>  setState(() => _runClicked(selected));
    runTheme.isSelected = RunSelected;
    runTheme.icon = Icon(Icons.directions_run);
    runTheme.label = 'Run';
    dList.add(_buildChoiceChip(runTheme));

    var passTheme = PlayTypeTheme;
   passTheme.label = 'Pass';
    passTheme.icon = Icon(Icons.directions_walk);
   passTheme.isSelected = PassSelected;
   passTheme.avatarBackgroundColor = Colors.red;
   passTheme.onSel = (selected) =>  setState(() => _passClicked(selected));
    dList.add(_buildChoiceChip(passTheme));

   var playAction = PlayTypeTheme;
   playAction.label = 'playAction';
   playAction.isSelected = PlayactionSelected;
   playAction.icon = Icon(Icons.directions);
    passTheme.avatarBackgroundColor = Colors.blueGrey;
   playAction.onSel = (selected) => setState( () => _playActionCLicked(selected) );
    dList.add(_buildChoiceChip(playAction));

    var KickPuntReturn = PlayTypeTheme;
    KickPuntReturn.label = 'Kick/Punt Return';
    KickPuntReturn.isSelected = KickPuntSelected;
    KickPuntReturn.icon = Icon(Icons.speaker_notes);
    KickPuntReturn.avatarBackgroundColor = Colors.lightGreen;
    KickPuntReturn.onSel = (selected) => setState(() => _kickPuntClicked(selected) );
    dList.add(_buildChoiceChip(KickPuntReturn));

    var kick = PlayTypeTheme;
    kick.label = 'Kick';
    kick.isSelected = KickSelected;
    kick.icon = Icon(Icons.airline_seat_flat);
    kick.avatarBackgroundColor = Colors.yellow[800];
    kick.onSel = (selected) => setState( () => _kickClicked(selected) );
    dList.add(_buildChoiceChip(kick));

    var punt = PlayTypeTheme;
    punt.label = 'Punt';
    punt.isSelected = PuntSelected;
    punt.icon = Icon(Icons.airline_seat_flat);
    punt.avatarBackgroundColor = Colors.lime[400];
    punt.onSel = (selected) => setState(() => _puntClicked(selected));
    dList.add(_buildChoiceChip(punt));

    var fieldGoal = PlayTypeTheme;
    fieldGoal.label = 'Field Goal';
    fieldGoal.isSelected = FieldGoalSelected;
    fieldGoal.icon = Icon(Icons.swap_vertical_circle);
    fieldGoal.avatarBackgroundColor = Colors.brown[200];
    fieldGoal.onSel = (selected) => setState( () => _fieldGoalClicked(selected));
    dList.add(_buildChoiceChip(fieldGoal));

    defList = dList;
    return dList;
  }

  List<Widget> _getBlockList() {
    var blockList = new List<Widget>();
    blockList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        child: Icon(RunSelected ? Icons.check : Icons.directions_run,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Loss',
        style: new TextStyle(color: Colors.grey),
      ),
      selected: RunSelected,
      onSelected: (selected) => setState(() => _getYardageList()),
    ));
    blockList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon(
            PassSelected
                ? Icons.check
                : Icons.directions_walk,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Recovered',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: PassSelected,
      onSelected: (selected) =>  setState(() => _getYardageList()),
    ));
    return blockList;
  }


  _buildCircleAvatar(CircleAvatarTheme theme){

   return new CircleAvatar(
        backgroundColor: theme.avatarBackgroundColor,
        foregroundColor: theme.avatarForegroundColor,
        child: theme.icon, // new Text('2'),
      );
  }

  _buildChoiceChip(CircleAvatarTheme theme){

    return new ChoiceChip(
      disabledColor: theme.disabledColor,
      selectedColor: theme.selectedColor,
      backgroundColor: theme.backgroundColor,
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: theme.avatarBackgroundColor,
        foregroundColor: theme.avatarForegroundColor,
        child: theme.icon, // new Text('2'),
      ),
      label: new Text( theme.label, style: new TextStyle(color: Colors.grey),
      ),
      selected: theme.isSelected,
      onSelected: theme.onSel,
    );

  }

  _lockInBet() {}

  _scoreClicked(bool selected) {

    print('score clicked');
    setState(() {
      ScoreSelected = selected;
      betOptionsList =new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getYardageList());
      PlayTypeSelected = true;
    });
  }

  _firstDownClicked(bool selected) {

    print('firstdown clicked');
    setState(() {
      FirstDownSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getYardageList());
      PlayTypeSelected = true;
    });
  }

  _fumbleClicked(bool selected) {
    print('fumble clicked');
    setState(() {
      FumbleSelected = selected ;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getFumbleList());
      PlayTypeSelected = true;
    });
  }

  _sackClicked(bool selected) {

    print('sack clicked');
    setState(() {
      SackSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getYardageList());
      PlayTypeSelected = true;
    });
  }

  _incompleteClicked(bool selected) {

    print('incompletion clicked');
    setState(() {
      IncompletionSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getEmptyList());
      PlayTypeSelected = true;
    });
  }

  _completionClicked(bool selected) {

    print('completion clicked');
    setState(() {
      CompletionSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getYardageList());
      PlayTypeSelected = true;
    });

  }

  _fieldGoalClicked(bool selected) {

    print('fg clicked');
    setState(() {
      FieldGoalSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getFieldGoalList());
      PlayTypeSelected = true;
    });

  }

  _puntClicked(bool selected) {

    print('punt clicked');
    setState(() {
      PuntSelected = selected;
      betOptionsList =  new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getPuntList());
      PlayTypeSelected = true;
    });
  }

  _kickClicked(bool selected) {

    print('kick clicked');
    setState(() {
      KickSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getKickList());
      PlayTypeSelected = true;
    });
  }

  _kickPuntClicked(bool selected) {

    print('kick / punt clicked');
    setState(() {
      KickPuntSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getKickPuntList());
      PlayTypeSelected = true;
    });
  }

  _playActionCLicked(bool selected) {
    print('pa clicked');

    setState(() {
      PlayactionSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getPlayActionList());
      PlayTypeSelected = true;
    });
  }

  _runClicked(bool selected) {
    print('run clicked');

    setState(() {
      RunSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getRunList());
      PlayTypeSelected = true;
    });
  }

  _passClicked(bool selected) {
    print('pass clicked');
    setState(() {

      PassSelected = selected;
      betOptionsList = new Wrap(runSpacing: 10.0, spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.start, children: _getPassList());
      PlayTypeSelected = true;
    });
  }

  _getEmptyList() {
    return new List<Widget>();
  }

  _getKickPuntList() {
    return _getEmptyList();
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


  CircleAvatarTheme({this.disabledColor, this.backgroundColor, this.selectedColor, this.avatarBackgroundColor, this.avatarForegroundColor});


}
