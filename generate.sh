#!/bin/bash

function generateClass {
  NUMBER=$(printf "%02d" $2)
  FOLDER="ManyFiles/${1}"
  FILENAME="${1}${NUMBER}.swift"
  CLASSNAME="${1}${NUMBER}"

  mkdir -p $FOLDER
  cat > $FOLDER/$FILENAME <<EOF
import Foundation

class $CLASSNAME {

    func someMethod() -> Int {
        return Int(arc4random_uniform(100))
    }

}
EOF
}

for letter in {A..Z}; do
  echo "Generating classes ${letter}01 - ${letter}99 ..." 
  for number in {0..99}; do
    generateClass $letter $number
  done
done 
