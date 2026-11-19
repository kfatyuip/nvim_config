-- Minimal config compatible with the existing codebase.
globals = { "vim" }
std = "lua51"
max_line_length = 120
allow_defined_top = true
-- The config uses loop vars and module functions; relax unused-warning noise.
unused_args = false
