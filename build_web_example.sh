cd example
sed -i '' '/assets\/ipadic\//s/^/#/' pubspec.yaml
flutter build web --base-href "/mecab_for_dart/"
sed -i '' '/assets\/ipadic\//s/^#//' pubspec.yaml
cd ..

rm -rf ./docs/
mkdir docs
cp -r example/build/web/ docs/