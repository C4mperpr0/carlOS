unstable:
/*
yaml
*/
''
  CompileFlags:
      Add:
          - -I${unstable.gcc-unwrapped}/include/c++/11.3.0
          - -I${unstable.gcc-unwrapped}/include/c++/11.3.0/x86_64-unknown-linux-gnu
          - -I${unstable.gcc-unwrapped}/include/c++/11.3.0/backward
          - -I${unstable.gcc-unwrapped}/lib/gcc/x86_64-unknown-linux-gnu/11.3.0/include
          - -I${unstable.gcc-unwrapped}/include
          - -I${unstable.gcc-unwrapped}/lib/gcc/x86_64-unknown-linux-gnu/11.3.0/include-fixed
          - -I${unstable.glibc.dev}/include
          - -DLOCAL
          - -Wall
          - -O2
          - -Wextra
          - -Wshadow
          - -Wconversion
          - -Wfloat-equal
          - -Wno-unused-const-variable
          - -Wno-sign-conversion
          - -std=c++17
  Index:
      Background: Skip
''
