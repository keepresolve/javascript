#/bin/bash
BASEDIR=$(dirname "$0")
cd "$BASEDIR/.."
mkdir -p "release"
name=`npm pack`
mv $name release/
echo "generated $name @ release/"
if [ -z "$1" ]
  then
    exit 0
fi
tmp="$HOME/tmp"
mkdir -p $tmp
cp release/$name "$tmp"
cd "$tmp"
tar xf $name  && mv package yimi_asr_inspection
cd yimi_asr_inspection
yarn install --production
npm run start