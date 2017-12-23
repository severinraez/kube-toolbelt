# kube-toolbelt

A collection of bash scripts to automate repetitive tasks using kubectl.

See the scripts in `scripts/`.

## Design / Usage

Clone this repo and use the scripts.

If you find yourself using them frequently it might be beneficial to add the `scripts` directory to your path. All scripts are prefixed with `kt-` to minimize path pollution.

The scripts are simple kubectl wrappers, you can export KUBECONFIG according to your needs if you have to talk to different clusters.

I happily reuse tools packaged with my distro (Ubuntu 16.04). The scripts will tell you if they are missing an executable.
