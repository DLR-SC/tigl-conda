# Installs only a fake egg-info file, so that pip / setuptools / importlib.metadata
# still see a "tixi3" distribution. The actual library and the tixi3 python module
# are provided by the conda-forge "tixi" package.
import os

sp_dir = os.environ["SP_DIR"]
version = os.environ["PKG_VERSION"]

os.makedirs(sp_dir, exist_ok=True)
with open(os.path.join(sp_dir, "tixi3-{}.egg-info".format(version)), "w") as f:
    f.write("Metadata-Version: 2.1\n"
            "Name: tixi3\n"
            "Version: {}\n"
            "Summary: Fast and simple XML interface library\n"
            "Platform: UNKNOWN\n".format(version))
