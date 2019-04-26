from git import Repo
import os
import conda_build.api

def split_dir_parts(path):
    allparts = []
    while 1:
        parts = os.path.split(path)
        if parts[0] == path:  # sentinel for absolute paths
            allparts.insert(0, parts[0])
            break
        elif parts[1] == path: # sentinel for relative paths
            allparts.insert(0, parts[1])
            break
        else:
            path = parts[0]
            allparts.insert(0, parts[1])
    return allparts


def get_changed_recipes():
    repo = Repo(path=".")
    assert not repo.bare

    hcommit = repo.head.commit               # diff tree against index

    modules = set()

    d = hcommit.diff('HEAD~1')
    for path in d:
        dirs = split_dir_parts(path.a_path)
        modules.add(dirs[0])

    return modules


def main():
    api_token = os.environ.get("ANACONDA_API_TOKEN")

    if api_token is None:
        print ("No anaconda API token given. Packages will not be uploaded.  Define environment variable ANACONDA_API_TOKEN")

    modules = get_changed_recipes()

    if len(modules) > 0:
        print("conda build " + " ".join(modules))
        if api_token is None:
            conda_build.api.build(modules)
        else:
            conda_build.api.build(modules, user="dlr-sc", token=api_token)


if __name__ == "__main__":
    main()