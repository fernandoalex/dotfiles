-- [[
-- copied from https://stackoverflow.com/questions/132397/get-back-the-output-of-os-execute-in-lua
--
-- TODO: In the future revisit this as I did this in the first day of starting to use nix
-- ]]
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local IS_IN_NIX_SHELL = os.getenv("IN_NIX_SHELL")
local JAVA_LSP_PATH = ''
if IS_IN_NIX_SHELL == nil then 
	JAVA_LSP_PATH = os.capture("which java-language-server", false)
else 
	JAVA_LSP_PATH = os.capture("nix-store -q $(which java-language-server)", false)
end

-- require('jdtls').start_or_attach {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { string.format("%s/bin/jdt-language-server", string.gsub(JAVA_LSP_PATH, '\n', ''))},
-- 	root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw', '*.java'}, { upward = true })[1]),
-- }

require'lspconfig'.java_language_server.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {	string.format("%s/share/java/java-language-server/lang_server_mac.sh", string.gsub(JAVA_LSP_PATH, '\n', '')) }
}
