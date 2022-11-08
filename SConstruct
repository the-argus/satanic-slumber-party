#!/usr/bin/env python
import os

env = SConscript("godot-cpp/SConstruct")

if os.environ.get("SCONS_USE_ENVIRONMENT") == "yes":
    env.Append(ENV = os.environ)

env.Append(CPPPATH=["./include"])

default_target = SConscript(
        'src/SConscript',
        variant_dir='bin',
        duplicate=0,
        exports={'env': env}
        )

Default(env.Install("./project/extensions/ssp/bin", default_target))
