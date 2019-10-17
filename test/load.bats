#!/usr/bin/env bats

load libs/bats-support/load
load libs/bats-assert/load
load test_helper

@test "test helper" {
  run echo "${PATH}"
  assert_success
  refute_output ''
}