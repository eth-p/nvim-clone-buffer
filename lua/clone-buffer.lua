local M = {}

local settings = {
	enabled = true,
	suppress_autocmd = true,

	cloned_options = {
		filetype = true,
		syntax = true,

		shiftwidth = true,
		expandtab = true,
		tabstop = true,
	},

	cloned_vars = {},
}

local function do_copy_text(from_buf, to_buf)
	local text = vim.api.nvim_buf_get_lines(from_buf, 0, -1, false)
	vim.api.nvim_buf_set_lines(to_buf, 0, -1, false, text)
end

local function do_copy_options(src, dest, filter)
	for name, enabled in pairs(filter) do
		if enabled then
			dest[name] = src[name]
		end
	end
end

local function do_create_clone(from_buf)
	local api = vim.api

	-- Create a new buffer.
	local to_buf = api.nvim_create_buf(false, false)

	-- Copy text/options/variables to the new buffer.
	do_copy_text(from_buf, to_buf)
	do_copy_options(vim.bo[from_buf], vim.bo[to_buf], settings.cloned_options)
	do_copy_options(vim.b[from_buf], vim.b[to_buf], settings.cloned_vars)

	-- Mark the buffer as unmodified.
	vim.bo[to_buf].modified = false

	-- Allow the buffer to be listed.
	vim.bo[to_buf].buflisted = true
	return to_buf
end

-- API:
function M.create_clone(buf_num)
	local autocmd_state = vim.g.autocmd_enabled
	if settings.suppress_autocmd then
		vim.g.autocmd_enabled = false
	end

	local new_buf = do_create_clone(buf_num)

	if settings.suppress_autocmd then
		vim.g.autocmd_enabled = autocmd_state
	end

	return new_buf
end

-- Commands:
M.commands = {}
function M.commands.CloneBufferInBackground()
	local buf_num = vim.api.nvim_win_get_buf(0) -- current window
	M.create_clone(buf_num)
end

function M.commands.CloneBuffer()
	local buf_num = vim.api.nvim_win_get_buf(0) -- current window
	local new_buf = M.create_clone(buf_num)
	vim.api.nvim_win_set_buf(0, new_buf)
end

-- Setup:
function M.setup(opts)
	settings = vim.tbl_deep_extend("force", settings, opts)

	if settings.enabled then
		vim.api.nvim_create_user_command(
			"CloneBufferInBackground",
			M.commands.CloneBufferInBackground,
			{}
		)

		vim.api.nvim_create_user_command(
			"CloneBuffer",
			M.commands.CloneBuffer,
			{}
		)
	end
end

return M
