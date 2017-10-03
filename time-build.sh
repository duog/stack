#!/usr/bin/env bash

# remove previous run. It goes in dist because that's already ignored in my syncing setup
rm -rf dist

export STACK_ROOT=$(pwd)/dist/.stack-root1
rm -rf .stack-work
stack setup
stack build --dry-run --prefetch
echo "### TIMED BUILD OUTPUT WITHOUT -split-sections" > build.out
(time stack build) &>> build.out
echo $(stack exec -- bash -c 'ls -al $(which stack)') >> build.out

export STACK_ROOT=$(pwd)/dist/.stack-root2
rm -rf .stack-work
stack setup
stack build --dry-run --prefetch
echo "### TIMED BUILD OUTPUT WITH -split-sections" >> build.out
(time stack build --ghc-options="-split-sections") &>> build.out
echo $(stack exec -- bash -c 'ls -al $(which stack)') >> build.out
