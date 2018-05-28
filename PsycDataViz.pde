/*

ParseDatabase
 Created by Stejara Dinulescu
 October 18, 2017
 
 **This file parses the psychological database PsyGeNET
 **PsyGeNET database downloaded from: http://www.psygenet.org/web/PsyGeNET/menu/downloads;jsessionid=vjsati3pqs841azfp8ujf20cn

*/

ArrayList<String> geneID = new ArrayList<String>(); 
//gene ID in PsyGeNET
//determines the number of lines used in vis

ArrayList<Integer> instances = new ArrayList<Integer>(); 
//number of different disorders that manifest due to the presence of that particular gene
//the higher the instances, the longer the length in data viz

ArrayList<String[]> lineParts = new ArrayList<String[]>(); //used for parsing purposes

float xPos = 10;
float yPos = 800;
float angle = 1;

void parseData() { //parses text into information for data viz
  String[] lines = loadStrings("PsyGeNET_corpus.txt"); //each line of text file becomes a slot in the array
  
  for (int i = 0; i < lines.length; i++) {
    lineParts.add(splitTokens(lines[i])); //each slot in the array is parsed into tokens, which are added to an arrayList
  }
  
  for (int i = 0; i < lines.length; i++) {
    //println(lineParts.get(i)[1]);
    if (geneID.contains(lineParts.get(i)[1])) { //if that geneID is already present in the arrayList
      int index = geneID.indexOf(lineParts.get(i)[1]);
      instances.set(index, (instances.get(index) + 1));
      //println("Instances set to: " + (instances.get(index) + 1) + " at position " + index);
    } else {
      geneID.add(lineParts.get(i)[1]); //only the first slot in the array in the arrayList (geneID) is added to final arrayList
      instances.add(1);
    }
  }
}

void printGeneIDAndInstances() { //prints out the gene ID and how many different disorders it is involved in
  for (int i = 0; i < geneID.size(); i++) {
    println(i + "  geneID: " + geneID.get(i) + " instances: " + instances.get(i));
  }
}


void drawShapes(float x, float y, int len, float angle) {
  //println(instances.get(0));
  if (len > 0) {
    //stroke(255);
    line(x, y, x-len, y-len);
    rotate(angle);
    translate(x, y);
    len--;
    drawShapes(0, 0, len, angle);
  } else {}
}

void setup() {
  size(1400, 800); //sets size of window
  //background(0);
  background(255);
  stroke(0);
  
  parseData(); //parses the data to be used in viz
  //printGeneIDAndInstances(); //unit test for parseData()
  
  for (int i = 0; i < instances.size(); i++) {
    //stroke(random(100, 150), random(100, 150), random(100, 150));
    //stroke(random(255), random(255), random(255));
    drawShapes(xPos, yPos, (instances.get(i) * 100), angle);
  }
  save("blackOnWhite.jpg");
}