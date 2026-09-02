# Host-specific shell config for arrakis (work laptop).
# Sourced at the end of ~/.bashrc when $(hostname -s) == arrakis.

export PATH="$(go env GOPATH)/bin:$HOME/.pulumi-bin:$PATH"

alias ipm="ipython --pylab"
