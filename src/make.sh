#! /bin/sh

base_dir=`dirname $0`

target_dir="$base_dir/latex-theme"
working_dir="$base_dir/build"
windows="windows"
macos="macos"
linux="linux"

if [ -d $target_dir ]; then
    rm -r $target_dir
fi;

if [ -d $working_dir ]; then
    rm -r $working_dir
fi;

mkdir $working_dir
mkdir $target_dir
mkdir $target_dir/$windows
mkdir $target_dir/$macos
mkdir $target_dir/$linux

#####################################################################

echo "\$theme: \"light\";" >> $working_dir/windows.scss
echo "\$os: \"windows\";" >> $working_dir/windows.scss
cat $base_dir/latex-theme.scss >> $working_dir/windows.scss

echo "\$theme: \"light\";" >> $working_dir/macos.scss
echo "\$os: \"macos\";" >> $working_dir/macos.scss
cat $base_dir/latex-theme.scss >> $working_dir/macos.scss

scss --sourcemap=none $working_dir/windows.scss $target_dir/$windows/latex.css  
scss --sourcemap=none $working_dir/macos.scss $target_dir/$macos/latex.css
scss --sourcemap=none $working_dir/macos.scss $target_dir/$linux/latex.css

#######################################################################

echo "\$theme: \"dark\";" >> $working_dir/windows-dark.scss
echo "\$os: \"windows\";" >> $working_dir/windows-dark.scss
cat $base_dir/latex-theme.scss >> $working_dir/windows-dark.scss

echo "\$theme: \"dark\";" >> $working_dir/macos-dark.scss
echo "\$os: \"macos\";" >> $working_dir/macos-dark.scss
cat $base_dir/latex-theme.scss >> $working_dir/macos-dark.scss

scss --sourcemap=none $working_dir/windows-dark.scss $target_dir/$windows/latex-dark.css  
scss --sourcemap=none $working_dir/macos-dark.scss $target_dir/$macos/latex-dark.css
scss --sourcemap=none $working_dir/macos-dark.scss $target_dir/$linux/latex-dark.css

########################################################################

cp $base_dir/install.sh $target_dir/$macos
cp $base_dir/install.ps1 $target_dir/$windows

zip -rj $target_dir/latex-theme-$macos.zip $target_dir/$macos/*
zip -rj $target_dir/latex-theme-$windows.zip $target_dir/$windows/*

rm -r $working_dir