local playergui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local ui = playergui:WaitForChild("DeathGui")
local tweenservice = game:GetService("TweenService")
local maintween = TweenInfo.new(0.5,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local camera = game.Workspace.CurrentCamera
local PlayerModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()
local player = game.Players.LocalPlayer
local mousetweeninfo = TweenInfo.new(0.2,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local disablegui = tweenservice:Create(ui, maintween, {Enabled = false})
local disableblur = tweenservice:Create(game.Lighting.Blur, maintween, {Size = 0})
local players = game.Players:GetPlayers()
local index = 1
local playertospecate = players[index]
local max = #players
game.ReplicatedStorage.DiedEvent.OnClientEvent:Connect(function(plr)
	print("died")
	local enableuitween = tweenservice:Create(ui, maintween, {Enabled = true})
	local enableblur = tweenservice:Create(game.Lighting.Blur, maintween, {Size = 25})
	enableuitween:Play()
	enableblur:Play()
	Controls:Disable()
	camera.CameraType = Enum.CameraType.Scriptable
	local pos = Vector3.new(0.969, 77.687, 43.44)
	local lookat = Vector3.new(0,0,0)
	camera.CFrame = CFrame.new(pos,lookat)
	game.Players.LocalPlayer.RespawnLocation = game.Workspace.DeathSpawnLocation
end)
ui.RespawnBtn.MouseButton1Click:Connect(function(plr)
	print("pressed it")
	disablegui:Play()
	disableblur:Play()
	playergui:WaitForChild("SpectatingGui").Enabled = false
	game.Players.LocalPlayer.RespawnLocation = game.Workspace.MainSpawnLocation
	camera.CameraSubject = player.Character.Humanoid
	camera.CameraType = Enum.CameraType.Follow
	Controls:Enable()
end)
ui.SpectateBtn.MouseButton1Click:Connect(function(plr)
	disableblur:Play()
	disablegui:Play()
	playergui:WaitForChild("SpectatingGui").Enabled = true
	playergui:WaitForChild("SpectatingGui").BackToDeathScreenBtn.MouseButton1Click:Connect(function(plr)
		local enableuitween = tweenservice:Create(ui, maintween, {Enabled = true})
		local enableblur = tweenservice:Create(game.Lighting.Blur, maintween, {Size = 25})
		playergui:WaitForChild("SpectatingGui").Enabled = false
		enableblur:Play()
		enableuitween:Play()
		Controls:Disable()
		camera.CameraType = Enum.CameraType.Scriptable
		local pos = Vector3.new(0.969, 77.687, 43.44)
		local lookat = Vector3.new(0,0,0)
		camera.CFrame = CFrame.new(pos,lookat)
	end)
	playergui:WaitForChild("SpectatingGui").NextBtn.MouseButton1Click:Connect(function(plr) 
		print(playertospecate)
		playertospecate = players[index]
		if playertospecate == player then
			index +=  1
			playertospecate = players[index]
			camera.CameraType = Enum.CameraType.Follow
			camera.CameraSubject = playertospecate.Character:WaitForChild("Humanoid")

			if index > #players then
				index = 1

			end
		else
			
			camera.CameraType = Enum.CameraType.Follow
			camera.CameraSubject = playertospecate.Character:WaitForChild("Humanoid")
			index +=  1
			if index > #players then
				index = 1

			end
		end
	end)
	playergui:WaitForChild("SpectatingGui").BackBtn.MouseButton1Click:Connect(function(plr)
		playertospecate = players[index]
		if playertospecate == player then
			index += 1
			playertospecate = players[index]
			camera.CameraType = Enum.CameraType.Follow
			camera.CameraSubject = playertospecate.Character:WaitForChild("Humanoid")


			if index < 1 then
				index = 1

			end

			camera.CameraType = Enum.CameraType.Follow
			camera.CameraSubject = playertospecate.Character:WaitForChild("Humanoid")
		else 
			camera.CameraType = Enum.CameraType.Follow
			camera.CameraSubject = playertospecate.Character:WaitForChild("Humanoid")
			index -= 1

			if index < 1 then
				index = 1

			end

			camera.CameraType = Enum.CameraType.Follow
			camera.CameraSubject = playertospecate.Character:WaitForChild("Humanoid")
		end

		
	end)

end)
ui.RespawnBtn.MouseEnter:Connect(function(x, y)
	local mouseentertween = tweenservice:Create(ui.RespawnBtn, mousetweeninfo, {Size = UDim2.new(0.190,0,0.140,0)})
	mouseentertween:Play()
end)
ui.RespawnBtn.MouseLeave:Connect(function(x, y)
	local mouseleavetween = tweenservice:Create(ui.RespawnBtn, mousetweeninfo, {Size = UDim2.new(0.182,0,0.113,0)})
	mouseleavetween:Play()
end)
ui.SpectateBtn.MouseEnter:Connect(function(x, y)
	local mouseentertween = tweenservice:Create(ui.SpectateBtn, mousetweeninfo, {Size = UDim2.new(0.190,0,0.140,0)})
	mouseentertween:Play()
end)
ui.SpectateBtn.MouseLeave:Connect(function(x, y)
	local mouseleavetween = tweenservice:Create(ui.SpectateBtn, mousetweeninfo, {Size = UDim2.new(0.182,0,0.113,0)})
	mouseleavetween:Play()
end)
