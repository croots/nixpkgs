{
  runCommand,
  breseq,
}:

let
  inherit (breseq) pname version;
in

runCommand "breseq-tests" { meta.timeout = 60; } ''
  echo "Testing breseq - breseq executable"
  if [[ `${breseq}/bin/breseq --version` != *"${version}"*  ]]; then
    echo "Error: program version does not match package version"
    exit 1
  fi
  export TESTBINPREFIX=${breseq}/bin
  export TESTDIR=$(mktemp -d)
  trap "rm -rf \"$TESTDIR\"" EXIT
  cp ${breseq}/tests $TESTDIR/breseqtests -r
  chmod -R +w $TESTDIR/breseqtests
  output=$($TESTDIR/breseqtests/tmv_plasmid_circular_deletion/testcmd.sh 2>&1) || {
    echo "$output"
    echo "Error testing breseq - breseq executable"
    exit 1
  }
  touch $out
''
