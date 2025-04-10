{
  runCommand,
  breseq,
}:

let
  inherit (breseq) pname version;
in

runCommand "breseq-tests" { meta.timeout = 60; } ''
  echo "Testing breseq - gdtools executable"
  # gdtools doesn't have a way to report the version
  export TESTBINPREFIX=${breseq}/bin
  export TESTDIR=$(mktemp -d)
  trap "rm -rf \"$TESTDIR\"" EXIT
  cp ${breseq}/tests $TESTDIR/breseqtests -r
  chmod -R +w $TESTDIR/breseqtests
  output=$($TESTDIR/breseqtests/gdtools_compare_1/testcmd.sh 2>&1) || {
    echo "$output"
    echo "Error testing breseq - gdtools executable"
    exit 1
  }
  touch $out
''
