# Watsup: Watson on Docker

## Table of Contents

1. [Overview](#overview)
1. [Needs](#needs)
    1. [The Problem](#the-problem)
    1. [Two Modes](#two-modes)
    1. [Portability](#portability)
1. [Solution](#solution)
1. [Installion](#installion)
1. [Usage](#usage)
1. [Resources](#resources)

## Overview

This project serves to provide a lightweight container for running Watson time tracker using docker, make, and shell scripting.

## Needs

Tracking one's time is not only a good way to document *how and what* you are doing, but also to *stay focused* on those very things.

To that end, I started using [Watson](https://github.com/TailorDev/Watson) several months ago. It's simple, lightweight, and runs in the shell. Its developers also released [a web based GUI]  but I'm less interested in that than I am about its Dockerized environment, which is quite similar to my own solution, detailed below. I'm curious to explore the differences. In any case, I digress.

My development machine was recently wiped and imaged with a clean install of MacOS. I'd like to keep it that way, save a few key tools. I've also since come to find [others] whose philosophy and approach to this is remarkably similar to my own.

### So finally, the problem

Watson requires python 3.7 while my MacOS system (10.15.x) runs 2.7. I'm a fan of pip, conda, et al, but I'd really like to avoid these tools and leave the OS's native tools in tact. Sure, I could leave the dirty work to [homebrew] or any number of other library management methods, but that all just feels sloppy at best.

I'm also hoping to use my solution as a paradigm for other tools - mostly to further wean my homebrew depedency.

I love homebrew and I really think their dependency management solutions are robust and ingenious. But I haven't not had issues with simple upgrades and stale packages breaking system tools, and I'd rather just avoid all that spaghetti.

### Two Modes

CLI Users should have two ways to use Watson:

1. As if it's on their local system, through their shell of choice
1. As if it's a remote development server, through a shell that connects to a container/vm/etc.

Of course, in either case, watson *is* runnning in a container, but one case feels like the host and other feels like a container.

### Portability

For maximal portability, I'd like Watson's data to be in a shared location. It doesn't matter whether this is a dropbox folder or on my network storage - just somewhere it can be accessed by multiple machines.

In linix systems, Watson stores its data at ```/root/.config/watson```. We'll be making use of this later.

## Solution

A high-level overview of the tools and ideas to solve this:

1. Docker
1. Makefiles
1. Shell scripting
1. Git
1. Markdown and possibly conversion via pandoc for documentation

### Docker and Docker Compose

In this case, we're really only using Docker, but Compose is a workhorse when working with multiservice tools and builds.

### Makefiles

Makefiles do two critical things:

1. they expose *targets*, ostensibly functioning as a quick API
1. they serve as functional documentation [5] for important commands by facilitating their easy use

### Shell Scripting

We're going to need a way to simulate the local user cli experience. We'll simply override the watson command using a shell function and load the source after starting docker via make.

This was honestly what I thought was going to be the most complex problem to solve (and I still believe it to be so), but the above is a very simple and more importantly *functional* approach, in all meanings of the word.

### Git

Nice things are nice, and in that regard, version control is no slouch.

### Markdown and pandoc

MD is the goto markup in which to get out thoughts quickly, and it's easily converted to other formats using pandoc (if necessary).

## Installation

### Dependencies

1. A *nix-like shell and filesystem compatible with the below tools. I use iTerm on MacOS and konsole in Debian.
1. git
1. [docker desktop](https://www.docker.com/products/docker-desktop) (or, at least docker 17+)

### Installing and Building

1. Clone from github:
``` git clone git@github.com:sarandi/watsup.git ```
1. cd to the watson directory ```cd watsup```
1. optional: for whatever reason, if you want to change where watson mounts its volume, change the ```watson_DATADIR``` path in Makefile. The default is the *watson* directory within the watsup project directory
1. build the image using ```make dbuild```
1. create the container using ```make dcreate```. This will only create the container from the image; it will not do the initial execution/run step common with ```docker run <options>```
1. optional: rename the example.gitignore file to ```.gitignore``` and change any omissions as you see fit.

## Usage

The following are simple commands to get started using watson as quickly as possible, using either mode described above.

### Starting and stopping the container

1. start the container using ```make dstart```
1. stop the container using ```make dstop```

### Host mode

While the container is running, you'll be able to issue any watson command as if it were running on your local system. Common commands include:

```shell
watson help

watson start projectname +tag +names

watson stop

watson projects

watson tags
```

### Container mode

Run ```make dcon``` to access an interactive non-login shell directly on the container.

Once inside, simply run watson as above.

## Resources

1. https://github.com/TailorDev/Watson
2. https://x-team.com/blog/keep-your-local-machine-clean-with-docker-2/
3. https://github.com/tailordev/crick
4. https://brew.sh/
5. https://tex.stackexchange.com/questions/46907/tex-live-installs-makefiles-as-documentation
