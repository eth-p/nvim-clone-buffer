# nvim-clone-buffer
A small neovim plugin for creating a scratch copy of the current buffer.

## Installation

**With Lazy.nvim:**

```lua
{
    "eth-p/nvim-clone-buffer",
    opts = {
        -- ...
    }
}
```

## Usage

This plugin registers two user commands:


### `:CloneBuffer`

Creates a copy of the current buffer and switches the current window to it.

### `:CloneBufferInBackground`

Creates a copy of the current buffer and leaves it in the background.

## Configuration

>[!tip]
> **enabled**: If set to `false`, the plugin's user commands will not be registered.
>
> Type: `boolean`  
> Default: `true`

>[!tip]
> **cloned_options**: The buffer-local options that will be cloned.
> If an option is set to false, it will be skipped.
>
> Type: `map<string, boolean>`  
> Default:
>
> ```lua
> {
>     filetype = true,
>     syntax = true,
>
>     shiftwidth = true,
>     expandtab = true,
>     tabstop = true,
> }
> ```

>[!tip]
> **cloned_vars**: The buffer-local variables that will be cloned.
> If the variable is set to false, it will be skipped.
>
> Type: `map<string, boolean>`  
> Default:
>
> ```lua
> {}
> ```
