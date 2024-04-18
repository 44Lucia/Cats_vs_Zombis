class HighscoreManager {
  final String file;

  String[] nameList, scoreList;
  IntDict highscoreDict;

  HighscoreManager() {
    file = "scores.txt";
    highscoreDict = new IntDict();
    readFileValues();
    
    //highscoreDict.set("awawa", 5);
    
    nameList = highscoreDict.keyArray();
    scoreList = str(highscoreDict.valueArray());
  }

  void readFileValues() {
    highscoreDict.clear();

    String[] lines = loadStrings(file);

    for (int i = 0; i < lines.length; i+=2) {
      highscoreDict.set(lines[i], int(lines[i + 1]));
    }
  }

  void saveValuesToFile() {
    saveStrings(file, sortedScores());
  }
  
  String[] sortedScores() {
    highscoreDict.sortValuesReverse();
    nameList = highscoreDict.keyArray();
    scoreList = str(highscoreDict.valueArray());

    String[] result = new String[nameList.length * 2];
    int aux = 0;
    for (int i = 0; i < nameList.length; i++) {
      result[aux++] = nameList[i];
      result[aux++] = scoreList[i];
    }
    
    return result;
  }
}
