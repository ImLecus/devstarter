# Devstarter
##### A simple terminal tool to initialize project templates

## Table of contents
* [Introduction](#introduction)
* [Installation](#installation)
* [Templates](#templates)
* [How to contribute](#how-to-contribute)


### Introduction

Welcome to Devstarter. This is a terminal tool written in Bash, made for the creation of new projects. To use it, open a terminal inside the project folder and type the following command:

```bash
devstarter create [templates] [project-name] [flags]
```

If this method is not intuitive enough, there is a template manager included using:

```bash
devstarter init
```

It will create a visual menu to choose a template and some extra options, as initializing a new Git repository or putting the template in a new folder.

### Installation

For Unix/Linux users: 

Download the package and install the tool by executing `install.sh`.

### Templates
At this moment, devstarter has the following templates:
* C
* C with CMake
* C++
* Quarzum
* Python
* Ruby
* Node JS
* Perl

Do you want to add a new template or add content to an existing one? Check out [how to contribute](#how-to-contribute).

### How to contribute

#### Solving bugs, adding more content...

Check [CONTRIBUTING.md](CONTRIBUTING.md).

#### Adding more templates

Inside the `templates` folder, there is a [CONTRIBUTING.md](./templates/CONTRIBUTING.md) file, that contains all the instructions to add a new template.
  