﻿Get-WmiObject -Class Win32_Product | sort-object Name | select Name | where { $_.Name -match “Office”}