#!/usr/bin/env python
import os

env = SConscript("godot-cpp/SConstruct")

if os.environ.get("SCONS_USE_ENVIRONMENT") == "yes":
    env.Append(ENV = os.environ)
# For the reference:
# - CCFLAGS are compilation flags shared between C and C++
# - CFLAGS are for C-specific compilation flags
# - CXXFLAGS are for C++-specific compilation flags
# - CPPFLAGS are for pre-processor flags
# - CPPDEFINES are for pre-processor defines
# - LINKFLAGS are for linking flags

# tweak this if you want to use different folders, or more folders, to store your source code in.
env.Append(CPPPATH=["src/"])

default_target = SConscript(
        'src/SConscript',
        variant_dir='bin',
        duplicate=0,
        exports={'env': env}
        )


Default(env.Install("./project/extensions/ssp/bin", default_target))
