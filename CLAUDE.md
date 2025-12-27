# Michael's HOME directory

A few notes:
- I use fish shell.
- I use chezmoi to control "dotfiles" + some more config
- I use mise for nearly every tool install. Only when mise does NOT contain something do I reach for other package managers like homebrew (mac), apt, pacman, etc.
- I use the same chezmoi dotfiles config (including this file) on a diverse range of systems. I use several linux distros on remote machines + macOS on my main laptop. Make sure you know what OS / distro you're operating in if that is important!
- I use Orbstack (docker) on macOS for containers, and plain docker on any other linux distro
- For any potentially destructive kubectl / helm / k8s command, ASK ME FOR APPROVAL first, mostly so I can check that you're operating on the right kubecontext.
- For any python things, I use uv. Do not use pipx or raw pip.
- For editors, I use helix / hx from the terminal and Visual Studio Code for more heavyweight editing.

## Structure
- For any cloned down repos, I place them always in the ~/Developer folder. If for some reason that folder does not exist and you want to clone down something, make that directory first.

