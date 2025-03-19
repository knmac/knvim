-- Control Jupyter notebook from Neovim
return {
    "kiyoon/jupynium.nvim",
    ft = "python",
    build = "pip3 install --user .",
    -- build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
}
