import 'package:flutter/material.dart';
import 'dart:convert';

class HindiParagraphWidget extends StatefulWidget {
  HindiParagraphWidget({Key? key}) : super(key: key);

  @override
  _HindiParagraphWidgetState createState() => _HindiParagraphWidgetState();
}

class _HindiParagraphWidgetState extends State<HindiParagraphWidget> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _words = [];
  Set<String> uniqueWords = {};
  Set<String> minimalPairs ={};
  Set<String> partialMinimalPairs = {};

  void _splitParagraphIntoWords(String paragraph) {
    setState(() {
      _words = paragraph.split(' ');

      uniqueWords={};
      for(int i=0;i<_words.length;i++){
        uniqueWords.add(_words[i]);
      }
    });
  }

  Set<String> _findMinimalPairs(Set<String> words) {
    Set<String> minimalPairs = {};

    for (int i = 0; i < uniqueWords.length; i++) {
      for (int j = i + 1; j < uniqueWords.length; j++) {
        if (isMinimalPair(uniqueWords.elementAt(i), uniqueWords.elementAt(j))) {
          print('${uniqueWords.elementAt(i)} - ${uniqueWords.elementAt(j)}');
          minimalPairs.add('${uniqueWords.elementAt(i)} - ${uniqueWords.elementAt(j)}');
        }
      }
    }

    return minimalPairs;
  }

  Set<String> _findPartialMinimalPairs(Set<String> words) {
    Set<String> partialMinimalPairsres = {};

    for (int i = 0; i < uniqueWords.length; i++) {
      for (int j = i + 1; j < uniqueWords.length; j++) {
        if (isPartialMinimalPair(uniqueWords.elementAt(i), uniqueWords.elementAt(j))) {
          partialMinimalPairsres.add('${uniqueWords.elementAt(i)} - ${uniqueWords.elementAt(j)}');
        }
      }
    }

    return partialMinimalPairsres;
  }

