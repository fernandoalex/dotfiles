require('neorg').setup{
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.integrations.telescope"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/git/org",
				}
			}
		}
	}
}
