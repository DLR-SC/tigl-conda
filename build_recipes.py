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


def sorted_packages(packages_to_build):

    if len(packages_to_build) == 0:
        return ()

    build_order = ['cmake',
                   'ninja',
                   'swig4',
                   'doxygen',
                   'tbb',
                   'freeimage',
                   'freetype',
                   'gl2ps',
                   'curl',
                   'curl-static'
                   'libxml2',
                   'libxml2-static',
                   'libxslt',
                   'libxstl-static',
                   'tixi',
                   'tixi3',
                   'oce-0.16',
                   'oce-0.17',
                   'opencascade',
                   'python-occ',
                   'python-occ_0.17',
                   'python-occ-7x',
                   'pythreejs',
                   'tigl',
                   'tigl3']

    index_array = []
    for lib in packages_to_build:
        try:
            lib_idx = build_order.index(lib)
        except ValueError:
            lib_idx = -1
        index_array.append(lib_idx)

    build_idx, to_build_sorted = zip(*sorted(zip(index_array, packages_to_build)))

    return to_build_sorted


def get_changed_recipes():
    repo = Repo(path=".")
    assert not repo.bare

    hcommit = repo.head.commit               # diff tree against index

    modules = set()

    d = hcommit.diff('HEAD~1')
    for path in d:
        dirs = split_dir_parts(path.a_path)
        if os.path.isfile(dirs[0] + '/meta.yaml'):
            modules.add(dirs[0])

    return modules


def get_current_branch():

    active_branch = None
    github_actions_ref = os.environ.get("GITHUB_REF")
    appveyor_branch = os.environ.get("APPVEYOR_REPO_BRANCH")
    travis_branch = os.environ.get("TRAVIS_BRANCH")
    if github_actions_ref is not None:
        if 'refs/heads/' in github_actions_ref:
            # try to determine branch name form GITHUB_REF env variable
            active_branch = github_actions_ref.split('refs/heads/', 1)[1]
        else:
            # GITHUB_REF will not work on PR builds, fallback to github.head_ref
            # manually added as env var from context var in config file
            active_branch = os.environ.get("GH_HEAD_REF")
    elif appveyor_branch is not None:
        active_branch = appveyor_branch
    elif travis_branch is not None:
        active_branch = travis_branch
    else:
        repo = Repo(path=".")
        try:
            if not repo.head.is_detached:
                active_branch = repo.active_branch.name
        except TypeError:
            pass # just return None
    return active_branch


def main():

    upload_to_anaconda = True

    api_token = os.environ.get("ANACONDA_API_TOKEN")
    if api_token is None:
        print ("No anaconda API token given. Packages will not be uploaded.  Define environment variable ANACONDA_API_TOKEN")
        upload_to_anaconda = False

    active_branch = get_current_branch()
    if active_branch is not None:
        print("On branch {}.".format(active_branch))
    else:
        print ("Could not determine branch name.")
    if not active_branch == 'master':
        print ("The current branch is not the master branch. Packages will not be uploaded.")
        upload_to_anaconda = False

    modules = get_changed_recipes()
    modules = sorted_packages(modules)

    if len(modules) > 0:
        print("conda build " + " ".join(modules))
        if upload_to_anaconda:
            conda_build.api.build(modules, user="dlr-sc", token=api_token)
        else:
            conda_build.api.build(modules)
    else:
        print("No packages changed. Nothing to be built.")


if __name__ == "__main__":
    main()