//minimal pair function
  bool isMinimalPair(String word1, String word2) {
    // Convert words to hex codes
    String word1Hex = '';
    String word2Hex = '';
    for (final c in word1.runes) {
      word1Hex += c.toRadixString(16).padLeft(4, '0');
    }
    for (final c in word2.runes) {
      word2Hex += c.toRadixString(16).padLeft(4, '0');
    }
    print(word1Hex);
    print(word2Hex);
    bool isMinimalPairres = false;
    if (word1Hex.length == word2Hex.length) {
      int diffCount = 0;
      for (int i = 0; i < word1Hex.length; i += 4) {
        if (word1Hex.substring(i, i + 4) != word2Hex.substring(i, i + 4)) {
          diffCount++;
          if (diffCount > 1) {
            break;
          }
        }
      }
      if (diffCount == 1) {
        isMinimalPairres = true;
      }
    }
    return isMinimalPairres;
  }

  //partial minimal pair function
  // bool isPartialMinimalPair(String word1, String word2) {
  //   // Convert words to hex codes
  //   String word1Hex = '';
  //   String word2Hex = '';
  //
  //   for (final c in word1.runes) {
  //     String t=c.toRadixString(16).padLeft(4, '0');
  //     word1Hex += c.toRadixString(16).padLeft(4, '0');
  //   }
  //   for (final c in word2.runes) {
  //     word2Hex += c.toRadixString(16).padLeft(4, '0');
  //   }
  //   if (word1Hex.length < word2Hex.length) {
  //     String temp = word1Hex;
  //     word1Hex = word2Hex;
  //     word2Hex = temp;
  //   }
  //
  //
  //   int diffCount = 0;
  //   if (word1Hex.length == word2Hex.length + 4) {
  //     print('ispartialMinimalpair function called');
  //     int index1 = 0;
  //     int index2 = 0;
  //     for(int i=0;i<word2Hex.length;i+=4){
  //       if(word1Hex.substring(index1, index1 + 4) != word2Hex.substring(i, i + 4)){
  //         diffCount++;
  //       }else{
  //         index1+=4;
  //       }
  //       if(diffCount>1){
  //         return false;
  //       }
  //     }
  //     // while (index2 < word2Hex.length) {
  //     //   if (index1 < word1Hex.length && index2 < word2Hex.length &&
  //     //       word1Hex.substring(index1, index1 + 4) !=
  //     //           word2Hex.substring(index2, index2 + 4)) {
  //     //     diffCount++;
  //     //     index1 += 4;
  //     //     if (diffCount > 1) {
  //     //       break;
  //     //     }
  //     //   } else {
  //     //     index1 += 4;
  //     //     index2 += 4;
  //     //   }
  //     // }
  //     // if (diffCount == 0) {
  //     //   diffCount = 1;
  //     // }
  //
  //   }
  //   if (diffCount == 1) {
  //     return true;
  //   }
  //
  //   return false;
  // }
  bool isPartialMinimalPair(String word1, String word2) {
    // Convert words to hex codes
    List<String> word1Hex = [];
    List<String> word2Hex = [];
    int diffCount = 0;

    for (final c in word1.runes) {
      if( c.toRadixString(16).padLeft(4, '0') != '094d'){
        word1Hex.add (c.toRadixString(16).padLeft(4, '0'));
      }

    }
    for (final c in word2.runes) {
      if( c.toRadixString(16).padLeft(4, '0') != '094d'){
        word2Hex.add( c.toRadixString(16).padLeft(4, '0'));
      }

    }

    if (((word1Hex.length - word2Hex.length) == 1 )|| ((word2Hex.length - word1Hex.length) == 1)) {
      // Difference in hex code lengths must be exactly 4

      if (word1Hex.length < word2Hex.length) {
        List<String> temp = word1Hex;
        word1Hex = word2Hex;
        word2Hex = temp;
      }

      int index1 = 0;
      int index2 = 0;

      for (int i = 0; i < word1Hex.length; i++) {
        print(word1Hex[i]);
        if (index2 < word2Hex.length && word1Hex[i] == word2Hex[index2]) {
          index2++;
        } else {
          diffCount++;
          if (diffCount > 1) {
            return false;
          }
        }
      }
    }else{
      return false;
    }
    return diffCount == 1 || diffCount==0;
  }

  @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/background_image.jpg',), fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text('Minimal Pair Finder',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter a paragraph in Hindi, Marathi, Gujarati, Bengali',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  _splitParagraphIntoWords(value);
                  setState(() {
                    minimalPairs = _findMinimalPairs(uniqueWords);
                    partialMinimalPairs = _findPartialMinimalPairs(uniqueWords);
                    if(isPartialMinimalPair('पता', 'पत्ता')){
                      print('it is woring fine');
                    }else{
                      print('not wirking at all');
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            uniqueWords.length>0?
            Text(
              'Words:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ):Container(),
            SizedBox(height: 10),
            // uniqueWords.length>0 ?


            // SingleChildScrollView(
            //   child: Wrap(
            //     clipBehavior: Clip.antiAlias,
            //     children: uniqueWords
            //         .map(
            //           (word) =>
            //           Container(
            //             margin: EdgeInsets.all(5),
            //             padding: EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               border: Border.all(color: Colors.grey),
            //             ),
            //             child: Text(word),
            //           ),
            //     )
            //         .toList(),
            //   ),
            // ):Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  minimalPairs = _findMinimalPairs(uniqueWords);
                  partialMinimalPairs = _findPartialMinimalPairs(uniqueWords);
                  if(isPartialMinimalPair('पता', 'पत्ता')){
                    print('it is woring fine');
                  }else{
                    print('not wirking at all');
                  }
                });
              },
              child: Text('Find Minimal Pairs'),
            ),
            SizedBox(height: 20,),
            Text(
              'Total Minimal Pairs: ${minimalPairs.length+partialMinimalPairs.length}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            minimalPairs.length>0 ?
            Text(
              'No. of Complete Minimal Pairs: ${minimalPairs.length}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ): Container(),
            minimalPairs.length>0 ?
            Expanded(
              child: ListView.builder(
                itemCount: minimalPairs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(minimalPairs.elementAt(index)),
                  );
                },
              ),
            ): Container(),

            partialMinimalPairs.length>0 ?
             Text(
                  'No. of Partial Minimal Pairs: ${partialMinimalPairs.length}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ):Container(),

            partialMinimalPairs.length>0 ?
                Expanded(
                  child: ListView.builder(
                    itemCount: partialMinimalPairs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(partialMinimalPairs.elementAt(index)),
                      );
                    },
                  ),
                ):Container(),


          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    throw UnimplementedError();
  }
