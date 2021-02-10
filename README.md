# GitHub Actions Virtual Environments
This repository contains the source used to create the [virtual environments](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners) for GitHub Actions hosted runners, as well as the VM images of [Microsoft-hosted agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent) used for Azure Pipelines. To file bug reports, or request that tools be added/updated, please [open an issue using the appropriate template](https://github.com/actions/virtual-environments/issues/new/choose). To build a VM machine from this repo's source, see the [instructions](./help/CreateImageAndAzureResources.md).

For general questions about using the virtual environments or writing your Actions workflow, please open requests in the [GitHub Actions Community Forum](https://github.community/c/github-actions/41).

## Available Environments
| Environment | YAML Label | Included Software | Latest Release & Rollout Progress |
| --------------------|---------------------|--------------------|---------------------|
| Ubuntu 20.04 | `ubuntu-20.04` | [ubuntu-20.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&redirect=1)
| Ubuntu 18.04 | `ubuntu-latest` or `ubuntu-18.04` | [ubuntu-18.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu18&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu18&redirect=1)
| Ubuntu 16.04 | `ubuntu-16.04` | [ubuntu-16.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu16&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu16&redirect=1) |
| macOS 10.15 | `macos-latest` or `macos-10.15` | [macOS-10.15] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=MacOS&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=MacOS&redirect=1)
| Windows Server 2019 | `windows-latest` or `windows-2019` | [windows-2019] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&redirect=1)
| Windows Server 2016 | `windows-2016` | [windows-2016] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2016&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2016&redirect=1)
```
The Ubuntu 20.04 virtual environment is currently provided as a preview only.
The "ubuntu-latest" YAML workflow label still uses the Ubuntu 18.04 virtual environment.
```

***Looking for other Linux distributions?*** We do not plan to offer other Linux distributions. We recommend using Docker if you'd like to build using other distributions with the hosted virtual environments. Alternatively, you can leverage [self-hosted runners] and fully customize your environment to your needs.

***How to contribute to macOS source?*** macOS source lives in this repository and available for everyone. However, MacOS image-generation CI doesn't support external contributions yet so we are not able to accept pull-requests for now.
We are in the process of preparing MacOS CI to accept contributions. Until then, we appreciate your patience and ask you continue to make tool requests by filing issues.

## Software Guidelines
In general, these are the guidelines we consider when deciding what to pre-install:

- Tools and ecosystems that are broadly popular and widely-used will be given priority.
- Recent versions of tools will be given priority over older versions.
- Tools and versions that are deprecated or have reached end-of-life will not be added.
- Tools and versions will typically be removed 6 months after they are deprecated or have reached end-of-life.
- If a tool can be installed during the build, we will evaluate how much time is saved
 and how much space is used by having the tool pre-installed.
- MIT, Apache, and GNU licenses are ok, anything else we'll have to check with lawyers.
- If a tool takes much space we will evaluate space usage and provide a decision if this tool can be pre-installed.
- If a tool requires the support of more than one version, we will consider the cost of this maintenance, how often new versions bring dangerous updates.

**Note:** For new tools, please, create an issue and get an approval from us to add this tool to the image before creating the pull request.

## Updates to virtual environments
*Cadence*

We typically deploy weekly updates to the software on the virtual environments.
For some tools, we always install the latest at the time of the deployment; for others,
we pin the tool to specific version(s).

*Following Along / Change Notifications*

* **High Impact Changes** (ex. breaking changes, new or deprecated environments) will be posted to the GitHub Changelog on our [blog](https://github.blog/changelog/) and on [twitter](https://twitter.com/GHchangelog).  
Low Impact changes will be pinned in this repository and marked with the [Announcement](https://github.com/actions/virtual-environments/labels/Announcement) label.
* **Regular Weekly Rhythm** can be followed by watching [Releases](https://github.com/actions/virtual-environments/releases) to see when we generate candidate environments or deploy new ones. You can also track upcoming changes using the [awaiting-deployment](https://github.com/actions/virtual-environments/labels/awaiting-deployment) label.

[ubuntu-20.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-README.md
[ubuntu-18.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1804-README.md
[ubuntu-16.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1604-README.md
[Windows-2019]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md
[windows-2016]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2016-Readme.md
[macOS-10.15]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-10.15-Readme.md
[self-hosted runners]: https://help.github.com/en/actions/hosting-your-own-runners
