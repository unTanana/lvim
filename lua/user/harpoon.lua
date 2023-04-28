-- harpoon and buffers
lvim.keys.normal_mode["<C-1>"] = function() require("harpoon.ui").nav_file(1) end
lvim.keys.normal_mode["<C-2>"] = function() require("harpoon.ui").nav_file(2) end
lvim.keys.normal_mode["<C-3>"] = function() require("harpoon.ui").nav_file(3) end
lvim.keys.normal_mode["<C-4>"] = function() require("harpoon.ui").nav_file(4) end
lvim.keys.normal_mode["<S-l>"] = function() require("harpoon.ui").nav_next() end
lvim.keys.normal_mode["<S-h>"] = function() require("harpoon.ui").nav_prev() end
lvim.keys.normal_mode["<C-w>"] = "<C-^>"
