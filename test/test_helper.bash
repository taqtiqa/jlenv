unset JLENV_VERSION
unset JLENV_DIR

echo 'The test_helper script is ...'

# guard against executing this block twice due to bats internals
if [ "${JLENV_ROOT:=/}" != "${JLENV_TEST_DIR:=/}/root" ]
then

  echo '... preparing bats test environment'

  JLENV_TEST_DIR="${BATS_TMPDIR}/libs/jlenv"
  PLUGIN="${JLENV_TEST_DIR}/root/plugins/jlenv-each"
  JLENV_TEST_DIR="${BATS_TMPDIR}/jlenv"
  export JLENV_TEST_DIR="$(mktemp -d "${JLENV_TEST_DIR}.XXX" 2>/dev/null || echo "$JLENV_TEST_DIR")"

  if enable -f "${BATS_TEST_DIRNAME}"/../libexec/jlenv-realpath.dylib realpath 2>/dev/null; then
    export JLENV_TEST_DIR="$(realpath "$JLENV_TEST_DIR")"
  else
    if [ -n "$JLENV_NATIVE_EXT" ]; then
      echo "jlenv: failed to load \`realpath' builtin" >&2
      exit 1
    fi
  fi

  export JLENV_ROOT="${JLENV_TEST_DIR}/root"
  export HOME="${JLENV_TEST_DIR}/home"
  export JLENV_HOOK_PATH="${JLENV_ROOT}/jlenv.d"

  # Install bats to the test location. This is next added to path.
  # These files are in .gitignore
  pushd "${BATS_TEST_DIRNAME}/libs/bats"
    ./install.sh "${BATS_TEST_DIRNAME}/libexec"
  popd

  PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
  PATH="${JLENV_TEST_DIR}/bin:$PATH"
  PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
  PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
  PATH="${JLENV_ROOT}/shims:$PATH"
  export PATH

  for xdg_var in `env 2>/dev/null | grep ^XDG_ | cut -d= -f1`; do unset "$xdg_var"; done
  unset xdg_var
fi

teardown() {
  rm -rf "$JLENV_TEST_DIR"
}

flunk() {
  { if [ "$#" -eq 0 ]; then cat -
    else echo "$@"
    fi
  } | sed "s:${JLENV_TEST_DIR}:TEST_DIR:g" >&2
  return 1
}

# Output a modified PATH that ensures that the given executable is not present,
# but in which system utils necessary for jlenv operation are still available.
path_without() {
  local exe="$1"
  local path=":${PATH}:"
  local found alt util
  for found in $(which -a "$exe"); do
    found="${found%/*}"
    if [ "$found" != "${JLENV_ROOT}/shims" ]; then
      alt="${JLENV_TEST_DIR}/$(echo "${found#/}" | tr '/' '-')"
      mkdir -p "$alt"
      for util in bash head cut readlink greadlink; do
        if [ -x "${found}/$util" ]; then
          ln -s "${found}/$util" "${alt}/$util"
        fi
      done
      path="${path/:${found}:/:${alt}:}"
    fi
  done
  path="${path#:}"
  echo "${path%:}"
}

create_hook() {
  mkdir -p "${JLENV_HOOK_PATH}/$1"
  touch "${JLENV_HOOK_PATH}/$1/$2"
  if [ ! -t 0 ]; then
    cat > "${JLENV_HOOK_PATH}/$1/$2"
  fi
}

create_hook() {
  mkdir -p "${JLENV_HOOK_PATH}/$1"
  touch "${JLENV_HOOK_PATH}/$1/$2"
  if [ ! -t 0 ]; then
    cat > "${JLENV_HOOK_PATH}/$1/$2"
  fi
}
