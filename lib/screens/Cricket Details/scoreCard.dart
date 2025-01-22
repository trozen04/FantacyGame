import 'package:flutter/material.dart';
import '../../../../Utils/ImageAssets.dart';
import '../../../../Utils/flutter_font_style.dart';

class ScorecardTab extends StatelessWidget {
  final double width;
  final double height;
  final Map<String, dynamic> matchData;

  ScorecardTab({required this.width, required this.height, required this.matchData});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBattingSection(matchData["batsmen"]),
              SizedBox(height: 16),
              _buildExtrasSection(matchData["extras"]),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              _widgetTotalSection(matchData["extras"]),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              _buildYetToBatSection(matchData["yetToBat"] ?? []),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              _buildBowlingSection(matchData["bowlers"]),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              _buildFallOfWicketsSection(matchData["fallOfWickets"]),
            ],
          ),
        ),
      ),
    );
  }

  // Batting Section
  Widget _buildBattingSection(List<Map<String, dynamic>> batsmen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 0),
                  child: Text("Batter", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("R", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("B", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("4s", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("6s", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("S/R", style: FTextStyle.scoresRow),
                ),
              ],
            ),
            ...batsmen.map((batsman) {
              final isBatting = batsman["status"] == "batting";
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            batsman["image"] ?? ImageAssets.player,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                batsman["name"] ?? "Unknown",
                                style: isBatting
                                    ? FTextStyle.dateWinners
                                    : FTextStyle.notBatting,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!isBatting)
                                Text(
                                  "c ${batsman["name"]} b ${batsman["name"]}",
                                  style: FTextStyle.outBy,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (isBatting)
                                Text(
                                  "Batting",
                                  style: FTextStyle.mega,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("${batsman["runs"] ?? 0}", style: FTextStyle.dailyContestHistoryDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("${batsman["balls"] ?? 0}", style: FTextStyle.dailyContestHistoryDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("${batsman["4s"] ?? 0}", style: FTextStyle.dailyContestHistoryDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("${batsman["6s"] ?? 0}", style: FTextStyle.dailyContestHistoryDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("${batsman["sr"] ?? 0.0}", style: FTextStyle.dailyContestHistoryDate),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        Divider(

        ),
      ],
    );
  }

  // Extras Section
  Widget _buildExtrasSection(Map<String, dynamic>? extras) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Extras:", style: FTextStyle.dailyContestHistoryDate),
            Expanded(
                child: Align(
                  alignment: Alignment.center,child: Text('4', style: FTextStyle.dailyContestHistoryDate))),
          ],
        ),
        SizedBox(height: 5,),
        Text(
          "B: ${extras?["byes"] ?? 0}, LB: ${extras?["legByes"] ?? 0}, W: ${extras?["wides"] ?? 0}, NB: ${extras?["noBalls"] ?? 0}  Total: ${extras?["total"] ?? 0}",
          style: FTextStyle.extras,
        ),
      ],
    );
  }
  Widget _widgetTotalSection(Map<String, dynamic>? extras) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total:", style: FTextStyle.dailyContestHistoryDate),
            Expanded(
                child: Align(
                    alignment: Alignment.center,child: Text('4', style: FTextStyle.dailyContestHistoryDate))),
          ],
        ),
        SizedBox(height: 5,),
        Text(
         '(2 wickets, 13.3 overs)',
          style: FTextStyle.extras,
        ),
      ],
    );
  }

  // Yet to Bat Section
  Widget _buildYetToBatSection(List<Map<String, dynamic>> yetToBat) {
    if (yetToBat.isEmpty) {
      return Text(
        "Yet to Bat",
        style: FTextStyle.scoresRow,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Yet to Bat", style: FTextStyle.scoresRow),
        SizedBox(height: 8),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 9,
          ),
          itemCount: 2, // Static number of items for design
          itemBuilder: (context, index) {
            return Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    ImageAssets.player,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  index % 2 == 0 ? "Virat Kohli" : "Rohit Sharma",
                  style: FTextStyle.dateWinners,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // Bowling Section
  Widget _buildBowlingSection(List<Map<String, dynamic>> bowlers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("Bowler", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Text("O", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("M", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("R", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("W", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("Eco", style: FTextStyle.scoresRow),
                ),
              ],
            ),
            ...bowlers.map((bowler) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text(
                      bowler["name"] ?? "Unknown",
                      style: FTextStyle.dateWinners,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text("${bowler["overs"] ?? 0}", style: FTextStyle.dailyContestHistoryDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text("${bowler["maidens"] ?? 0}", style: FTextStyle.bowlerRuns),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text("${bowler["runs"] ?? 0}", style: FTextStyle.bowlerRuns),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text("${bowler["wickets"] ?? 0}", style: FTextStyle.bowlerRuns),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text("${bowler["economy"] ?? 0.0}", style: FTextStyle.bowlerRuns),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  // Fall of Wickets Section
  Widget _buildFallOfWicketsSection(List<Map<String, dynamic>> fallOfWickets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Fall of Wickets",
            style: FTextStyle.scoresRow,
          ),
        ),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("Player", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("Score", style: FTextStyle.scoresRow),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Text("Over", style: FTextStyle.scoresRow),
                ),
              ],
            ),
            ...fallOfWickets.map((fow) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text(
                      fow["name"] ?? "Virat Kohli",
                      style: FTextStyle.dateWinners,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text(
                      fow["score"] ?? "0/0",
                      style: FTextStyle.bowlerRuns,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Text(
                      fow["over"] ?? "0.0",
                      style: FTextStyle.dailyContestHistoryDate,
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        Divider(),
      ],
    );
  }
}
