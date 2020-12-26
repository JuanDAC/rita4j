import rita.*;

int last = -9999;
String text = "Last Wednesday we decided to visit the zoo. We arrived the next morning after we breakfasted, cashed in our passes and entered. We walked toward the first exhibits. I looked up at a giraffe as it stared back at me. I stepped nervously to the next area. One of the lions gazed at me as he lazed in the shade while the others napped. One of my friends first knocked then banged on the tempered glass in front of the monkey's cage. They howled and screamed at us as we hurried to another exhibit where we stopped and gawked at plumed birds. After we rested, we headed for the petting zoo where we petted wooly sheep who only glanced at us but the goats butted each other and nipped our clothes when we ventured too near their closed pen. Later, our tired group nudged their way through the crowded paths and exited the turnstiled gate. Our car bumped, jerked and swayed as we dozed during the relaxed ride home.";

void setup()
{
  size(600, 400);   
}

void draw() {
  fill(0);
  textSize(16);
  textLeading(20);
  background(250);
  text(text, 50, 30, 500, 10000);

  int now = millis();
  if (now - last > 2000) {
    last = now;
    nextWord();
  }
}

//  replace a random word in the paragraph every 2 sec
void nextWord()
{   
  String[] words = text.split(" ");

  // loop from a random spot
  int count = (int)random(0, words.length);
  for (int i = count; i < words.length; i++) 
  {
    // only words of 3 or more chars
    if (words[i].length() < 3) continue;

    String pos = RiTa.tagger.allTags(words[i].toLowerCase())[0];  

    if (pos != null) 
    {
      // get the synset
      String[] syns = RiTa.rhymes(words[i]);

      // only words with >1 rhymes
      if (syns.length<2) continue;

      // pick a random rhyme
      int randIdx = (int)random(0, syns.length);
      String newStr = syns[randIdx];

      if (Character.isUpperCase(words[i].charAt(0))) {             
        newStr = RiTa.capitalize(newStr); // keep capitals
      }

      //println("replace: "+words[i]+" -> "+newStr);

      // and make a substitution
      text = text.replaceAll("\\b"+words[i]+"\\b", newStr);

      break;
    }
  }
}     
