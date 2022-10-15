#!/bin/bash
#
# Simple script to write an index into an image directory.
#
TITLE=$1
DIR=$2

(
    cd $DIR
    mogrify -format gif -thumbnail 200x200 *.jpeg &
    cd -
)>/dev/null

cat <<EOF
<html>
<head>
  <title>$TITLE</title>
</head>
<body>
<style>
  img.main {
      display: block;
      max-width: 80%;
      margin-left: auto;
      margin-right: auto;
  }
  ul.row {
      list-style-type: none;
  }
  ul.row li {
      /* margin: 1em; */
      float: left;
      transform: scale(0.75);
      transition: transform .2s; /* Animation */
  }
  ul.row li:hover {
      transform: scale(1);
  }
  @media (max-width:600px){
      ul.row li a img {
          max-width: 100px;
      }
  }
</style>
<h1>$TITLE</h1>

<a href="../$DIR.jpeg"><img class="main" src="../$DIR.jpeg"></a>

<ul class="row">
EOF

for file in $(ls $DIR/*.jpeg);do
    BASE=$(basename $file .jpeg)
    echo "  <li><a href=\"$BASE.jpeg\"><img src=\"$BASE.gif\"></a></li>"
done

cat <<EOF
</body>
</html>
EOF
