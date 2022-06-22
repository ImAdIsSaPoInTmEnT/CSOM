-- Script GUID: {C12DE703-65C7-4C7A-BD5A-2E81466CEAF6}
-- Decompiled with the Synapse X Luau decompiler.

holdAnimTrack = nil;
lowered = false;
local u1 = { "rbxassetid://2085074428", "rbxassetid://2055028123" };
local u2 = 1;
local u3 = { "rbxassetid://2055105211", "rbxassetid://5763254152" };
local u4 = 1;
function onCycleHold()
	if not lowered then
		if 1 < #u1 then
			u2 = u2 % #u1 + 1;
			onLower();
			wait();
			onLower();
			return;
		end;
	end;
	if 1 < #u3 then
		u4 = u4 % #u3 + 1;
		onLower();
		wait();
		onLower();
	end;
end;
local l__ToggleSuppressorEvent__5 = script.Parent:WaitForChild("ToggleSuppressorEvent");
function onToggleSuppressor()
	l__ToggleSuppressorEvent__5:FireServer();
end;
local l__Parent__6 = script.Parent;
function onLower()
	local v1 = l__Parent__6.Parent:FindFirstChildWhichIsA("Humanoid");
	local v2 = Instance.new("Animation");
	if lowered then
		v2.AnimationId = u1[u2];
		lowered = false;
	else
		v2.AnimationId = u3[u4];
		lowered = true;
	end;
	holdAnimTrack:Stop();
	holdAnimTrack = v1:LoadAnimation(v2);
	holdAnimTrack:Play();
	holdAnimTrack:AdjustSpeed(0);
end;
local l__ContextActionService__7 = game:GetService("ContextActionService");
function onEquipped()
	local v3 = Instance.new("Animation");
	v3.AnimationId = u1[u2];
	holdAnimTrack = l__Parent__6.Parent:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(v3);
	holdAnimTrack:Play();
	holdAnimTrack:AdjustSpeed(0);
	l__ContextActionService__7:BindAction("lowerPistol", function(p1, p2, p3)
		if p2 == Enum.UserInputState.Begin then
			onLower();
		end;
	end, true, Enum.KeyCode.Q);
	l__ContextActionService__7:SetPosition("lowerPistol", UDim2.new(0.4, 0, 0, 0));
	l__ContextActionService__7:BindAction("cycleHoldAnim", function(p4, p5, p6)
		if p5 == Enum.UserInputState.Begin then
			onCycleHold();
		end;
	end, true, Enum.KeyCode.T);
	l__ContextActionService__7:BindAction("toggleSuppressor", function(p7, p8, p9)
		if p8 == Enum.UserInputState.Begin then
			onToggleSuppressor();
		end;
	end, true, Enum.KeyCode.E);
end;
function onUnequipped()
	lowered = false;
	l__ContextActionService__7:UnbindAction("lowerPistol");
	l__ContextActionService__7:UnbindAction("cycleHoldAnim");
	l__ContextActionService__7:UnbindAction("toggleSuppressor");
	holdAnimTrack:Stop();
	holdAnimTrack = nil;
end;
local u8 = false;
local l__ShootEvent__9 = script.Parent:WaitForChild("ShootEvent");
script.Parent.Equipped:connect(onEquipped);
script.Parent.Unequipped:connect(onUnequipped);
