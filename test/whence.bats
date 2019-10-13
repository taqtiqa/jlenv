#!/usr/bin/env bats

load test_helper

create_executable() {
  local bin="${JLENV_ROOT}/versions/${1}/bin"
  mkdir -p "$bin"
  touch "${bin}/$2"
  chmod +x "${bin}/$2"
}

@test "finds versions where present" {
  create_executable "0.7" "julia"
  create_executable "1.0" "juliac"
  create_executable "2.0" "julia"
  create_executable "2.0" "juliac"
  create_executable "1.0" "genie"

  run jlenv-whence julia
  assert_success
  assert_output <<OUT
0.7
2.0
OUT

  run jlenv-whence juliac
  assert_success
  assert_output <<OUT
1.0
2.0
OUT

  run jlenv-whence genie
  assert_success "1.0"
}
