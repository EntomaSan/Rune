spawn(function()
	task.wait(2400)
	game:GetService("TeleportService"):Teleport(10290054819, game.Players.LocalPlayer)
end)
pcall(function()
	repeat
		wait()
	until game:IsLoaded()
	if game.PlaceId == 99995671928896 then
		repeat wait() until game.Players.LocalPlayer ~= nil
		local HttpService = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")

		-- Function to append content to a file
		local function appendfile(path, contents)
			writefile(path, (readfile(path) or "") .. contents .. "\n")
		end

		-- Function to load settings from a file
		local function LoadSettings(path)
			local str = readfile(path)
			return HttpService:JSONDecode(str)
		end

		-- Function to write settings to a file
		local function WriteSettings(path, settingsTable)
			writefile(path, HttpService:JSONEncode(settingsTable))
		end

		-- Generate filename based on the current date
		local dateStr = tostring(os.date("%Y-%m-%d"))
		local filename = dateStr .. ".lua"
		if isfile(filename) then
			local _table = LoadSettings(dateStr..".lua")
			if _table == nil or _table[1] == nil or #_table <= 5 then
				local PlaceId = 99995671928896  -- Use game's actual PlaceId
				local JobId = game.JobId  -- Use game's JobId

				if not PlaceId then
					warn("Error: PlaceId is nil!")
					return
				end

				local servers = {}
				local maxAttempts = 10
				local req = syn and syn.request or (http and http.request) or request

				if not req then
					warn("HTTP Request function not found.")
					return TeleportService:Teleport(10290054819, Players.LocalPlayer)
				end

				for attempt = 1, maxAttempts do
					--print("Attempting to fetch server list... Attempt " .. attempt)

					local response = req({
						Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId),
						Method = "GET"
					})

					if response and response.Body then
						local success, body = pcall(function()
							return HttpService:JSONDecode(response.Body)
						end)

						if success and body and body.data then
							for _, v in ipairs(body.data) do
								if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
									table.insert(servers, 1, v.id)
								end
							end
						end
					end

					if #servers > 0 then
						break
					end

					if attempt < maxAttempts then
						wait(5) -- Small delay before retrying
					end
				end

				if #servers > 0 then
					WriteSettings(filename, servers)
				else
					warn("No valid servers found.")
				end
			end
		end
		-- Check if file exists
		if not isfile(filename) then
			local PlaceId = 99995671928896  -- Use game's actual PlaceId
			local JobId = game.JobId  -- Use game's JobId

			if not PlaceId then
				warn("Error: PlaceId is nil!")
				return
			end

			local servers = {}
			local maxAttempts = 10
			local req = syn and syn.request or (http and http.request) or request

			if not req then
				warn("HTTP Request function not found.")
				return TeleportService:Teleport(10290054819, Players.LocalPlayer)
			end

			for attempt = 1, maxAttempts do
				--print("Attempting to fetch server list... Attempt " .. attempt)

				local response = req({
					Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId),
					Method = "GET"
				})

				if response and response.Body then
					local success, body = pcall(function()
						return HttpService:JSONDecode(response.Body)
					end)

					if success and body and body.data then
						for _, v in ipairs(body.data) do
							if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
								table.insert(servers, 1, v.id)
							end
						end
					end
				end

				if #servers > 0 then
					break
				end

				if attempt < maxAttempts then
					wait(5) -- Small delay before retrying
				end
			end

			if #servers > 0 then
				WriteSettings(filename, servers)
			else
				warn("No valid servers found.")
			end
		end
		local shop = function(Step)
			wait(.5)
			--print(Step)
			game:GetService("TeleportService"):Teleport(10290054819, game.Players.LocalPlayer)
		end
		repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild"PlayerGui"
		repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild"Menu"
		repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.Menu:FindFirstChild"ButtonFrame"
		repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.Menu.ButtonFrame:FindFirstChild"PlayButton"
		local startA = tick()
		repeat
    		pcall(function()
            		if game.Players.LocalPlayer.ClientNetwork:FindFirstChild"MenuOptions" then
            		local args = {
                        [1] = {
                            ["config"] = "start_screen"
                        }
                    }
                    
                    game:GetService("Players").LocalPlayer.ClientNetwork.MenuOptions:FireServer(unpack(args))
        	    end
            		if game.Players.LocalPlayer.ClientNetwork:FindFirstChild"MenuOptions" then
                    local args = {
                        [1] = {
                            ["slot"] = "Slot_1",
                            ["config"] = "slots"
                        }
                    }
                    
                    game:GetService("Players").LocalPlayer.ClientNetwork.MenuOptions:FireServer(unpack(args))
        	    end
        		wait(2)
    	    end)
		until game.Players.LocalPlayer.Character ~= nil or (tick() - startA) >= 20
		if tick() - startA >= 20 then
			game:GetService("TeleportService"):Teleport(10290054819, player)
		end
		repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
		repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"CharacterHandler"
		repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"CharacterHandler":FindFirstChild"Input"
		repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"CharacterHandler":FindFirstChild"Input":FindFirstChild"Events"
		repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"CharacterHandler":FindFirstChild"Input":FindFirstChild"Events":FindFirstChild"MasterEvent"
		wait(.5)
		print"Detected Character"
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			game:GetService("VirtualUser"):CaptureController()
			game:GetService("VirtualUser"):ClickButton2(Vector2.new(math.random(10, 50), math.random(10, 50)))
		end)
		local CurrentCheck = 0
		for _,v in pairs(game.Players:GetPlayers()) do
			if v:IsA("Player") then
				spawn(function()
					if v:IsDescendantOf(game.Players) and v and v:GetRankInGroup(15431531) >= 1 then
						CurrentCheck = CurrentCheck + 1
						wait()
						shop("2")
					else
						CurrentCheck = CurrentCheck + 1
					end
				end)
			end
		end


		--CheckAddedPlayer
		game.Players.PlayerAdded:Connect(function(v)
			wait()
			if v:IsDescendantOf(game.Players) and v and v:GetRankInGroup(15431531) >= 1 then
				shop("3")
			end
		end)

		local MainTick = tick()
		repeat wait() until CurrentCheck >= #game.Players:GetChildren() or tick() - MainTick >= 4
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")

		local function checkAndTeleport()
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local playerPosition = player.Character.HumanoidRootPart.Position
					local distance = (playerPosition - Vector3.new(1013.8218383789062, -239.08447265625, 1572.6201171875)).magnitude
					if distance <= 500 then
						shop("Found Player")
					end
				end
			end
		end

		--Check CF
		spawn(function()
			while wait(2) do
				local player = game.Players.LocalPlayer
				local infoOverlays = player:WaitForChild("PlayerGui"):WaitForChild("InfoOverlays")
				local confirmFrame = infoOverlays:FindFirstChild("ConfirmFrame")

				if confirmFrame then
					task.delay(8, function()
						if infoOverlays:FindFirstChild("ConfirmFrame") then
							local Players = game:GetService("Players")

							local player = Players.LocalPlayer
							local gui = player:WaitForChild("PlayerGui"):WaitForChild("InfoOverlays", 5) -- Wait for InfoOverlays with a timeout

							if not gui then
								warn("InfoOverlays not found")
								return shop("5")
							end

							local confirmFrame = gui:WaitForChild("ConfirmFrame", 5)
							if not confirmFrame then
								warn("ConfirmFrame not found")
								return shop("6")
							end

							local mainFrame = confirmFrame:WaitForChild("MainFrame", 5)
							if not mainFrame then
								warn("MainFrame not found")
								return shop("7")
							end

							local buttonFrame = mainFrame:WaitForChild("ButtonFrame", 5)
							if not buttonFrame then
								warn("ButtonFrame not found")
								return shop("8")
							end

							local confirmButton = buttonFrame:WaitForChild("ConfirmButton", 5)
							if not confirmButton then
								warn("ConfirmButton not found")
								return shop("9")
							end

							repeat
								if confirmButton then
									local absPos = confirmButton.AbsolutePosition
									local absSize = confirmButton.AbsoluteSize

									-- Calculate the center of the button
									local clickPos = absPos + (absSize / 2)

									-- Simulate a left mouse click at the button's position
									--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
									wait(3)
								end
								task.wait()
							until not gui:FindFirstChild("ConfirmFrame")

							repeat wait() until game.Players.LocalPlayer.Character:IsDescendantOf(game.Workspace.Alive)
							wait(0.5)
							_G.Botting()
						end
					end)
				end
			end
		end)
		print"Checked"
		_G.Botting = function()
			repeat wait() until game.Players.LocalPlayer ~= nil
			repeat wait() until game.Players.LocalPlayer.Character ~= nil
			repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"HumanoidRootPart"
			repeat wait() until workspace.InvisibleParts:FindFirstChild"ColosseumEntrance"
			repeat wait() until workspace.InvisibleParts:FindFirstChild"ColosseumEntrance":FindFirstChild"InteractPrompt"
			repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("BoolValues")
			repeat wait() until game.Players.LocalPlayer.Character.BoolValues:FindFirstChild"CombatTag"
			repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild"Humanoid"
			checkAndTeleport()
			for i,v in pairs(game.Workspace.Alive:GetChildren()) do
				if v.Name:find"Lycanthar" or v.Name:find"Drogar" then
					if v:FindFirstChild"Humanoid" then
						if v.Humanoid.Health >= v.Humanoid.MaxHealth*0.95 then
							shop("10")
						end
					end
				end
			end
			function TP(Object) -- Object = part teleporting to.
				local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Object).magnitude/90,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0)
				local tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(Object + Vector3.new(0,0,0))})
				tween:Play()
				tween.Completed:Wait()
			end
			function TPNormal(Object) -- Object = part teleporting to.
				local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Object).magnitude/100,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0)
				local tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(Object + Vector3.new(0,0,0))})
				tween:Play()
				tween.Completed:Wait()
			end

			game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			fireproximityprompt(workspace.InvisibleParts.ColosseumEntrance.InteractPrompt)
			print"Tped"
			local startTime = tick()
			while (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1025.1005859375, -197.8874969482422, 1363.8944091796875)).magnitude >= 10 do
				if tick() - startTime > 2 then
					if game.Players.LocalPlayer.Character:FindFirstChild("BoolValues") then
						if game.Players.LocalPlayer.Character.BoolValues:FindFirstChild"CombatTag" then
							if game.Players.LocalPlayer.Character.BoolValues.CombatTag.Value >= 1 then
								if game.Players.LocalPlayer.Character:FindFirstChild"Humanoid" and game.Players.LocalPlayer.Character:FindFirstChild"Humanoid".Health > 0 then
									repeat wait()
										game.Players.LocalPlayer.Character.Humanoid.Health = 0
									until game.Players.LocalPlayer.Character.Humanoid.Health == 0
									local Players = game:GetService("Players")

									local player = Players.LocalPlayer
									local gui = player:WaitForChild("PlayerGui"):WaitForChild("InfoOverlays", 5) -- Wait for InfoOverlays with a timeout

									if not gui then
										warn("InfoOverlays not found")
										return shop("11")
									end

									local confirmFrame = gui:WaitForChild("ConfirmFrame", 5)
									if not confirmFrame then
										warn("ConfirmFrame not found")
										return shop("12")
									end

									local mainFrame = confirmFrame:WaitForChild("MainFrame", 5)
									if not mainFrame then
										warn("MainFrame not found")
										return shop("13")
									end

									local buttonFrame = mainFrame:WaitForChild("ButtonFrame", 5)
									if not buttonFrame then
										warn("ButtonFrame not found")
										return shop("14")
									end

									local confirmButton = buttonFrame:WaitForChild("ConfirmButton", 5)
									if not confirmButton then
										warn("ConfirmButton not found")
										return shop("15")
									end

									repeat
										if confirmButton then
											local absPos = confirmButton.AbsolutePosition
											local absSize = confirmButton.AbsoluteSize

											-- Calculate the center of the button
											local clickPos = absPos + (absSize / 2)

											-- Simulate a left mouse click at the button's position
											--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
											wait(3)
										end
										task.wait()
									until not gui:FindFirstChild("ConfirmFrame")

									repeat wait() until game.Players.LocalPlayer.Character:IsDescendantOf(game.Workspace.Alive)
									wait(0.5)
									_G.Botting()
								end

							end
						end
					end
					fireproximityprompt(workspace.InvisibleParts.ColosseumEntrance.InteractPrompt)
					startTime = tick()
				end
				wait(0.1)
			end
			for i = 1,15 do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(937.6810913085938, -217.88751220703125, 1686.1224365234375)
				task.wait()
			end
			local statValue = game:GetService("Players").LocalPlayer.PlayerGui.InventoryGui.MainBackpack.SearchBar.Weight.StatValue.Text

			-- Extract numbers using pattern matching
			local currentWeight, maxWeight = string.match(statValue, "(%d+)/(%d+)")

			-- Convert them to numbers
			currentWeight = tonumber(currentWeight)
			maxWeight = tonumber(maxWeight)
			local Found = false
			local SellItem = {
				["Intellect Rune"] = true,
				["Agility Rune"] = true,
				["Spirit Rune"] = true,
				["Stamina Rune"] = true,
				["Strength Rune"] = true,
				["Thick Leather"] = true,
				["Lesser Strength Rune"] = true,
				["Lesser Agility Rune"] = true,
				["Lesser Intellect Rune"] = true,
				["Lesser Spirit Rune"] = true,
				["Lesser Stamina Rune"] = true
			}


			if game.Players.LocalPlayer:FindFirstChild"Backpack" then
				for _, item in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if SellItem[item.Name] then
						Found = true
						break -- Stop searching once found
					end
				end
			end

			if (currentWeight >= maxWeight or currentWeight >= 200) and Found == true then
				print"Checking Weight"
				game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
				fireproximityprompt(workspace.InvisibleParts.ColosseumEntrance.InteractPrompt)

				local startTime = tick()
				while (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1025.1005859375, -197.8874969482422, 1363.8944091796875)).magnitude >= 10 do
					if tick() - startTime > 2 then
						if game.Players.LocalPlayer.Character:FindFirstChild("BoolValues") then
							if game.Players.LocalPlayer.Character.BoolValues:FindFirstChild"CombatTag" then
								if game.Players.LocalPlayer.Character.BoolValues.CombatTag.Value >= 1 then
									if game.Players.LocalPlayer.Character:FindFirstChild"Humanoid" and game.Players.LocalPlayer.Character:FindFirstChild"Humanoid".Health > 0 then
										repeat wait()
											game.Players.LocalPlayer.Character.Humanoid.Health = 0
										until game.Players.LocalPlayer.Character.Humanoid.Health == 0
										local Players = game:GetService("Players")

										local player = Players.LocalPlayer
										local gui = player:WaitForChild("PlayerGui"):WaitForChild("InfoOverlays", 5) -- Wait for InfoOverlays with a timeout

										if not gui then
											warn("InfoOverlays not found")
											return shop("16")
										end

										local confirmFrame = gui:WaitForChild("ConfirmFrame", 5)
										if not confirmFrame then
											warn("ConfirmFrame not found")
											return shop("17")
										end

										local mainFrame = confirmFrame:WaitForChild("MainFrame", 5)
										if not mainFrame then
											warn("MainFrame not found")
											return shop("18")
										end

										local buttonFrame = mainFrame:WaitForChild("ButtonFrame", 5)
										if not buttonFrame then
											warn("ButtonFrame not found")
											return shop("19")
										end

										local confirmButton = buttonFrame:WaitForChild("ConfirmButton", 5)
										if not confirmButton then
											warn("ConfirmButton not found")
											return shop("20")
										end

										repeat
											if confirmButton then
												local absPos = confirmButton.AbsolutePosition
												local absSize = confirmButton.AbsoluteSize

												-- Calculate the center of the button
												local clickPos = absPos + (absSize / 2)

												-- Simulate a left mouse click at the button's position
												--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
												wait(3)
											end
											task.wait()
										until not gui:FindFirstChild("ConfirmFrame")

										repeat wait() until game.Players.LocalPlayer.Character:IsDescendantOf(game.Workspace.Alive)
										wait(0.5)
										_G.Botting()
									end
								end
							end
						end
						fireproximityprompt(workspace.InvisibleParts.ColosseumEntrance.InteractPrompt)
						startTime = tick()
					end
					wait(0.1)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-386.4886779785156, 154.18463134765625, -955.7117309570312)
				game.Workspace.Camera.CFrame = CFrame.new(-375.058167, 161.526382, -955.592163, 0.00871383399, -0.464894921, 0.885323048, 0, 0.885356724, 0.464912534, -0.999962091, -0.00405117078, 0.00771485083)
				wait(1)
				print"Talk"
				wait(1)
				local player = game:GetService("Players").LocalPlayer
				local backpack = player.Backpack
				local sellEvent = player.Character.CharacterHandler.Input.Events.SellEvent
				local itemsToSell = {
					"Intellect Rune",
					"Agility Rune",
					"Spirit Rune",
					"Stamina Rune",
					"Strength Rune",
					"Thick Leather",
					"Lesser Strength Rune",
					"Lesser Agility Rune",
					"Lesser Intellect Rune",
					"Lesser Spirit Rune",
					"Lesser Stamina Rune"
				}
				for i = 1,12 do
					for _, itemName in ipairs(itemsToSell) do
						local item = backpack:FindFirstChild(itemName)
						if item then
							sellEvent:FireServer(item, nil, true)
						end
					end
					wait(.2)
				end
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.Name == "Drogar's Vest" or v.Name == "Edge Wing" then
						local Rs = v:GetAttribute("MaxSlots")
						if Rs == nil then
							Rs = 0
						end
						if v.Name == "Drogar's Vest" and tonumber(Rs) <= 5 then
							sellEvent:FireServer(v, nil, true)
							wait(.2)
						elseif v.Name == "Edge Wing" and tonumber(Rs) <= 2 then
							sellEvent:FireServer(v, nil, true)
							wait(.2)
						end
					end
				end
				wait(1)
				game:GetService("Players").LocalPlayer.Character.CharacterHandler.Input.Events.DialogueEvent:FireServer()
				wait(.2)
				game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
				fireproximityprompt(workspace.InvisibleParts.ColosseumEntrance.InteractPrompt)

				while (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1025.1005859375, -197.8874969482422, 1363.8944091796875)).magnitude >= 10 do
					if tick() - startTime > 2 then
						if game.Players.LocalPlayer.Character:FindFirstChild("BoolValues") then
							if game.Players.LocalPlayer.Character.BoolValues:FindFirstChild"CombatTag" then
								if game.Players.LocalPlayer.Character.BoolValues.CombatTag.Value >= 1 then
									if game.Players.LocalPlayer.Character:FindFirstChild"Humanoid" and game.Players.LocalPlayer.Character:FindFirstChild"Humanoid".Health > 0 then
										repeat wait()
											game.Players.LocalPlayer.Character.Humanoid.Health = 0
										until game.Players.LocalPlayer.Character.Humanoid.Health == 0
										local Players = game:GetService("Players")

										local player = Players.LocalPlayer
										local gui = player:WaitForChild("PlayerGui"):WaitForChild("InfoOverlays", 5) -- Wait for InfoOverlays with a timeout

										if not gui then
											warn("InfoOverlays not found")
											return shop("21")
										end

										local confirmFrame = gui:WaitForChild("ConfirmFrame", 5)
										if not confirmFrame then
											warn("ConfirmFrame not found")
											return shop("22")
										end

										local mainFrame = confirmFrame:WaitForChild("MainFrame", 5)
										if not mainFrame then
											warn("MainFrame not found")
											return shop("23")
										end

										local buttonFrame = mainFrame:WaitForChild("ButtonFrame", 5)
										if not buttonFrame then
											warn("ButtonFrame not found")
											return shop("24")
										end

										local confirmButton = buttonFrame:WaitForChild("ConfirmButton", 5)
										if not confirmButton then
											warn("ConfirmButton not found")
											return shop("25")
										end

										repeat
											if confirmButton then
												local absPos = confirmButton.AbsolutePosition
												local absSize = confirmButton.AbsoluteSize

												-- Calculate the center of the button
												local clickPos = absPos + (absSize / 2)

												-- Simulate a left mouse click at the button's position
												--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
												wait(3)
											end
											task.wait()
										until not gui:FindFirstChild("ConfirmFrame")

										repeat wait() until game.Players.LocalPlayer.Character:IsDescendantOf(game.Workspace.Alive)
										wait(0.5)
										_G.Botting()
									end
								end
							end
						end
						fireproximityprompt(workspace.InvisibleParts.ColosseumEntrance.InteractPrompt)
						startTime = tick()
					end
					wait(0.1)
				end
				for i = 1,15 do
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(937.6810913085938, -217.88751220703125, 1686.1224365234375)
					task.wait()
				end
			end
			--Start
			wait()
			print"Start"
			local start = false
			local starttime = tick()
			local Drogar = nil
			local Detected = false
			local waitdrogartick = tick()
			checkAndTeleport()
			print"Check teleport"
			repeat
				wait()
				local found = false
				for _, model in ipairs(game.Workspace.Alive:GetChildren()) do
					if model:IsA("Model") and model.Name:find("Drogar") then
						found = true
						break
					end
				end
			until not found
			print"No drogar"
			while Drogar == nil do
				for i,v in pairs(workspace.Alive:GetChildren()) do
					if v.Name:find"Drogar" then
						Drogar = v
					end
				end
				task.wait()
				if Drogar == nil then
					local Old = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                     local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                     local humanoid = character:WaitForChild("Humanoid")
                     local rootPart = character:WaitForChild("HumanoidRootPart")
                     
                     local targetPosition = rootPart.Position + Vector3.new(10, 0, 0)
                     
                     local finished = false
                     
                     -- Start a thread to listen for walk finished
                     
                     -- Wait up to 5 seconds
                     local timeout = 5
                     local elapsed = 0
                     while not finished and elapsed < timeout do
                         task.wait(0.1)
						 humanoid:MoveTo(targetPosition)
                         elapsed += 0.1
						 task.spawn(function()
                         humanoid.MoveToFinished:Wait()
                         finished = true
                     end)
                     end
                     
                     if finished then
                         print("Walk finished.")
                     else
                         print("Walk timeout reached.")
                     end
                     
                    print("Walk finished!")
					task.wait(.25)
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Old).magnitude < 50 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Old.X,Old.Y,Old.Z)
					end
					TPNormal(Vector3.new(937.6810913085938, -217.88751220703125, 1686.1224365234375))
					local maintain = tick()
					local found = false
					repeat
						local check = tick()
						local got = false
						print"talk"
						fireproximityprompt(workspace.Effects.NPCS.Drakonar.InteractPrompt)
						fireproximityprompt(workspace.Effects.NPCS.Drakonar.InteractPrompt)
						repeat wait() 
							if game.Players.LocalPlayer.PlayerGui.ChatGui.MainFrame.Visible == true then
								got = true
							end
						until got == true or tick()-check >= 0.5
						if got == true then
               				local args = {
               					[1] = "Challenge The Demon Claw, Drogar."
               				}
               
               				game:GetService("Players").LocalPlayer.Character.CharacterHandler.Input.Events.DialogueEvent:FireServer(unpack(args))
							wait(.5)
							game:GetService("Players").LocalPlayer.Character.CharacterHandler.Input.Events.DialogueEvent:FireServer()
							local double = tick()
							repeat wait() until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1022.8796, -239.4728, 1610.6086)).magnitude < 10 or tick()-double >= 5
						end
						for _, model in ipairs(game.Workspace.Alive:GetChildren()) do
							if model:IsA("Model") and model.Name:find("Drogar") then
								found = true
								break
							end
						end
						task.wait()
					until found or tick() - maintain >= 0.5

				end
				if tick() - waitdrogartick >= 30 then
					shop("26")
				end
			end
			game:GetService("Players").LocalPlayer.Character.CharacterHandler.Input.Events.DialogueEvent:FireServer()
			task.wait(.1)
			if not game.Players.LocalPlayer.Character:FindFirstChild("sword") then
				local rs = game:GetService("ReplicatedStorage")
				local plr = game:GetService("Players").LocalPlayer
				local netModule = require(rs.Modules.Network)

				local tradeData = {
					Config = "EquipWeapon",
				}

				netModule.connect("MasterEvent", "FireServer", plr.Character, tradeData)
			end
			if Drogar == nil then
				return shop("27")
			end
			if Drogar.Parent == nil then
				return shop("28")
			end
			Drogar:WaitForChild("HumanoidRootPart",10)
			if Drogar:FindFirstChild"HumanoidRootPart" then
				TP(Drogar.HumanoidRootPart.Position)
			else
				return shop("29")
			end
			local killtime = tick()
			_G.respawn = false
			_G.attack = true
			_G.teleport = true
			_G.checkplayer = true
			spawn(function()
				while _G.checkplayer == true do
					checkAndTeleport()
					wait()
					if _G.checkplayer == false then
						break
					end
				end
			end)
			spawn(function()
				while _G.attack == true do
					local rs = game:GetService("ReplicatedStorage")
					local plr = game:GetService("Players").LocalPlayer
					local netModule = require(rs.Modules.Network)
					local tradeData = {
						Config = "Button1Down",
					}

					netModule.connect("MasterEvent", "FireServer", plr.Character, tradeData)
					task.wait()
					local tradeData = {
						Config = "Button1Up",
					}

					netModule.connect("MasterEvent", "FireServer", plr.Character, tradeData)
					task.wait(.5)
					if _G.attack == false then
						break
					end
				end
			end)
			spawn(function()
				while _G.teleport == true do
					if Drogar then
						if game.Players.LocalPlayer.Character:FindFirstChild"HumanoidRootPart" and Drogar:FindFirstChild"HumanoidRootPart" and not Drogar:FindFirstChild"Grabbing" then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Drogar.HumanoidRootPart.CFrame*CFrame.new(0,-6,7)
						end
					else
						shop("Cant TP")
					end
					if _G.teleport == false then
						break
					end
					task.wait()
				end
			end)
			repeat 
				if Drogar and Drogar:FindFirstChild"Humanoid" and Drogar:FindFirstChild"HumanoidRootPart" then
					if Drogar.Humanoid.Health <= Drogar.Humanoid.MaxHealth*0.9 and isnetworkowner(Drogar.HumanoidRootPart) then
						for i = 1,10 do
							if Drogar.Parent ~= nil and Drogar:FindFirstChild"Humanoid" then
								Drogar.Humanoid.Health = 0
							end
						end
					end
				end
				if game.Players.LocalPlayer.PlayerGui.InfoOverlays:FindFirstChild"ConfirmFrame" then
					_G.respawn = true
				end
				task.wait()
			until Drogar.Parent == nil or tick() - killtime >= 30 or _G.respawn == true
			_G.attack = false
			_G.checkplayer = false
			_G.teleport = false
			if _G.respawn == true or game.Players.LocalPlayer.PlayerGui.InfoOverlays:FindFirstChild"ConfirmFrame" then
				game.Players.LocalPlayer.PlayerGui.InfoOverlays:WaitForChild"ConfirmFrame"
				game.Players.LocalPlayer.PlayerGui.InfoOverlays:WaitForChild"ConfirmFrame":WaitForChild"MainFrame"
				game.Players.LocalPlayer.PlayerGui.InfoOverlays:WaitForChild"ConfirmFrame":WaitForChild"MainFrame":WaitForChild"ButtonFrame"
				game.Players.LocalPlayer.PlayerGui.InfoOverlays:WaitForChild"ConfirmFrame":WaitForChild"MainFrame":WaitForChild"ButtonFrame":WaitForChild"ConfirmButton"
				wait()
				local player = game:GetService("Players").LocalPlayer
				repeat
					if player.PlayerGui.InfoOverlays:FindFirstChild("ConfirmFrame") then
						local button = player.PlayerGui.InfoOverlays.ConfirmFrame.MainFrame.ButtonFrame.ConfirmButton

						if button then
							local absPos = button.AbsolutePosition
							local absSize = button.AbsoluteSize

							local clickPos = absPos + (absSize / 2)

							--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
							wait(3)
						end
					end
					wait()
				until not player.PlayerGui.InfoOverlays:FindFirstChild("ConfirmFrame")
			else
				local timeoutwait = tick()
				repeat wait() until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1024.390380859375, -217.88751220703125, 1416.407958984375)).magnitude <= 15 or tick() - timeoutwait >= 6
			end
			_G.Botting()
		end
		spawn(function()
			local targetPosition = Vector3.new(1025.451416015625, -217.9293212890625, 1421.5732421875)
			local radius = 10

			function checkProximity()
				local player = game.Players.LocalPlayer
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local playerPosition = player.Character.HumanoidRootPart.Position
					local distance = (playerPosition - targetPosition).magnitude

					if distance <= radius then
						wait(6)
						local playerPosition = player.Character.HumanoidRootPart.Position
						local distance = (playerPosition - targetPosition).magnitude
						if distance <= radius then 
							if game.Players.LocalPlayer.Character:FindFirstChild"Humanoid" and game.Players.LocalPlayer.Character:FindFirstChild"Humanoid".Health > 0 then
								repeat wait()
									game.Players.LocalPlayer.Character.Humanoid.Health = 0
								until game.Players.LocalPlayer.Character.Humanoid.Health == 0
							end

							local Players = game:GetService("Players")

							local player = Players.LocalPlayer
							local gui = player:WaitForChild("PlayerGui"):WaitForChild("InfoOverlays", 5) -- Wait for InfoOverlays with a timeout

							if not gui then
								warn("InfoOverlays not found")
								return shop("35")
							end

							local confirmFrame = gui:WaitForChild("ConfirmFrame", 5)
							if not confirmFrame then
								warn("ConfirmFrame not found")
								return shop("36")
							end

							local mainFrame = confirmFrame:WaitForChild("MainFrame", 5)
							if not mainFrame then
								warn("MainFrame not found")
								return shop("37")
							end

							local buttonFrame = mainFrame:WaitForChild("ButtonFrame", 5)
							if not buttonFrame then
								warn("ButtonFrame not found")
								return shop("38")
							end

							local confirmButton = buttonFrame:WaitForChild("ConfirmButton", 5)
							if not confirmButton then
								warn("ConfirmButton not found")
								return shop("39")
							end

							repeat
								if confirmButton then
									local absPos = confirmButton.AbsolutePosition
									local absSize = confirmButton.AbsoluteSize

									-- Calculate the center of the button
									local clickPos = absPos + (absSize / 2)

									-- Simulate a left mouse click at the button's position
									--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
									wait(3)
								end
								task.wait()
							until not gui:FindFirstChild("ConfirmFrame")

							repeat wait() until game.Players.LocalPlayer.Character:IsDescendantOf(game.Workspace.Alive)
							game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart",15)
							_G.Botting()
						end
					end
				end
			end

			-- Run the check periodically
			while true do
				checkProximity()
				wait(1) -- Adjust the interval as needed
			end
		end)
		_G.Botting()
	elseif game.PlaceId == 10290054819 then
		repeat wait() until game.Players.LocalPlayer ~= nil
		game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Menu",15)
		local HttpService = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")

		-- Function to append content to a file
		local function appendfile(path, contents)
			writefile(path, (readfile(path) or "") .. contents .. "\n")
		end

		-- Function to load settings from a file
		local function LoadSettings(path)
			local str = readfile(path)
			return HttpService:JSONDecode(str)
		end

		-- Function to write settings to a file
		local function WriteSettings(path, settingsTable)
			writefile(path, HttpService:JSONEncode(settingsTable))
		end

		-- Generate filename based on the current date
		local dateStr = tostring(os.date("%Y-%m-%d"))
		local filename = dateStr .. ".lua"

		if isfile(filename) then
			local _table = LoadSettings(dateStr..".lua")
			if _table == nil or _table[1] == nil or #_table <= 5 then
				local PlaceId = 99995671928896  -- Use game's actual PlaceId
				local JobId = game.JobId  -- Use game's JobId

				if not PlaceId then
					warn("Error: PlaceId is nil!")
					return
				end

				local servers = {}
				local maxAttempts = 10
				local req = syn and syn.request or (http and http.request) or request

				if not req then
					warn("HTTP Request function not found.")
					return TeleportService:Teleport(10290054819, Players.LocalPlayer)
				end

				for attempt = 1, maxAttempts do
					--print("Attempting to fetch server list... Attempt " .. attempt)

					local response = req({
						Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId),
						Method = "GET"
					})

					if response and response.Body then
						local success, body = pcall(function()
							return HttpService:JSONDecode(response.Body)
						end)

						if success and body and body.data then
							for _, v in ipairs(body.data) do
								if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
									table.insert(servers, 1, v.id)
								end
							end
						end
					end

					if #servers > 0 then
						break
					end

					if attempt < maxAttempts then
						wait(5) -- Small delay before retrying
					end
				end

				if #servers > 0 then
					WriteSettings(filename, servers)
				else
					warn("No valid servers found.")
				end
			end
		end

		-- Check if file exists
		if not isfile(filename) then
			local PlaceId = 99995671928896  -- Use game's actual PlaceId
			local JobId = game.JobId  -- Use game's JobId

			if not PlaceId then
				warn("Error: PlaceId is nil!")
				return
			end

			local servers = {}
			local maxAttempts = 10
			local req = syn and syn.request or (http and http.request) or request

			if not req then
				warn("HTTP Request function not found.")
				return TeleportService:Teleport(10290054819, Players.LocalPlayer)
			end

			for attempt = 1, maxAttempts do
				--print("Attempting to fetch server list... Attempt " .. attempt)

				local response = req({
					Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId),
					Method = "GET"
				})

				if response and response.Body then
					local success, body = pcall(function()
						return HttpService:JSONDecode(response.Body)
					end)

					if success and body and body.data then
						for _, v in ipairs(body.data) do
							if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
								table.insert(servers, 1, v.id)
							end
						end
					end
				end

				if #servers > 0 then
					break
				end

				if attempt < maxAttempts then
					wait(5) -- Small delay before retrying
				end
			end

			if #servers > 0 then
				WriteSettings(filename, servers)
			else
				warn("No valid servers found.")
			end
		end
		local dateStr = tostring(os.date("%Y-%m-%d"))
		local filename = dateStr .. ".lua"
		local _table = LoadSettings(dateStr..".lua")
		if _table ~= nil and _table[1] ~= nil then
			while #_table > 0 do
				local B = math.random(1, #_table)
				local A = _table[B]
				game:GetService("TeleportService"):TeleportToPlaceInstance(99995671928896, tostring(A), game.Players.LocalPlayer)
				table.remove(_table, B)
				WriteSettings(filename, _table)
				for i = 1,10 do
					game.GuiService:ClearError()
					wait(.3)
				end
			end
		end
	end
end)