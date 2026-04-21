local player = game.Players.LocalPlayer

-- Function to equip a specific tool by name
local function equipToolByName(toolName)
    local character = player.Character
    if character then
        local tool = player.Backpack:FindFirstChild(toolName) or character:FindFirstChild(toolName)
        if tool then
            -- Move the tool to character if it's in the backpack
            if tool.Parent ~= character then
                tool.Parent = character
            end
            -- Equip the tool
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(tool)
            end
        end
    end
end

-- Function to spawn the platform
local function spawnPlatform()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Remove existing platform if it exists
        local oldPlatform = workspace:FindFirstChild("epikplatform")
        if oldPlatform then
            oldPlatform:Destroy()
        end

        -- Create new platform
        local plat = Instance.new("Part")
        plat.Name = "epikplatform"
        plat.Size = Vector3.new(200, 1, 200)
        plat.Anchored = true
        plat.BrickColor = BrickColor.new("Bright yellow")
        plat.Parent = workspace

        -- Position it above the player
        local newPosition = hrp.CFrame.Position + Vector3.new(0, 6, 0)
        plat.Position = newPosition

        -- Teleport the player onto the platform
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(newPosition + Vector3.new(0, 2, 0))
        end
    end
end

-- Function to handle character spawn: spawn platform and equip "Atomic"
local function onCharacterAdded(character)
    wait(0.5)
    spawnPlatform()
    equipToolByName("The World")
end

-- Connect respawn event
player.CharacterAdded:Connect(onCharacterAdded)

-- Initial setup if character exists
if player.Character then
    onCharacterAdded(player.Character)
end

-- Keep track of current weapon
local currentWeapon = "The World"

-- Function to swap between "Atomic" and "Corrupted Excalibur"
local function swapWeapon()
    if currentWeapon == "The World" then
        currentWeapon = "The World"
    else
        currentWeapon = "The World"
    end
    equipToolByName(currentWeapon)
end

-- Automatic swapping every few seconds
spawn(function()
    while true do
        swapWeapon()
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.P,false,game)
		game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.P,false,game)
        wait(3) -- change this value to control how often it swaps
    end
end)
