#!/bin/sh

# schema
prepare_schema () {
    mkdir -p tmp
    cd tmp
    wget -q -O data.zip "https://github.com/$1/archive/refs/heads/$2.zip"
    unzip data.zip
    mv */*.yaml ../root/
    ls */*.txt 1> /dev/null 2>&1 && mv */*.txt ../root/
    [ -d */opencc ] && mv */opencc/* ../opencc/
    cd ..
    rm -rf tmp
}

prepare_schema rime/rime-cantonese main
prepare_schema rime/rime-emoji master
prepare_schema rime/rime-emoji-cantonese master
prepare_schema rime/rime-ipa master
prepare_schema rime/rime-luna-pinyin master
prepare_schema rime/rime-prelude master
prepare_schema CanCLID/rime-loengfan main
prepare_schema nk2028/rime-kyonh main
prepare_schema nk2028/rime-tupa main
prepare_schema sgalal/rime-hanja master
prepare_schema sgalal/rime-kunyomi master
prepare_schema sgalal/rime-symbolic master
prepare_schema szc126/rime-liangfen main
prepare_schema ayaka14732/rime-ayaka-v8 main

# e&d&s
wget -q -nc -O root/essay.txt https://github.com/rime/rime-essay/raw/master/essay.txt
