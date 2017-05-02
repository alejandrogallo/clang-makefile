cp ../../../dist/Makefile .

TEST_DESCRIPTION="Hello world test FORTRAN"
make_flags="--no-print-directory VIEW= QUIET=1 QQUIET=1"

# For some reason make detects that we are somewhere else from the test script
# sourcing and we have to add the --no-print-directory flag so that we can eval
# without the leaving directory message for sub-builds in make
eval "$(make ${make_flags} print-EXECUTABLE)"

echo "EXECUTABLE = ${EXECUTABLE}"

make ${make_flags}
TEST_RESULT=0

if [[ ! -f "${EXECUTABLE}" ]]; then
  echo "${EXECUTABLE} file not found!"
  TEST_RESULT=1
fi



#vim-run: bash %
