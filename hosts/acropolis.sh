# Host-specific shell config for acropolis (personal desktop).
# Sourced at the end of ~/.bashrc when $(hostname -s) == acropolis.

# AMD GPU: make ROCm treat the card as gfx1030
export HSA_OVERRIDE_GFX_VERSION=10.3.0

export PATH="$HOME/.local/maelstrom:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# MonoGame content pipeline under wine
export MGFXC_WINE_PATH="$HOME/.winemonogame"
export PATH="$PATH:$HOME/.winemonogame"
