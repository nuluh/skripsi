#!/bin/bash
set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Test files array with format: "filename:engine"
# engine can be: xelatex, lualatex, pdflatex
TEST_FILES=(
  "test-base-only:xelatex"
  "test-abstract-keywords:xelatex"
  "test-abstract-keywords:lualatex"
  "test-custom-maketitle:xelatex"
  # "test-metadata:pdflatex"
)

# Parse command line arguments
SPECIFIC_TEST=""
if [ $# -gt 0 ]; then
  SPECIFIC_TEST=${1%:*}
  SPECIFIC_TEST_ENGINE=${1#*:}
fi

echo -e "${BOLD}${BLUE}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${BLUE}   Running Test Suite${NC}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════${NC}\n"

# Create symlink to built cls file
echo -e "${YELLOW}[Setup]${NC} Creating symlink to built .cls file..."
if [ ! -L "./unittest/skripsi.cls" ]; then
  ln -sf ./src/.build/skripsi.cls ./unittest/skripsi.cls
  echo -e "  ${GREEN}✓${NC} Symlink created\n"
else
  echo -e "  ${GREEN}✓${NC} Symlink already exists\n"
fi

cd ./unittest

# Run tests
TEST_NUM=1
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
SPECIFIC_TEST_RUN=0
for TEST_ENTRY in "${TEST_FILES[@]}"; do
  # Split filename and engine
  TEST_FILE="${TEST_ENTRY%:*}"
  ENGINE="${TEST_ENTRY#*:}"

  
  # Skip if specific test is requested and this isn't it
  if [ -n "$SPECIFIC_TEST" ] && [ "$TEST_ENTRY" != "$1" ]; then
    continue
  fi
  
  # If specific test is requested, ensure it only run it once
  if [ -n "$SPECIFIC_TEST" ] && [ -n "$SPECIFIC_TEST_ENGINE" ] && [ "$SPECIFIC_TEST_RUN" -eq 0 ]; then
    TEST_FILE="${SPECIFIC_TEST}"
    ENGINE="${SPECIFIC_TEST_ENGINE}"
    SPECIFIC_TEST_RUN=1
  fi
  echo -e "${YELLOW}[Test $TEST_NUM]${NC} ${BLUE}${TEST_FILE}${NC} with ${BOLD}${ENGINE}${NC}..."
  latexmk -${ENGINE} -silent -logfilewarnings -outdir=.build ${TEST_ENTRY}.tex
  if grep -q "Class skripsi Warning" .build/${TEST_ENTRY}.log; then
    echo -e "\n  ${YELLOW}⚠ Class Warnings:${NC}"
    grep "Class skripsi Warning" .build/${TEST_ENTRY}.log | while IFS= read -r line; do
      # Extract just the warning message after "Class skripsi Warning:"
      warning_msg=$(echo "$line" | sed 's/.*Class skripsi Warning: //')
      echo -e "    ${YELLOW}→${NC} $warning_msg"
    done
  fi
  latexmk -c -outdir=.build ${TEST_ENTRY}.tex
  
  if [ -f .build/${TEST_ENTRY}.pdf ]; then
    echo -e "  ${GREEN}✓ PASSED${NC}    ${BLUE}${TEST_FILE}.tex${NC} (${ENGINE})\n"
    TESTS_PASSED=$((TESTS_PASSED + 1))
  else
    echo -e "  ${RED}✗ FAILED${NC}    ${BLUE}${TEST_FILE}.tex${NC} (${ENGINE})\n"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    exit 1
  fi
  
  TEST_NUM=$((TEST_NUM + 1))
  TESTS_RUN=$((TESTS_RUN + 1))
done

# Check if specific test was found
if [ -n "$SPECIFIC_TEST" ] && [ $TESTS_RUN -eq 0 ]; then
  echo -e "${RED}✗ Test '${SPECIFIC_TEST}' not found${NC}\n"
  echo -e "Available tests:"
  for test in "${TEST_FILES[@]}"; do
    echo -e "  - ${test%:*} (${test#*:})"
  done
  exit 1
fi

echo -e "${BOLD}${GREEN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}   All Tests Passed! ✓${NC}"
echo -e "${BOLD}${GREEN}   Summary: ${TESTS_PASSED}/${TESTS_RUN} tests passed${NC}"
echo -e "${BOLD}${GREEN}═══════════════════════════════════════${NC}"