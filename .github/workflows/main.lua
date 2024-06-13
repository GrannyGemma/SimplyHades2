if config.enabled == true then

    local textfile = rom.path.combine(rom.paths.Content, 'Game/Projectiles/Projectiles.lua')
    
	game.Projectiles.CanBeProjectileDefenseDestroyed = { true }

	local textfile = rom.path.combine(rom.paths.Content, 'Game/Text/HelpText.en.sjson')

	-- SJSON START
	local sjson = rom.mods['SGG_Modding-SJSON']

	local boneTrans = sjson.to_object({
		DisplayName = "Bone Transmutation",
		Description = "{$WorldUpgradeData.WorldUpgradeMixerShadow.CookTime}{!Icons.Clock} {$Keywords.RecipeSpell}: Manifest {#UpgradeFormatDark}+{$WorldUpgradeData.WorldUpgradeMixerShadow.OnActivateFinishedFunctionArgs.ResourceAmount}{#Prev}{!Icons.MetaCurrency}, used to trade for more-valuable resources."
	}, { "DisplayName", "Description" })
	local screenTextPath = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')
	sjson.hook(screenTextPath, function(data)
		table.insert(data.Texts, boneTrans)
	end)
	
	local boneTrans = {
		DisplayName = "Bone Transmutation",
		Description = "{$WorldUpgradeData.WorldUpgradeMixerShadow.CookTime}{!Icons.Clock} {$Keywords.RecipeSpell}: Manifest {#UpgradeFormatDark}+{$WorldUpgradeData.WorldUpgradeMixerShadow.OnActivateFinishedFunctionArgs.ResourceAmount}{#Prev}{!Icons.MetaCurrency}, mostly used to trade for more-valuable resources."
	}
	
	local screenTextPath = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')
	
	sjson.hook(screenTextPath, function(data)
		for _, entry in ipairs(data.Texts) do
			if entry.DisplayName == "Shadow Extraction" then
				entry.DisplayName = boneTrans.DisplayName
				break
			end
			if entry.Description == "{$WorldUpgradeData.WorldUpgradeMixerShadow.CookTime}{!Icons.Clock} {$Keywords.RecipeSpell}: Manifest {#UpgradeFormatDark}+{$WorldUpgradeData.WorldUpgradeMixerShadow.OnActivateFinishedFunctionArgs.ResourceAmount}{#Prev}{!Icons.MixerShadow}, used for powerful incantations." then
				entry.Description = boneTrans.Description
				break
			end
		end
	end)
	-- SJSON END


	-- RECIPES START
	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/MarketData.lua')
	
	game.MarketData.ItemCategories =
	    {
            {
                Name = "MarketScreen_Resources",
                Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
                GameStateRequirements = {},
                    { 
                        BuyName = "MetaCardPointsCommon", BuyAmount = 5, -- Ashes
                        Cost = {
                            MetaCurrency = 10,
                        },
                        Priority = true, 
                        PurchaseSound = "/SFX/AshRewardDrop",
                    },
                    { 
                        BuyName = "MemPointsCommon", BuyAmount = 10, -- Psyche
                        Cost = {
                            MetaCurrency = 20,
                        },
                        Priority = true, 
                        PurchaseSound = "/SFX/Player Sounds/PsycheRewardPickup",
                    },
                    { 
                        BuyName = "MetaFabric", BuyAmount = 1, -- F. Fabric
                        Cost = {
                            MetaCurrency = 30,
                        },
                        Priority = true, 
                        PurchaseSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
                    },
                    { 
                        BuyName = "CardUpgradePoints", -- M. Dust
                        GameStateRequirements = {
                            {
                                Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
                                Comparison = ">=",
                                Value = 3,
                            },
                        },
                        BuyAmount = 1,
                        Cost = {
                            MetaCurrency = 80,
                        },
                        Priority = true,
                        PurchaseSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",
                    },
                    { 
                        BuyName = "WeaponPointsRare", -- N. Mare
                        GameStateRequirements = {
                            {
                                Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
                                Comparison = ">=",
                                Value = 1,
                            },
                        },
                        BuyAmount = 1,
                        Cost = {
                            MetaCurrency = 500,
                        },
                        PurchaseSound = "/SFX/TitanBloodPickupSFX",
                    },
            },
            {
                Name = "MarketScreen_Gifts", -- Nectar
                Icon = "GUI\\Screens\\ResourceShop\\Icon-ExoticGoods",
                GameStateRequirements = {
                    {
                        PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGiftsShop" },
                    },
                },
                Items = {
                    { 
                        BuyName = "GiftPoints",
                        BuyAmount = 1,
                        Cost = {
                            MetaCurrency = 20,
                        },
                        PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
                    },
                    { 
                        BuyName = "GiftPointsRare", -- Bath Salts
                        GameStateRequirements = {
                            {
                                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" }
                            },
                        },
                        BuyAmount = 1,
                        Cost = {
                            MetaCurrency = 30,
                        },
                        PurchaseSound = "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY",
                    },
                    { 
                        BuyName = "GiftPointsEpic", -- Twin Lures
                        GameStateRequirements = {
                            {
                                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" }
                            },
                        },
                        BuyAmount = 1,
                        Cost = {
                            MetaCurrency = 80,
                        },
                        PurchaseSound = "/SFX/SuperGemPickup",
                    },
                    { 
                        BuyName = "SuperGiftPoints", -- Ambrosia
                        GameStateRequirements = {
                            {
                                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" }
                            },
                        },
                        BuyAmount = 1,
                        Cost = {
                            MetaCurrency = 200,
                        },
                        PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
                    },
                },
            }
		}

    local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WeaponShopData.lua')

    game.WeaponShopItemData.WeaponDagger.Cost = { MetaFabric = 1, } -- F. Fabric to unlock weapons
	game.WeaponShopItemData.WeaponTorch.Cost =	{ MetaFabric = 1, }
	game.WeaponShopItemData.WeaponAxe.Cost = 	{ MetaFabric = 1, }
	game.WeaponShopItemData.WeaponLob.Cost = 	{ MetaFabric = 1, }
	game.WeaponShopItemData.StaffClearCastAspect.Cost = 	{ MixerIBoss = 1, } -- Z. Sand to unlock all aspects
	game.WeaponShopItemData.StaffSelfHitAspect.Cost = 		{ MixerIBoss = 1, }
	game.WeaponShopItemData.DaggerBlockAspect.Cost = 		{ MixerIBoss = 1, }
	game.WeaponShopItemData.DaggerHomingThrowAspect.Cost = 	{ MixerIBoss = 1, }
	game.WeaponShopItemData.TorchDetonateAspect.Cost = 		{ MixerIBoss = 1, }
	game.WeaponShopItemData.TorchSprintRecallAspect.Cost = 	{ MixerIBoss = 1, }
	game.WeaponShopItemData.AxeArmCastAspect.Cost = 		{ MixerIBoss = 1, }
	game.WeaponShopItemData.AxePerfectCriticalAspect.Cost = { MixerIBoss = 1, }
	game.WeaponShopItemData.LobCloseAttackAspect.Cost = 	{ MixerIBoss = 1, }
	game.WeaponShopItemData.LobImpulseAspect.Cost = 		{ MixerIBoss = 1, }
	game.WeaponShopItemData.BaseStaffAspect2.Cost = { MixerFBoss = 1, } -- Cinder to upgrade all Staff aspects
	game.WeaponShopItemData.BaseStaffAspect3.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.BaseStaffAspect4.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.BaseStaffAspect5.Cost = { MixerFBoss = 2, }
	game.WeaponShopItemData.StaffClearCastAspect2.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.StaffClearCastAspect3.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.StaffClearCastAspect4.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.StaffClearCastAspect5.Cost = { MixerFBoss = 2, }
	game.WeaponShopItemData.StaffSelfHitAspect2.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.StaffSelfHitAspect3.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.StaffSelfHitAspect4.Cost = { MixerFBoss = 1, }
	game.WeaponShopItemData.StaffSelfHitAspect5.Cost = { MixerFBoss = 2, }
	game.WeaponShopItemData.DaggerBackstabAspect2.Cost = { MixerGBoss = 1, } -- Pearl to upgrade all Dagger aspects
	game.WeaponShopItemData.DaggerBackstabAspect3.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerBackstabAspect4.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerBackstabAspect5.Cost = { MixerGBoss = 2, }
	game.WeaponShopItemData.DaggerBlockAspect2.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerBlockAspect3.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerBlockAspect4.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerBlockAspect5.Cost = { MixerGBoss = 2, }
	game.WeaponShopItemData.DaggerHomingThrowAspect2.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerHomingThrowAspect3.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerHomingThrowAspect4.Cost = { MixerGBoss = 1, }
	game.WeaponShopItemData.DaggerHomingThrowAspect5.Cost = { MixerGBoss = 2, }
	game.WeaponShopItemData.AxeRecoveryAspect2.Cost = { WeaponPointsRare = 1, } -- N. Mare to upgrade all Axe aspects
	game.WeaponShopItemData.AxeRecoveryAspect3.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxeRecoveryAspect4.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxeRecoveryAspect5.Cost = { WeaponPointsRare = 2, }
	game.WeaponShopItemData.AxeArmCastAspect2.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxeArmCastAspect3.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxeArmCastAspect4.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxeArmCastAspect5.Cost = { WeaponPointsRare = 2, }
	game.WeaponShopItemData.AxePerfectCriticalAspect2.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxePerfectCriticalAspect3.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxePerfectCriticalAspect4.Cost = { WeaponPointsRare = 1, }
	game.WeaponShopItemData.AxePerfectCriticalAspect5.Cost = { WeaponPointsRare = 2, }
	game.WeaponShopItemData.TorchSpecialDurationAspect2.Cost = { MixerNBoss = 1, } -- Wool to upgrade all Torch aspects
	game.WeaponShopItemData.TorchSpecialDurationAspect3.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchSpecialDurationAspect4.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchSpecialDurationAspect5.Cost = { MixerNBoss = 2, }
	game.WeaponShopItemData.TorchDetonateAspect2.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchDetonateAspect3.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchDetonateAspect4.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchDetonateAspect5.Cost = { MixerNBoss = 2, }
	game.WeaponShopItemData.TorchSprintRecallAspect2.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchSprintRecallAspect3.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchSprintRecallAspect4.Cost = { MixerNBoss = 1, }
	game.WeaponShopItemData.TorchSprintRecallAspect5.Cost = { MixerNBoss = 2, }
	game.WeaponShopItemData.LobAmmoBoostAspect2.Cost = { MixerHBoss = 1, } -- Tears to upgrade all Skull aspects
	game.WeaponShopItemData.LobAmmoBoostAspect3.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobAmmoBoostAspect4.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobAmmoBoostAspect5.Cost = { MixerHBoss = 2, }
	game.WeaponShopItemData.LobCloseAttackAspect2.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobCloseAttackAspect3.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobCloseAttackAspect4.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobCloseAttackAspect5.Cost = { MixerHBoss = 2, }
	game.WeaponShopItemData.LobImpulseAspect2.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobImpulseAspect3.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobImpulseAspect4.Cost = { MixerHBoss = 1, }
	game.WeaponShopItemData.LobImpulseAspect5.Cost = { MixerHBoss = 2, }
	game.WeaponShopItemData.ToolPickaxe.Cost = 		{ MetaCurrency = 5, }
	game.WeaponShopItemData.ToolExorcismBook.Cost = { MetaCurrency = 5, }
	game.WeaponShopItemData.ToolShovel.Cost = 		{ MetaCurrency = 5, }
	game.WeaponShopItemData.ToolFishingRod.Cost = 	{ MetaCurrency = 5, }
	game.WeaponShopItemData.ToolPickaxe2.Cost = 		{ MetaFabric = 2 }
	game.WeaponShopItemData.ToolExorcismBook2.Cost = 	{ MetaFabric = 2 }
	game.WeaponShopItemData.ToolShovel2.Cost = 			{ MetaFabric = 2 }
	game.WeaponShopItemData.ToolFishingRod2.Cost = 		{ MetaFabric = 2 }

    	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData.lua')

	game.WorldUpgradeData.WorldUpgradeQuestLog.Cost =
			{
				MetaCurrency = 20,
				MetaCardPointsCommon = 10,
				MemPointsCommon = 5,
			}
    game.WorldUpgradeData.WorldUpgradeMorosUnlock.Cost =
			{
				MetaCurrency = 5,
				MetaFabric = 2,
			}
	game.WorldUpgradeDataWorldUpgradePinning.Cost
			{
				MetaCardPointsCommon = 5,
			}
	game.WorldUpgrade.WorldUpgradeResourceFinder.Cost
			{
				MetaFabric = 1,
			}
	game.WorldUpgrade.WorldUpgradeMarket.Cost =
			{
				MetaCurrency = 10,
			}
	game.WorldUpgrade.WorldUpgradeSellShop.Cost =
			{
				MetaCardPointsCommon = 5,
				MetaFabric = 1,
			}
	game.WorldUpgrade.WorldUpgradeWellShops.Cost =
			{
				MemPointsCommon = 5,
				MetaCardPointsCommon = 5,
			}
	game.WorldUpgrade.WorldUpgradeErebusReprieve.Cost =
			{
				MemPointsCommon = 5,
				MetaCardPointsCommon = 5,
			}
	game.WorldUpgrade.WorldUpgradeFountainUpgrade1.Cost =
			{
				MemPointsCommon = 5,
				MetaCardPointsCommon = 5,
			}
	game.WorldUpgrade.WorldUpgradeToolsShop.Cost =
			{
				MetaFabric = 1,
			}
	game.WorldUpgrade.WorldUpgradeGarden.Cost =
			{
				-- Free
			}
	game.WorldUpgrade.WorldUpgradeTaverna.Cost =
				{
					GiftPoints = 2,
					MetaFabric = 1,
					MixerGBoss = 1,
				}
	game.WorldUpgrade.WorldUpgradeBathHouse.Cost =
				{
					MixerFBoss = 1,
					MixerHBoss = 1,
				}
	game.WorldUpgrade.WorldUpgradeFishingPoint.Cost =
				{
					MixerGBoss = 1,
				}
	
	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Hub.lua') -- Hub
	
	game.WorldUpgradeData_Hub.WorldUpgradeTaverna.Cost =
			{
				GiftPoints = 2,
				MetaFabric = 1,
				MixerGBoss = 1,
			}
	game.WorldUpgradeData_Hub.WorldUpgradeBathHouse.Cost =
			{
				MixerFBoss = 1,
				MixerHBoss = 1,
			}
	game.WorldUpgradeData_Hub.WorldUpgradeFishingPoint.Cost =
			{
				MixerGBoss = 1,
			}

	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Repeatable.lua') -- Repeatable

    game.WorldUpgradeData_Repeatable.WorldUpgradeMixerShadow =
			{
                InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
                Icon = "CosmeticIcon_SkullPile",
                Cost =
                {
                    CardUpgradePoints = 6,
                    MixerIBoss = 1,
                },
                CookTime = 12,
                Repeatable = true,
                SkipUnlockText = true,
                UnlockTextId = "RepeatableUnlock",
                OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
                OnActivateFinishedFunctionArgs = { ResourceName = "MetaCurrency", ResourceAmount = 600, WaitTime = 0.4, SoundName = "/Leftovers/Menu Sounds/TitanToggleLong" },
        
                IgnoreAffordable = true,
        
                GameStateRequirements =
                {
                    NamedRequirements = { "AlchemyUnlocked" },
                }, 
            }
	
	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Run.lua') -- Run

	game.WorldUpgradeData_Run.WorldUpgradePostBossWellShops.Cost =
		{
			MemPointsCommon = 5,
			MetaCardPointsCommon = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradeSurfaceShops.Cost =
		{
			MetaCardPointsCommon = 5,
			MetaCurrency = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradePostBossSurfaceShops.Cost =
		{
			MetaFabric = 2,
			MetaCurrency = 5,
			MetaCardPointsCommon = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradeOceanusReprieve.Cost =
		{
			MemPointsCommon = 5,
			MetaCardPointsCommon = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradeTartarusReprieve.Cost =
		{
			MemPointsCommon = 10,
			MetaCardPointsCommon = 10,
		}
	game.WorldUpgradeData_Run.WorldUpgradeThessalyReprieve.Cost =
		{
			MemPointsCommon = 5,
			MetaCardPointsCommon = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradeFountainUpgrade.Cost =
		{
			MemPointsCommon = 5,
			MetaCardPointsCommon = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradeBreakableValue1.Cost =
		{
			MetaCurrency = 20,
		}
	game.WorldUpgradeData_Run.WorldUpgradeEphyraZoomOut.Cost =
		{
			MetaCurrency = 15,
			TrashPoints = 3,
		}
	game.WorldUpgradeData_Run.WorldUpgradeFieldsRewardFinder.Cost =
		{
			MemPointsCommon = 5,
		}
	game.WorldUpgradeData_Run.WorldUpgradePauseChronosFight.Cost =
		{
			MixerIBoss = 3,
			MixerHBoss = 1,
		}
	game.WorldUpgradeData_Run.WorldUpgradeUnusedWeaponBonus.Cost =
		{
			MetaCurrency = 10,
		}
	game.WorldUpgradeData_Run.WorldUpgradePostBossGiftRack.Cost =
		{
			MetaFabric = 4,
		}
	game.WorldUpgradeData_Run.WorldUpgradeErebusSafeZones.Cost =
		{
			MetaFabric = 2,
			MixerFBoss = 1,
		}
	game.WorldUpgradeData_Run.WorldUpgradeShadeMercs.Cost =
		{
			MemPointsCommon = 20,
			MetaFabric = 1,
		}
	game.WorldUpgradeData_Run.WorldUpgradeChallengeSwitches1.Cost =
		{
			MixerFBoss = 1,
			MixerGBoss = 1,
		}

	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Story.lua') -- Story

	game.WorldUpgradeData_Story.WorldUpgradeTimeStop.Cost =
		{
			MixerIBoss = 9999,
			MixerMythic = 9999,
		}
	game.WorldUpgradeData_Story.WorldUpgradeAltRunDoor.Cost =
		{
			MixerFBoss = 2,
			CardUpgradePoints = 4,
			MetaFabric = 6,
		}
	game.WorldUpgradeData_Story.WorldUpgradeSurfacePenaltyCure.Cost =
		{
			MetaCardPointsCommon = 20,
			MemPointsCommon = 40,
			MixerHBoss = 1,
		}
	game.WorldUpgradeData_Story.WorldUpgradeNarcissusWaters.Cost =
		{
			MixerGBoss = 3,
			MixerHBoss = 3,
		}

	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Support.lua') -- Support

	game.WorldUpgradeData_Support.WorldUpgradeHarvestUpgrade.Cost =
		{
			-- Free
		}
	game.WorldUpgradeData_Support.WorldUpgradeGardenT2.Cost =
		{
			-- Free
		}
	game.WorldUpgradeData_Support.WorldUpgradeGardenT3.Cost =
		{
			-- Free
		}
	game.WorldUpgradeGardenTent.Cost =
		{
			-- Free
		}
	game.WorldUpgradeData_Support.WorldUpgradeGardenTaverna.Cost =
		{
			-- Free
		}
	game.WorldUpgradeData_Support.WorldUpgradeRunHistory.Cost =
		{
			MetaCurrency = 20,
			MixerOBoss = 1,
		}
	game.WorldUpgradeData_Support.WorldUpgradeGameStats.Cost =
		{
			MetaCurrency = 20,
			MixerIBoss = 1,
		}
	game.WorldUpgradeData_Support.WorldUpgradeGiftsShop.Cost =
		{
			MetaCurrency = 60,
		}
	game.WorldUpgradeData_Support.WorldUpgradeRelationshipBar.Cost =
		{
			MetaFabric = 1,
			MixerGBoss = 1,
		}

	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Systems.lua') -- Systems

	game.WorldUpgradeData_Systems.WorldUpgradeWeaponUpgradeSystem.Cost =
			{
				MemPointsCommon = 60,
				CardUpgradePoints = 4,
				MixerHBoss = 1,
			}
	game.WorldUpgradeData_WorldUpgradeCardUpgradeSystem.Cost =
			{
				MemPointsCommon = 20,
				MetaCardPointsCommon = 20,
				MixerFBoss = 1,
			}
	game.WorldUpgradeData_WorldUpgradeBountyBoard.Cost =
			{
				CardUpgradePoints = 8,
				MixerGBoss = 1,
				MixerNBoss = 1,
			}
	game.WorldUpgradeData_WorldUpgradeFamiliarSystem.Cost =
			{
				CardUpgradePoints = 2,
				GiftPoints = 2,
			}
	game.WorldUpgradeData_WorldUpgradeFamiliarRest.Cost =
			{
				MixerHBoss = 1,
				MixerNBoss = 1,
			}
	game.WorldUpgradeData_WorldUpgradeToolUpgradeSystem.Cost =
			{
				MemPointsCommon = 30,
				CardUpgradePoints = 1,
			}

	local textfile = rom.path.combine(rom.paths.Content, 'Scripts/WorldUpgradeData_Upgrades.lua') -- Upgrades

	game.WorldUpgradeData_Upgrades.WorldUpgradeElementalBoons.Cost =
		{
			MemPointsCommon = 20,
		}
	game.WorldUpgradeData_Upgrades.WorldUpgradeBoonList.Cost =
		{
			CardUpgradePoints = 2,
			MixerOBoss = 1,
			SuperGiftPoints = 1,
		}
    -- RECIPES END

    end
