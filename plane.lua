inplane = false
beforespeed = 0
touching = false
target = game.Players.LocalPlayer
hat = game.Players.LocalPlayer.Character.PlaneModel
bhat = game.Players.LocalPlayer.Character.Back_AccAccessory
handle = Instance.new("Part")
handle.Parent = workspace
handle.Position = target.Character.Head.Position + Vector3.new(0, 5, 0)
handle.Anchored = true
handle.Transparency = 1

bhandle = Instance.new("Part")
bhandle.Parent = workspace
bhandle.Position = target.Character.Head.Position + Vector3.new(0, 3, 0)
bhandle.Anchored = true
bhandle.Transparency = 1
bhandle.Touched:Connect(function()
touching = true
end)
_G.loop = true
local player = game.Players.LocalPlayer
local char = player.Character
local Align = function(Part0, Part1,Mesh)
    local Aligns = {
        AlignOrientation = Instance.new("AlignOrientation", Part0),
        AlignPosition = Instance.new("AlignPosition", Part0)
    }
    
    local Attachments = {
        Attach0 = Instance.new("Attachment", Part0),
        Attach1 = Instance.new("Attachment", Part1)
    }
    local m = Part0:FindFirstChildOfClass('SpecialMesh')--This will get the first "SpecialMesh" it finds if it does not find any, then it will return nil
    if Mesh and m then --If Mesh is set to true and it finds a mesh it will destroy it
        m:Destroy()
    end
    Part0:BreakJoints()
    Aligns.AlignOrientation.Attachment0 = Attachments.Attach0
    Aligns.AlignOrientation.Attachment1 = Attachments.Attach1
    Aligns.AlignOrientation.Responsiveness = math.huge
    Aligns.AlignOrientation.RigidityEnabled = true
    
    Aligns.AlignPosition.Attachment0 = Attachments.Attach0
    Aligns.AlignPosition.Attachment1 = Attachments.Attach1
    Aligns.AlignPosition.Responsiveness = math.huge
    Aligns.AlignPosition.RigidityEnabled = true
        Aligns.AlignPosition.MaxForce = 999999999
        spawn(function()
            while _G.loop do 
                local mag = (Part0.Position - (Part1.CFrame*Attachments.Attach0.CFrame:Inverse()).p).magnitude--magnitude can get the distance between two cframe or position
                if mag >= 5 then 
                Part0.CFrame = Part1.CFrame*Attachments.Attach0.CFrame:Inverse()
                end
                Part0.Velocity = Vector3.new(0,35,0)
                game['Run Service'].Heartbeat:wait()
                end
        end)
 return {Attachments.Attach0, Attachments, Aligns}
        
end 
local hat = Align(hat.Handle,handle,false)
local cf = handle.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(0),0)
hat[1].CFrame = cf:Inverse() * handle.CFrame
local hat = Align(bhat.Handle,bhandle,false)
local cf = bhandle.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(90),-10.3)
hat[1].CFrame = cf:Inverse() * bhandle.CFrame
spawn(function()
    char.AncestryChanged:wait()--if you respawn, it will stop the  loop to avoid lag of using it over and over
    _G.loop = false 
end)
game:GetService("UserInputService").InputBegan:Connect(function(k)
if game:GetService("UserInputService"):GetFocusedTextBox() then

else
	if k.KeyCode == Enum.KeyCode.F then
		if inplane == false then
			game.Workspace.CurrentCamera.CameraSubject = handle
			game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
			inplane = true
			beforespeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
		else
			game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
			game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
			inplane = false
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = beforespeed
		end
	elseif k.KeyCode == Enum.KeyCode.R then
		if inplane == true then
			bhandle.Position = handle.CFrame * Vector3.new(0, 0, -3)
			bhandle.CFrame = CFrame.lookAt(bhandle.Position, game.Workspace.CurrentCamera.CFrame * Vector3.new(0, 0, -4))
			touching = false
			while touching == false do
				wait(0.1)
				bhandle.Position = bhandle.CFrame * Vector3.new(0, 0, -1)
			end
		end
	end
end
end)
while wait() do
	if inplane == true then
		handle.CFrame = CFrame.lookAt(handle.Position, game.Workspace.CurrentCamera.CFrame * Vector3.new(0, 0, -1))
		if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) == true then
			game:GetService("TweenService"):Create(handle, TweenInfo.new(1), {Position = handle.CFrame * Vector3.new(0, 0, -3)}):Play()
		elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) == true then
			game:GetService("TweenService"):Create(handle, TweenInfo.new(1), {Position = handle.CFrame * Vector3.new(-3, 0, 0)}):Play()
		elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) == true then
			game:GetService("TweenService"):Create(handle, TweenInfo.new(1), {Position = handle.CFrame * Vector3.new(0, 0, 3)}):Play()
		elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) == true then
			game:GetService("TweenService"):Create(handle, TweenInfo.new(1), {Position = handle.CFrame * Vector3.new(3, 0, 0)}):Play()
		elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Q) == true then
			game:GetService("TweenService"):Create(handle, TweenInfo.new(1), {Position = handle.CFrame * Vector3.new(0, -3, 0)}):Play()
		elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) == true then
			game:GetService("TweenService"):Create(handle, TweenInfo.new(1), {Position = handle.CFrame * Vector3.new(0, 3, 0)}):Play()
		end
		end
end
