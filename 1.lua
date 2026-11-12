
local r0_0, r0_1, r0_2
_G = _G or {}
_G._LICENSE_OK = false
_G._MOD_EXPIRED = false
_G._LICENSE_SHOWN = false
_G._LICENSE_KEY = nil
_G._LICENSE_UID = nil
local r0_3, r0_4 = _G, _G.BanConfig
r0_4 = not r0_4
    and {
        FlyMode = false, NoFallDamage = false, SpinMode = false, RemoveFogGlobal = false,
        RemoveGrassGlobal = false
    }
    or r0_4
r0_3.BanConfig = r0_4
local r0_5 = {}
r0_5.ServerRPC = {}
r0_5.ClientRPC = {}
r0_5.MulticastRPC = {}
r0_4 = r0_5.ServerRPC
local r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.ServerRPC_NearDeathGiveupRescue = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
local r0_7 = {}
-- [unluac error] HIR proto#0 still contains residual table-set-list during AST lowering
r0_6.Params = r0_7
r0_4.ServerRPC_CarryDeadBox = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_7 = {}
-- [unluac error] HIR proto#0 still contains residual table-set-list during AST lowering
r0_6.Params = r0_7
r0_4.RPC_Server_GmPlayAction = r0_6
r0_4 = r0_5.MulticastRPC
r0_6 = { Reliable = true }
r0_7 = {}
-- [unluac error] HIR proto#0 still contains residual table-set-list during AST lowering
r0_6.Params = r0_7
r0_4.MulticastRPC_GmPlayAction = r0_6
r0_4 = r0_5.ClientRPC
r0_6 = { Reliable = true }
r0_7 = {}
-- [unluac error] HIR proto#0 still contains residual table-set-list during AST lowering
r0_6.Params = r0_7
r0_4.RPC_Client_SetShouldCheckPassWall = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Server_ReportSimulateCharacterLocation = r0_6
r0_4 = r0_5.ClientRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Client_ShootVertifyRes = r0_6
r0_4 = r0_5.ClientRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_ClientCoronaLab = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Server_ReportPlayerKillFlow = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Server_ClientSecMrpcsFlow = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Server_Heartbeat = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Server_SwiftHawk = r0_6
r0_4 = r0_5.ServerRPC
r0_6 = { Reliable = true }
r0_6.Params = {}
r0_4.RPC_Server_ClientSwiftHawkWithParams = r0_6
r0_4 = import("ENetRole")
r0_6 = import("EPawnState")
r0_7 = require("GameLua.GameCore.Data.GameplayData")
local r0_8 = require("GameLua.Mod.BaseMod.Common.GamePlayTools")

-- line 70-71
-- proto#1 params=1 locals=0 upvalues=0 vararg=false
r0_5.ctor = function(p1_0)

end

-- line 73-77
-- proto#2 params=1 locals=1 upvalues=1 vararg=false
function r0_5._PostConstruct(p2_0)
    r0_5.__super._PostConstruct(p2_0)
    p2_0:InitAddSpecialMoveInfo()
    p2_0.bCanNearDeathGiveup = true
end

-- line 79-107
-- proto#3 params=1 locals=13 upvalues=4 vararg=false
function r0_5.ReceiveBeginPlay(p3_0)
    r0_5.__super.ReceiveBeginPlay(p3_0)
    p3_0:AddControlEvent(p3_0, "MovementModeChangedDelegate", p3_0.HandleOnMovementModeChangedNew, p3_0)
    if p3_0:HasAuthority() and p3_0:CheckAddCheckFallingDistanceComponent() then
        local r3_0 = import("CheckFallingDistanceComponent")
        if slua.isValid(r3_0) then
            local r3_1, r3_2 = slua.isValid, p3_0
            local r3_3 = r3_1(r3_2.GetComponentByClass(r3_2, r3_0))
            if not r3_3 then
                local r3_4 = Game
                r3_4:AddComponent(r3_0, p3_0, "CheckFallingDistanceComponent")
            end
        end
    end
    if slua.isValid(p3_0.STCharacterMovement) then
        p3_0.STCharacterMovement.bPositiveBlowUp = true
    end
    if p3_0.Role == r0_4.ROLE_AutonomousProxy then
        p3_0:AddControlEvent(p3_0, "OnPawnStateDisabled", p3_0.OnPawnStateChange, p3_0)
        p3_0:AddControlEvent(p3_0, "OnPawnStateEnabled", p3_0.OnPawnStateChange, p3_0)
        local r3_5 = p3_0
        local r3_6 = r3_5.AddControlEventConditionOnly
        local r3_7 = p3_0
        local r3_8 = {}
        local r3_9 = { "bCanSelfRescue" }
        r3_8.AttrName = r3_9
        r3_6(r3_5, r3_7, "OnAttrChangeEventDelegate", r3_8, p3_0.CharacterAttrChangeEvent, p3_0)
    end
    if Client then
        r0_7.AddCharacter(p3_0.Object)
        p3_0:AddControlEvent(p3_0, "OnAttachedToVehicle", p3_0.HandleOnAttachedToVehicle, p3_0)
        p3_0:AddControlEvent(p3_0, "OnDetachedFromVehicle", p3_0.HandleOnDetachedFromVehicle, p3_0)
    else
        p3_0:AddCommonEventWithConditions(EVENTTYPE_INGAME_NORMAL, EVENTID_GAME_MODE_STATE_CHANGE, {
            "FinishedState"
        }, p3_0.HandleFinishedState, p3_0)
    end
end

-- line 109-125
-- proto#4 params=2 locals=3 upvalues=2 vararg=false
r0_5.HandleOnAttachedToVehicle = function(p4_0, p4_1)
    if not slua.isValid(p4_1) then
        return
    end
    if p4_0.Role == r0_4.ROLE_SimulatedProxy then
        p4_0:ClearAttachToVehicleTimer()
        p4_0.nUpdatePlayerAttachToVehicleCount = 0
        local r4_0 = p4_0:AddGameTimer(5, true, function()
            if slua.isValid(p4_0.Object) and slua.isValid(p4_1) then
                p4_0:UpdatePlayerAttachToVehicle(p4_1)
            end
        end)
        p4_0.nUpdatePlayerAttachToVehicleTimer = r4_0
        local r4_1 = p4_0
        r4_0 = r4_1.AddGameTimer
        local r4_2 = r4_0(r4_1, 3, true, function()
            if slua.isValid(p4_0.Object) and slua.isValid(p4_1) then
                p4_0:FixMeshContainerOffsetIfNeeded(p4_1)
            end
        end)
        p4_0.nFixMeshContainerTimer = r4_2
    end
end

-- line 127-133
-- proto#7 params=2 locals=0 upvalues=2 vararg=false
r0_5.HandleOnDetachedFromVehicle = function(p7_0, p7_1)
    if not slua.isValid(p7_1) then
        return
    end
    if p7_0.Role == r0_4.ROLE_SimulatedProxy then
        p7_0:ClearAttachToVehicleTimer()
        p7_0.nUpdatePlayerAttachToVehicleCount = 0
    end
end

-- line 135-174
-- proto#8 params=2 locals=32 upvalues=1 vararg=false
function r0_5:UpdatePlayerAttachToVehicle(p8_1)
    if not (slua.isValid(self.Object) and slua.isValid(p8_1)) then
        return
    end
    if not (slua.isValid(self.CapsuleComponent)
        and slua.isValid(self.Mesh)
        and slua.isValid(self.MeshContainer)) then
        return
    end
    local r8_0, r8_1 = slua.isValid, self
    if not r8_0(r8_1.GetCurrentVehicle(r8_1)) then
        return
    end
    if Game:IsDriver(self.Object) then
        return
    end
    if not self.nUpdatePlayerAttachToVehicleCount then
        self.nUpdatePlayerAttachToVehicleCount = 0
    end
    local r8_2 = import("ESTEPoseState")
    local r8_3 = self.PoseState == r8_2.Stand
    local r8_4 = self.CapsuleComponent:GetRelativeTransform():GetLocation()
    local r8_5 = self.Mesh:GetRelativeTransform():GetLocation()
    local r8_6 = self.MeshContainer:GetRelativeTransform():GetLocation()
    r8_6 = r8_6.Z
    local r8_7 = self.CapsuleComponent:GetScaledCapsuleRadius()
    local r8_8 = self.CapsuleComponent:GetScaledCapsuleHalfHeight()
    local r8_9 = -1 * self.StandHalfHeight
    local r8_10 = self.StandRadius
    local r8_11 = self.StandHalfHeight
    local r8_12 = FVector(0, 0, 0)
    local r8_13 = FVector(0, 0, self.StandHalfHeight)
    local r8_14 = 1.0
    local r8_15 = r8_4:Equals(r8_13, r8_14)
    local r8_16 = r8_5:Equals(r8_12, r8_14)
    local r8_17 = math.abs(r8_6 - r8_9) < r8_14
    local r8_18 = math.abs(r8_7 - r8_10) < r8_14
    local r8_19 = math.abs(r8_8 - r8_11) < r8_14
    local r8_20 = r8_3 and r8_15 and r8_16 and r8_17 and r8_18 and r8_19
    if r8_20 then
        self.nUpdatePlayerAttachToVehicleCount = 0
    else
        self.nUpdatePlayerAttachToVehicleCount = self.nUpdatePlayerAttachToVehicleCount + 1
    end
    if self.nUpdatePlayerAttachToVehicleCount >= 3 and not r8_20 then
        local r8_21 = require("GameLua.GameCore.Data.GameplayData").GetPlayerController()
        if r8_21
            and r8_21.ReportCrashKitFeature
            and r8_21.ReportCrashKitFeature.ReportCharacterAttachedOnVehicleException then
            local r8_22 = string.format
            local r8_23 = tostring(p8_1.VehicleShapeType)
            local r8_24 = r8_22("VehicleShapeType:%s PlayerKey:%s", r8_23, tostring(self.PlayerKey))
            r8_23 = r8_21.ReportCrashKitFeature
            r8_23:ReportCharacterAttachedOnVehicleException(r8_24)
        end
        self.nUpdatePlayerAttachToVehicleCount = 0
    end
end

-- line 176-187
-- proto#9 params=2 locals=5 upvalues=1 vararg=false
function r0_5:FixMeshContainerOffsetIfNeeded(p9_1)
    if not (slua.isValid(self.Object) and slua.isValid(p9_1)) then
        return
    end
    if not slua.isValid(self.MeshContainer) then
        return
    end
    local r9_0, r9_1 = slua.isValid, self
    if not r9_0(r9_1.GetCurrentVehicle(r9_1)) then
        return
    end
    if Game:IsDriver(self.Object) then
        return
    end
    local r9_2 = -1 * self.StandHalfHeight
    local r9_3 = self.MeshContainer:GetRelativeTransform():GetLocation()
    r9_3 = r9_3.Z
    if math.abs(r9_3 - r9_2) >= 1.0 then
        self:SetMeshContainerOffsetZ(r9_2)
    end
end

-- line 189-198
-- proto#10 params=1 locals=0 upvalues=0 vararg=false
function r0_5:ClearAttachToVehicleTimer()
    if self.nUpdatePlayerAttachToVehicleTimer then
        self:RemoveGameTimer(self.nUpdatePlayerAttachToVehicleTimer)
        self.nUpdatePlayerAttachToVehicleTimer = nil
    end
    if self.nFixMeshContainerTimer then
        self:RemoveGameTimer(self.nFixMeshContainerTimer)
        self.nFixMeshContainerTimer = nil
    end
end

-- line 200-209
-- proto#11 params=4 locals=2 upvalues=3 vararg=false
function r0_5.CharacterAttrChangeEvent(p11_0, p11_1, p11_2, p11_3)
    r0_5.__super.CharacterAttrChangeEvent(p11_0, p11_1, p11_2, p11_3)
    if p11_0.Object ~= p11_1 then
        return
    end
    if p11_0.Role == r0_4.ROLE_AutonomousProxy and p11_2 == "bCanSelfRescue" then
        local r11_0 = p11_0:GetPlayerControllerSafety()
        if slua.isValid(r11_0) then
            r11_0:BroadcastUIMessage("UIMsg_CanSelfRescue", 0, "", "")
        end
    end
end

-- line 211-219
-- proto#12 params=2 locals=1 upvalues=1 vararg=false
r0_5.OnPawnStateChange = function(p12_0, p12_1)
    if p12_1 == import("EPawnState").SwitchPP then
        local r12_0 = p12_0:GetPlayerControllerSafety()
        if slua.isValid(r12_0) then
            r12_0:BroadcastUIMessage("UIMsg_FPPModeChange", 0, "", "")
        end
    end
end

-- line 221-225
-- proto#13 params=1 locals=0 upvalues=1 vararg=false
r0_5.HandleFinishedState = function(p13_0)
    if slua.isValid(p13_0.STCharacterMovement)
        and p13_0.STCharacterMovement.SetDynamicSimpleQueryConfig then
        p13_0.STCharacterMovement:SetDynamicSimpleQueryConfig(false)
    end
end

-- line 227-238
-- proto#14 params=1 locals=8 upvalues=1 vararg=false
function r0_5:CheckAddCheckFallingDistanceComponent()
    if CGameMode and CGameMode.GameModeType and CGameState and CGameState.GameModeID then
        local r14_0 = import("EGameModeType")
        local r14_1 = require("GameLua.Mod.BaseMod.GamePlay.Config.MatchModeIdsConfig")
        local r14_2 = CGameMode.GameModeType
        local r14_3 = tonumber(CGameState.GameModeID)
        local r14_4 = r14_2 == r14_0.ETypicalGameMode
            or r14_2 == r14_0.EFourInOneGameMode
            or r14_2 == r14_0.EHeavyWeaponGameMode
        local r14_5 = r14_1[r14_3]
        local r14_6 = not r14_5
        return r14_4 and r14_6
    end
    return false
end

-- line 245-265
-- proto#15 params=3 locals=3 upvalues=2 vararg=false
function r0_5.LuaHandleParachuteStateChanged(p15_0, p15_1, p15_2)
    r0_5.__super.LuaHandleParachuteStateChanged(p15_0, p15_1, p15_2)
    local r15_0 = import("EParachuteState")
    if not Client then
        local r15_1 = p15_0:GetPlayerControllerSafety()
        if slua.isValid(r15_1) and r15_1.CheckParachuteOpenFeature then
            if p15_2 == r15_0.PS_Opening then
                if r15_1.CheckParachuteOpenFeature.SatrtCheckShowParachuteCloseUI then
                    r15_1.CheckParachuteOpenFeature:SatrtCheckShowParachuteCloseUI()
                end
            elseif p15_2 == r15_0.PS_None then
                if r15_1.CheckParachuteOpenFeature.RecoverParachuteOpenParam then
                    r15_1.CheckParachuteOpenFeature:RecoverParachuteOpenParam()
                end
                if r15_1.CheckParachuteOpenFeature.ClearTimerAndState then
                    r15_1.CheckParachuteOpenFeature:ClearTimerAndState()
                end
            end
        end
    end
end

-- line 267-280
-- proto#16 params=1 locals=1 upvalues=1 vararg=false
r0_5.OnLanded = function(p16_0)
    if p16_0.HandleOnLanded then
        p16_0:HandleOnLanded(-1)
    end
    if not Client then
        local r16_0 = p16_0:GetPlayerControllerSafety()
        if slua.isValid(r16_0) and r16_0.CheckParachuteOpenFeature then
            if r16_0.CheckParachuteOpenFeature.ClearTimerAndState then
                r16_0.CheckParachuteOpenFeature:ClearTimerAndState()
            end
            if r16_0.CheckParachuteOpenFeature.ResetCheckShowUI then
                r16_0.CheckParachuteOpenFeature:ResetCheckShowUI()
            end
        end
    end
end

-- line 282-285
-- proto#17 params=2 locals=1 upvalues=3 vararg=false
function r0_5.ReceiveEndPlay(p17_0, p17_1)
    r0_5.__super.ReceiveEndPlay(p17_0, p17_1)
    if Client then
        r0_7.RemoveCharacter(p17_0.Object)
    end
end

-- line 287-297
-- proto#18 params=1 locals=4 upvalues=1 vararg=false
r0_5.IsWarGameMode = function(p18_0)
    local r18_0 = require("GameLua.GameCore.Data.GameplayData"):GetGameState()
    local r18_1 = import("STExtraGameStateBase")
    if slua.isValid(r18_0) and Game:IsClassOf(r18_0, r18_1) then
        local r18_2 = import("EGameModeType")
        return r18_0.GameModeType == r18_2.EWarGameMode
    end
    return false
end

-- line 299-301
-- proto#19 params=1 locals=0 upvalues=1 vararg=false
r0_5.BPOnRecycled = function(p19_0)
    if Client then
        p19_0:ResetMeshRelativeLocationAndRotation()
    end
end

-- line 303-305
-- proto#20 params=1 locals=0 upvalues=1 vararg=false
r0_5.BPOnRespawned = function(p20_0)
    if Client then
        p20_0:ResetMeshRelativeLocationAndRotation()
    end
end

-- line 307-312
-- proto#21 params=1 locals=0 upvalues=2 vararg=false
r0_5.ReceiveOnRecycle = function(p21_0)
    if Client then
        p21_0:ResetMeshRelativeLocationAndRotation()
        r0_7.RemoveCharacter(p21_0.Object)
    end
end

-- line 314-319
-- proto#22 params=1 locals=0 upvalues=2 vararg=false
r0_5.ReceiveOnSpawn = function(p22_0)
    if Client then
        p22_0:ResetMeshRelativeLocationAndRotation()
        r0_7.AddCharacter(p22_0.Object)
    end
end

-- line 321-330
-- proto#23 params=1 locals=4 upvalues=1 vararg=false
function r0_5:ResetMeshRelativeLocationAndRotation()
    if Game:IsValid(self.Object) and Game:IsValid(self.Mesh) then
        local r23_0 = FRotator(0, -90, 0)
        local r23_1 = FVector(0, 0, 0)
        if self.Mesh.K2_SetRelativeRotation then
            self.Mesh:K2_SetRelativeRotation(r23_0, false, nil, false)
        end
        self:CacheInitialMeshOffset(r23_1, r23_0)
    end
end

-- line 332-340
-- proto#24 params=1 locals=2 upvalues=2 vararg=false
r0_5.HandleOnMovementModeChangedNew = function(p24_0)
    local r24_0 = import("EMovementMode")
    if Game:IsValid(p24_0.STCharacterMovement)
        and p24_0.STCharacterMovement.MovementMode == r24_0.MOVE_Swimming
        and p24_0:CheckBaseIsMoveable() then
        p24_0.CharacterMovement:SetBase(nil, "", true)
    end
    if p24_0.Role == r0_4.ROLE_AutonomousProxy
        and Game:IsValid(p24_0.STCharacterMovement)
        and p24_0.STCharacterMovement.MovementMode == r24_0.MOVE_Walking
        and UIManager
        and UIManager.UI_Config_InGame
        and UIManager.UI_Config_InGame.ParachuteOpenUI then
        UIManager.CloseUI(UIManager.UI_Config_InGame.ParachuteOpenUI)
    end
end

-- line 342-343
-- proto#25 params=1 locals=0 upvalues=0 vararg=false
r0_5.BPOnMissPlayerDamageRecord = function(p25_0)

end

-- line 345-365
-- proto#26 params=1 locals=5 upvalues=1 vararg=false
r0_5.PreAttachedToVehicle = function(p26_0)
    local r26_0 = import("KismetSystemLibrary")
    if not r26_0.IsDedicatedServer(p26_0) then
        return
    end
    local r26_1 = p26_0:GetPlayerControllerSafety()
    if not slua.isValid(r26_1) then
        return
    end
    local r26_2 = p26_0.CharacterAvatarComp2_BP
    if not slua.isValid(r26_2) then
        return
    end
    local r26_3 = require("GameLua.Activity.Commercialize.GamePlay.CommerAvatarDataUtil"):ChangeVehicleSkinByClothes(r26_1, r26_2)
    local r26_4 = import("ESTExtraVehicleShapeType")
    if r26_3 and import("AvatarUtils").GetVehicleShapeBySkinID(r26_3) == r26_4.VST_Horse then
        local r26_5 = p26_0:GetPlayerStateSafety()
        if slua.isValid(r26_5) then
            r26_5:AddGeneralCount(468, 1, false)
        end
    end
end

local r0_9 = r0_5.ClientRPC
local r0_10 = { Reliable = true }
local r0_11 = {}
-- [unluac error] HIR proto#0 still contains residual table-set-list during AST lowering
r0_10.Params = r0_11
r0_9.ClientRPC_TriggerHighlightMoment = r0_10

-- line 372-374
-- proto#27 params=3 locals=1 upvalues=1 vararg=false
r0_5.ClientRPC_TriggerHighlightMoment = function(p27_0, p27_1, p27_2)
    local r27_0 = EventSystem
    r27_0:postEvent(EVENTTYPE_INGAME, EVENTID_INGAME_TRIGGER_HIGHLIGHT_MOMENT, p27_1, p27_2)
end

-- line 376-391
-- proto#28 params=1 locals=6 upvalues=1 vararg=false
r0_5.ParachuteJump = function(p28_0)
    local r28_0 = p28_0:GetControllerSafety()
    if slua.isValid(r28_0) then
        if p28_0:GetEnsure() then
            local r28_1 = EventSystem
            r28_1:postEvent(EVENTTYPE_INGAME_NORMAL, EVENTID_AI_CALL_PARACHUTE_JUMP, p28_0.Object)
        else
            local r28_2 = import("EStateType")
            if r28_0:GetCurrentStateType() ~= r28_2.State_ParachuteJump
                and r28_0:GetCurrentStateType() ~= r28_2.State_ParachuteOpen then
                local r28_3 = import("ESTEPoseState")
                p28_0:SwitchPoseState(r28_3.Stand, true, true, true, false)
                r28_0:ReInitParachuteItem()
                r28_0:ServerChangeStatePC(r28_2.State_ParachuteJump)
            end
        end
    end
end

-- line 393-404
-- proto#29 params=4 locals=2 upvalues=0 vararg=false
r0_5.OnMovementBaseChangedEvent = function(p29_0, p29_1, p29_2, p29_3)
    if p29_1 ~= p29_0.Object then
        return
    end
    local r29_0 = p29_0:GetMedievalCraneFromBase(p29_2)
    if r29_0 and r29_0.AddCharacter then
        r29_0:AddCharacter(p29_0.Object)
    else
        local r29_1 = p29_0:GetMedievalCraneFromBase(p29_3)
        if r29_1 and r29_1.RemoveCharacter then
            r29_1:RemoveCharacter(p29_0.Object)
        end
    end
end

-- line 406-412
-- proto#30 params=2 locals=1 upvalues=1 vararg=false
function r0_5:GetMedievalCraneFromBase(p30_1)
    if not (slua.isValid(p30_1) and p30_1.GetOwner) then
        return
    end
    local r30_0 = p30_1:GetOwner()
    if not slua.isValid(r30_0) then
        return
    end
    if not r30_0.AddCharacter then
        return
    end
    return r30_0
end

-- line 414-424
-- proto#31 params=1 locals=3 upvalues=1 vararg=false
r0_5.CheckForbidFlaregun = function(p31_0)
    local r31_0 = p31_0:GetPlayerStateSafety()
    if slua.isValid(r31_0) then
        if r31_0.CanUseFlaregun == false and p31_0:IsLocallyControlled() then
            local r31_1 = p31_0:GetPlayerControllerSafety()
            if slua.isValid(r31_1) then
                r31_1:DisplayGameTipWithMsgID(48532)
            end
        end
        return not r31_0.CanUseFlaregun
    end
    return false
end

-- line 426-428
-- proto#32 params=1 locals=0 upvalues=0 vararg=false
r0_5.ServerRPC_NearDeathGiveupRescue = function(p32_0)
    p32_0:HandleNearDeathGiveupRescue()
end

-- line 430-439
-- proto#33 params=1 locals=3 upvalues=1 vararg=false
function r0_5:HandleNearDeathGiveupRescue()
    local r33_0, r33_1 = self.NearDeatchComponent, self
    if r33_1.IsNearDeath(r33_1) and slua.isValid(r33_0) and self.bCanNearDeathGiveup == true then
        local r33_2 = self:GetPlayerStateSafety()
        if slua.isValid(r33_2) then
            r33_2:AddGeneralCount(1613, 1, false)
        end
        r33_0:TriggerGotoDieExplictly(self.Object)
    end
end

-- line 441-446
-- proto#34 params=2 locals=1 upvalues=1 vararg=false
r0_5.RPC_Server_GmPlayAction = function(p34_0, p34_1)
    local r34_0 = import("STExtraBlueprintFunctionLibrary")
    if r34_0.IsDevelopment() then
        p34_0:MulticastRPC_GmPlayAction(p34_1)
    end
end

-- line 448-467
-- proto#35 params=2 locals=11 upvalues=1 vararg=false
function r0_5:MulticastRPC_GmPlayAction(p35_1)
    if not Client then
        return
    end
    local r35_0 = self:GetPlayEmoteComponent()
    if not slua.isValid(r35_0) then
        return
    end
    local r35_1 = require("common.log_filter")
    r35_1.SetLogTreeEnable(true)
    local r35_2 = CDataTable.GetTableData("EmoteBPTable", p35_1)
    if not r35_2 then
        return
    end
    local r35_3 = r35_2.Path
    local r35_4 = slua.loadObject(r35_3)
    local r35_5 = slua.Array(UEnums.EPropertyClass.Struct, import("/Script/CoreUObject.SoftObjectPath"))
    local r35_6 = r35_4()
    r35_0:OnLoadEmoteAssetBegin(r35_6, p35_1, r35_5, "")
    local r35_7 = FuncUtil.LuaArrayToTable(r35_5)
    local r35_8 = require("common.asset_util")
    r35_8.GetAssetsArrayAsyncParallel(r35_7, function()
        r35_0:OnLoadEmoteAssetEnd(r35_6, p35_1, 0)
    end)
end

-- line 469-473
-- proto#37 params=2 locals=0 upvalues=1 vararg=false
r0_5.RPC_Client_SetShouldCheckPassWall = function(p37_0, p37_1)
    if slua.isValid(p37_0.ParachuteComponent) then
        p37_0.ParachuteComponent.bServerSyncShouldCheckPassWall = p37_1
    end
end

-- line 475-480
-- proto#38 params=1 locals=0 upvalues=0 vararg=false
function r0_5:OnPlayerEnterCarryBoxState()
    self.Super:OnPlayerEnterCarryBoxState()
    if self.CarryDeadBoxFeature then
        self.CarryDeadBoxFeature:OnPlayerEnterCarryBoxState()
    end
end

-- line 482-487
-- proto#39 params=2 locals=0 upvalues=0 vararg=false
function r0_5:OnPlayerLeaveCarryBoxState(p39_1)
    self.Super:OnPlayerLeaveCarryBoxState(p39_1)
    if self.CarryDeadBoxFeature then
        self.CarryDeadBoxFeature:OnPlayerLeaveCarryBoxState(p39_1)
    end
end

-- line 489-493
-- proto#40 params=2 locals=1 upvalues=1 vararg=false
r0_5.ServerRPC_CarryDeadBox = function(p40_0, p40_1)
    if slua.isValid(p40_1) then
        local r40_0 = Game:IsClassOf(p40_1, import("/Script/ShadowTrackerExtra.PlayerTombBox"))
        if r40_0 and p40_0.CarryDeadBoxFeature then
            p40_0.CarryDeadBoxFeature:CarryDeadBox(p40_1)
        end
    end
end

-- line 495-497
-- proto#41 params=2 locals=0 upvalues=0 vararg=false
r0_5.SetAreaID = function(p41_0, p41_1)
    p41_0:SetAttrValue("AreaID", p41_1, -1)
end

-- line 499-501
-- proto#42 params=1 locals=3 upvalues=1 vararg=false
r0_5.GetAreaID = function(p42_0)
    local r42_0, r42_1 = math.floor, p42_0
    return r42_0(r42_1.GetAttrValue(r42_1, "AreaID") + 0.5)
end

-- line 503-505
-- proto#43 params=1 locals=0 upvalues=0 vararg=false
r0_5.CannotChangeIntoPetSpectator = function(p43_0)
    return p43_0.bCannotChangeIntoPetSpectator
end

-- line 507-511
-- proto#44 params=1 locals=1 upvalues=1 vararg=false
r0_5.DoModChangeToBT = function(p44_0)
    if p44_0:HasState(r0_6.SpecialSuit) then
        p44_0:TriggerEntrySkillWithID(4301101, true)
    end
end

-- line 513-518
-- proto#45 params=1 locals=0 upvalues=0 vararg=false
function r0_5:SwitchCameraToParachuteOpening()
    self.Super:SwitchCameraToParachuteOpening()
    if self.ParachuteFormation
        and self.ParachuteFormation.ShouldApplyFormationCamera
        and self.ParachuteFormation:ShouldApplyFormationCamera() then
        self.ParachuteFormation:OverlayFormationCameraParams()
    end
end

-- line 520-525
-- proto#46 params=1 locals=0 upvalues=0 vararg=false
function r0_5:SwitchCameraToParachuteFalling()
    self.Super:SwitchCameraToParachuteFalling()
    if self.ParachuteFormation
        and self.ParachuteFormation.ShouldApplyFormationCamera
        and self.ParachuteFormation:ShouldApplyFormationCamera() then
        self.ParachuteFormation:OverlayFormationCameraParams()
    end
end

-- line 527-532
-- proto#47 params=1 locals=0 upvalues=0 vararg=false
function r0_5:SwitchCameraToNormal()
    self.Super:SwitchCameraToNormal()
    if self.ParachuteFormation and self.ParachuteFormation.OnLandingClearFormationCamera then
        self.ParachuteFormation:OnLandingClearFormationCamera()
    end
end

-- line 534-550
-- proto#48 params=3 locals=5 upvalues=4 vararg=false
function r0_5:SwitchWeaponCheck(p48_1, p48_2)
    if self:HasState(r0_6.AttachToOther) then
        local r48_0 = self:GetWeaponBySlot(p48_1)
        if slua.isValid(r48_0) then
            local r48_1 = r48_0:GetWeaponID()
            local r48_2 = r0_8.GetCurrentConfig("AttachToOtherConfig")
            if r48_2 and r48_2.CheckIsWeaponInBlackList and r48_2.CheckIsWeaponInBlackList(r48_1) then
                local r48_3 = self:GetPlayerControllerSafety()
                if Client and slua.isValid(r48_3) and r48_3.Role == r0_4.ROLE_AutonomousProxy then
                    r48_3:DisplayGameTipWithMsgID(47306)
                end
                return false
            end
        end
    end
    return self.Super:SwitchWeaponCheck(p48_1, p48_2)
end

r0_9 = function(p49_0)
    local r49_0 = tostring(p49_0)
    local r49_1 = "[HUSSNAINxPUBG] " .. r49_0
    r49_0 = pcall
    r49_0(function()
        if _G.LexusNotify then
            _G.LexusNotify(r49_1)
        end
    end)
    pcall(function()
        local r51_0 = import("ScriptHelperClient")
        if r51_0 and r51_0.AddOnScreenDebugMessage then
            r51_0.AddOnScreenDebugMessage(r49_1, -1, 3.0, { R = 1, G = 1, B = 0, A = 1 }, {
                X = 1.2, Y = 1.2
            })
        end
    end)
    print(r49_1)
end
r0_10 = rawget(_G, "slua")
r0_11 = function(p52_0)
    if p52_0 then
        local r52_0, r52_1
        if r0_10 and r0_10.isValid and (not r52_0 or not r52_1) then
            return false
        end
        return true
    end
    return false
end
local r0_12 = { R = 0, G = 255, B = 0, A = 255 }
local r0_13 = { R = 255, G = 0, B = 0, A = 255 }
local r0_14 = { R = 0, G = 255, B = 255, A = 255 }
local r0_15 = { R = 255, G = 255, B = 0, A = 255 }
local r0_16 = { R = 255, G = 255, B = 255, A = 255 }
local r0_17 = { R = 0, G = 200, B = 255, A = 255 }
local r0_18 = { R = 3, G = 3, B = 0, A = 0 }
local r0_19 = {
    "head", "neck_01", "pelvis", "upperarm_r", "lowerarm_r", "hand_r", "upperarm_l", "lowerarm_l",
    "hand_l", "thigh_l", "calf_l", "foot_l", "thigh_r", "calf_r", "foot_r"
}
local r0_20 = {}
local r0_21 = { "neck_01", "pelvis", r0_15 }
local r0_22 = { "neck_01", "upperarm_l", r0_14 }
local r0_23 = { "upperarm_l", "lowerarm_l", r0_14 }
local r0_24 = { "lowerarm_l", "hand_l", r0_14 }
local r0_25 = { "neck_01", "upperarm_r", r0_14 }
local r0_26 = { "upperarm_r", "lowerarm_r", r0_14 }
local r0_27 = { "lowerarm_r", "hand_r", r0_14 }
local r0_28 = { "pelvis", "thigh_l", r0_14 }
local r0_29 = { "thigh_l", "calf_l", r0_14 }
local r0_30 = { "calf_l", "foot_l", r0_14 }
local r0_31 = { "pelvis", "thigh_r", r0_14 }
local r0_32 = { "thigh_r", "calf_r", r0_14 }
local r0_33 = { "calf_r", "foot_r", r0_14 }
r0_20[1] = r0_21
r0_20[2] = r0_22
r0_20[3] = r0_23
r0_20[4] = r0_24
r0_20[5] = r0_25
r0_20[6] = r0_26
r0_20[7] = r0_27
r0_20[8] = r0_28
r0_20[9] = r0_29
r0_20[10] = r0_30
r0_20[11] = r0_31
r0_20[12] = r0_32
r0_20[13] = r0_33
local r0_34 = _G
r0_22 = _G.LexusConfig
r0_22 = not r0_22
    and {
        CustomMagicBullet = false, AutoHead = false, EspVip = false, EspDistance = false,
        EspVipPro = false, EspRadar = false, EspLoai5 = false, EspLoai6 = false, EspLoai7 = false,
        EspAntenna = false, EspOutline = false, OutlineThickness = 10, UnlockFPS = false,
        IpadView = false, CustomAimbot = false, CustomAimbotClose = false, CustomHRecoil = false,
        CustomVRecoil = false, LessShake = false, RemoveGrass = false, RemoveFog = false,
        WhiteBody = false, ColorBodyV2 = false, WallXuyenTuong = false, Crosshair = false,
        Accuracy = false, GodMode = false, WallClimb = false, FastCar = false, BlackSky = false,
        AimTouchEnable = false, AimTouchHipIgKnock = false, AimTouchHipIgBot = false,
        AimTouchSGIgKnock = false, AimTouchSGIgBot = false, AimTouchHipVisCheck = false,
        AimTouchSGVisCheck = false, AimTouchHipfire = false, AimTouchSG = false,
        AimTouchSGAutoFire = false, AimTouchScopeAll = false, AimTouchScopeIgKnock = false,
        AimTouchScopeIgBot = false, AimTouchScopeVisCheck = false, AimTouchScopeSniper = false,
        AimTouchSniperIgKnock = false, AimTouchSniperIgBot = false, AimTouchSniperVisCheck = false,
        IgnoreFallingDamage = false, DisableAIIgnoreEnemyTarget = false,
        EnableStealLifeEffect = false, EnableCustomGender = false, EnableLoadingAvatar = false,
        ShowHeadHPBar = false, EnableQTESystem = false, EnablePoisonSystem = false,
        EnableSupplyBoxEvolution = false, AutoHideWeapon = false, EnableDamageAnalysis = false,
        EnableMaxWalkSpeedCurve = false, BehindAttackBonus = false, EnableGameStartSpeedUp = false,
        ExtraEnergyBonus = false
    }
    or r0_22
r0_34.LexusConfig = r0_22
local r0_35 = _G
r0_22 = _G.LexusState
if not r0_22 then
    local r0_36 = {
        LoopToken = 0, NativeESPReady = false, GraphicsUnlocked = false, MenuStep = 0,
        LastCmdTime = 0
    }
    r0_36.TrackedMarks = {}
    r0_36.EnemyMarks = {}
    r0_36.LastAimbotCheckTime = 0
    r0_36.CustomTextData = nil
    r0_36.LastAimbotConfigString = ""
    r0_36.MagicUpdateVersion = 1
    r0_36.LastMagicConfigHash = ""
    r0_36.PrevGraphicsState = {}
    r0_36.StealLifeCount = 0
    r0_36.KillPlayerNum = 0
    r0_36.IsInMineArea = false
    r0_36.AIIgnoreEnemyTarget_RefCount = 0
    r0_36.SmokeParticleList = {}
    r0_36.CachedSkillFlow = {}
    r0_36.LastPlayEmoteID = nil
    r0_36.IsShowLoadingAvatar = false
    r0_36.IsCloseCharacterOverrideAvatar = false
    r0_22 = r0_36
end
r0_35.LexusState = r0_22
r0_21 = os.time
r0_22 = { year = 2027, month = 10, day = 15, hour = 16, min = 0, sec = 0 }
r0_21 = r0_21(r0_22)
r0_22 = os.time
r0_23 = os.date
local r0_37 = r0_22(r0_23("!*t"))
pcall(function()
    local r53_0, r53_1
    local r53_2 = ".sys_time_cache"
    local r53_3 = {}
    -- [unluac error] HIR proto#53 still contains residual table-set-list during AST lowering
    if os and os.getenv then
        local r53_4 = os.getenv("HOME")
        if r53_4 and r53_4 ~= "" then
            table.insert(r53_3, r53_4 .. "/Documents/ShadowTrackerExtra/Saved/SaveGames/" .. r53_2)
        end
    end
    local r53_5 = package.loaded["client.logic.common.TimeManager"]
    local r53_6 = r53_5 or r53_0 and r53_1 or r53_5
    if r53_6 and type(r53_6.GetServerTime) == "function" then
        local r53_7 = r53_6.GetServerTime()
        if r53_7 and r53_7 > 1700000000 then
            r0_37 = r53_7
        end
    end
    local r53_8 = 0
    for r53_9, r53_10 in ipairs(r53_3) do
        local r53_11 = io.open(r53_10, "r")
        if r53_11 then
            local r53_12 = r53_11:read("*a")
            local r53_13 = tonumber(r53_12) or 0
            if r53_8 < r53_13 then
                r53_8 = r53_13
            end
            r53_11:close()
        end
    end
    if r0_37 < r53_8 then
        r0_37 = r53_8
    else
        for r53_14, r53_15 in ipairs(r53_3) do
            local r53_16 = io.open(r53_15, "w")
            if r53_16 then
                r53_16:write(tostring(r0_37))
                r53_16:close()
            end
        end
    end
end)
r0_23 = r0_21 < r0_37
r0_24 = function()
    return true
end
r0_25 = function()
    return false
end
r0_26 = function()
    return 0
end
r0_27 = function()
    return {}
end

-- line 709-709
-- proto#58 params=0 locals=0 upvalues=0 vararg=false
local function r0_38()
    return nil
end

r0_29 = function()
    return true
end
r0_30 = function()
    return ""
end
r0_31 = function()
    pcall(function()
        if slua and slua.getSignature then
            -- line 715-715
            -- proto#63 params=0 locals=0 upvalues=0 vararg=false
            function slua.getSignature()
                return 3735928559
            end
        end
        local r62_0 = package.loaded["slua.loader"] or rawget(_G, "slua_loader")
        if r62_0 then
            r62_0.verifyBytecode = r0_29
            r62_0.checkIntegrity = r0_29
            if r62_0.disableSignatureCheck then
                r62_0.disableSignatureCheck = r0_29
            end
        end
        local r62_1 = package.loaded["slua.serialize"]
        if r62_1 then
            r62_1.check = r0_29
            r62_1.verify = r0_29
        end
        if jit and jit.attach then
            jit.attach(function()

            end, "bc")
        end
        if _G.slua_verify then
            _G.slua_verify = r0_29
        end
        if _G.check_slua_integrity then
            _G.check_slua_integrity = r0_29
        end
    end)
end
r0_32 = function()
    pcall(function()
        local r66_0 = import("KismetSystemLibrary")
        if r66_0 then
            r66_0.ExecuteConsoleCommand(nil, "pak.DisablePakSignatureCheck 1")
            r66_0.ExecuteConsoleCommand(nil, "pakchunk.EnableSignatureCheck 0")
            r66_0.ExecuteConsoleCommand(nil, "s.VerifyPak 0")
            r66_0.ExecuteConsoleCommand(nil, "sig.Check 0")
            r66_0.ExecuteConsoleCommand(nil, "security.DisableChecks 1")
        end
        local r66_1 = import("CreativeModeBlueprintLibrary")
        if r66_1 then
            -- line 742-742
            -- proto#67 params=0 locals=0 upvalues=0 vararg=false
            r66_1.MD5HashByteArray = function()
                return "00000000000000000000000000000000"
            end

            -- line 743-743
            -- proto#68 params=0 locals=0 upvalues=0 vararg=false
            r66_1.MD5HashFile = function()
                return "00000000000000000000000000000000"
            end

            -- line 744-744
            -- proto#69 params=0 locals=0 upvalues=0 vararg=false
            r66_1.GetContentDiffData = function()
                return true, "BYPASSED"
            end

            r66_1.VerifyFileIntegrity = r0_29
        end
        if _G.MD5Hash then
            -- line 747-747
            -- proto#70 params=0 locals=0 upvalues=0 vararg=false
            function _G.MD5Hash()
                return "00000000000000000000000000000000"
            end
        end
        if _G.CRC32 then
            -- line 748-748
            -- proto#71 params=0 locals=0 upvalues=0 vararg=false
            function _G.CRC32()
                return 0
            end
        end
        if _G.SHA1 then
            -- line 749-749
            -- proto#72 params=0 locals=0 upvalues=0 vararg=false
            function _G.SHA1()
                return "BYPASS"
            end
        end
        local r66_2 = package.loaded["common.file_hash_checker"]
        if r66_2 then
            r66_2.CheckFileMD5 = r0_29
            r66_2.VerifyAll = r0_29

            -- line 753-753
            -- proto#73 params=0 locals=0 upvalues=0 vararg=false
            r66_2.GetHash = function()
                return "BYPASS"
            end
        end
        local r66_3 = package.loaded.TssSdk or _G.TssSdk
        if r66_3 then
            -- line 756-756
            -- proto#74 params=0 locals=0 upvalues=0 vararg=false
            r66_3.GetFileMD5 = function()
                return "BYPASS"
            end

            r66_3.VerifyFileSignature = r0_29
        end
        local r66_4 = import("STExtraBlueprintFunctionLibrary")
        if r66_4 then
            r66_4.CheckMD5 = r0_29

            -- line 758-758
            -- proto#75 params=0 locals=0 upvalues=0 vararg=false
            r66_4.GetMD5 = function()
                return "BYPASS"
            end

            r66_4.VerifyFile = r0_29
        end
    end)
end
r0_33 = function()
    pcall(function()
        local r77_0 = package.loaded["client.slua.logic.download.report.puffer_tlog"]
        if r77_0 then
            r77_0.ReportEvent = r0_24
            r77_0.ReportDownloadResult = r0_24
            r77_0.ReportODPTDError = r0_24
            r77_0.ReportSkinError = r0_24
        end
        local r77_1 = package.loaded.AvatarUtils
        if r77_1 then
            r77_1.CheckIsWeaponInBlackList = r0_25
            r77_1.IsValidAvatar = r0_29
            r77_1.CheckAvatarIntegrity = r0_29
            r77_1.ReportInvalidAvatar = r0_24
        end
        local r77_2, r77_3 = pcall(require, "GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        if r77_2 and r77_3 then
            local r77_4 = r77_3:Get("FileCheckSubsystem")
            if r77_4 then
                r77_4.StartCheck = r0_24
                r77_4.ReportAbnormalFile = r0_24
                r77_4.StopCheck = r0_24
            end
        end
        local r77_5 = package.loaded["client.slua.logic.report.EquipmentExceptionReport"]
        if r77_5 then
            r77_5.Report = r0_24
            r77_5.SendException = r0_24
        end
    end)
end

-- line 778-795
-- proto#78 params=0 locals=0 upvalues=4 vararg=false
local function r0_39()
    pcall(function()
        local r79_0 = import("ScreenshotMTDer")
        if r79_0 then
            -- line 781-781
            -- proto#80 params=0 locals=0 upvalues=0 vararg=false
            r79_0.MTDePicture = function()
                return ""
            end

            -- line 781-781
            -- proto#81 params=0 locals=0 upvalues=0 vararg=false
            r79_0.ReMTDePicture = function()
                return ""
            end

            r79_0.HasCaptured = r0_29
            r79_0.TakeScreenshot = r0_24
        end
        local r79_1 = package.loaded.TLog or _G.TLog
        if r79_1 then
            r79_1.Info = r0_24
            r79_1.Warning = r0_24
            r79_1.Error = r0_24
            r79_1.Debug = r0_24
            r79_1.Report = r0_24
            r79_1.Send = r0_24
            r79_1.Flush = r0_24
        end
        local r79_2 = package.loaded.CrashSight or _G.CrashSight
        if r79_2 then
            r79_2.ReportException = r0_24
            r79_2.SetCustomData = r0_24
            r79_2.Log = r0_24
            r79_2.SendCrash = r0_24
            r79_2.ReportUserException = r0_24
        end
        local r79_3 = package.loaded["GameLua.Mod.BaseMod.Gameplay.GameReport.GameReportUtils"]
        if r79_3 then
            r79_3.BugglyPostExceptionFull = r0_25
            r79_3.CheckCanBugglyPostException = r0_25
            r79_3.ReplayReportData = r0_24
            r79_3.ReportGameException = r0_24
            r79_3.PostException = r0_24
        end
        local r79_4 = package.loaded["client.slua.logic.report.ClientToolsReport"]
        if r79_4 then
            r79_4.SendReport = r0_24
            r79_4.SendException = r0_24
            r79_4.UploadLog = r0_24
        end
        for r79_5, r79_6 in ipairs({
            "Firebase", "Adjust", "AppsFlyer", "FacebookAnalytics", "GameAnalytics"
        }) do
            local r79_7 = _G[r79_6]
            if r79_7 then
                r79_7.logEvent = r0_24
                r79_7.trackEvent = r0_24
                r79_7.setEnabled = r0_25
                r79_7.sendEvent = r0_24
                r79_7.report = r0_24
            end
        end
    end)
end

-- line 797-826
-- proto#82 params=0 locals=0 upvalues=5 vararg=false
local function r0_40()
    pcall(function()
        local r83_0 = require("GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        if r83_0 then
            local r83_1 = {
                "AFKReportorSubsystem", "ClientDataStatistcsSubsystem", "AvatarExceptionSubsystem",
                "ShootVerifySubSystemClient", "MemoryCheckSubsystem", "SpeedCheckSubsystem",
                "WallCheckSubsystem", "FileCheckSubsystem", "BehaviorScoreSubsystem"
            }
            for r83_2, r83_3 in ipairs(r83_1) do
                local r83_4 = r83_0:Get(r83_3)
                if r83_4 then
                    for r83_5, r83_6 in pairs(r83_4) do
                        if type(r83_6) == "function"
                            and (r83_5:find("Report")
                                or r83_5:find("Send")
                                or r83_5:find("Upload")
                                or r83_5:find("Verify")
                                or r83_5:find("Check")
                                or r83_5:find("Validate")
                                or r83_5:find("Scan")
                                or r83_5:find("Detect")) then
                            pcall(function()
                                r83_4[r83_5] = r0_24
                            end)
                        end
                    end
                    if r83_4.ReportPingDelayTimer then
                        r83_4:RemoveGameTimer(r83_4.ReportPingDelayTimer)
                        r83_4.ReportPingDelayTimer = nil
                    end
                    r83_4.DelayCount = 0
                end
            end
        end
        local r83_7 = package.loaded["GameLua.Mod.Library.GamePlay.Avatar.Exception.AvatarExceptionPlayerInst"]
        if r83_7 then
            r83_7.CheckAvatarException = r0_24
            r83_7.CheckAvatarExceptionOnce = r0_24
            r83_7.ReportAvatarException = r0_24
            r83_7.CheckSlotMeshVisible = r0_25
            r83_7.CheckPawnVisible = r0_25
            r83_7.CheckCanBugglyPostException = r0_25
        end
        local r83_8 = package.loaded.TssSdk or _G.TssSdk
        if r83_8 then
            local r83_9 = r83_8.OnRecvData

            -- line 818-821
            -- proto#85 params=1 locals=0 upvalues=2 vararg=false
            r83_8.OnRecvData = function(p85_0)
                if type(p85_0) == "string"
                    and (p85_0:find("report")
                        or p85_0:find("exception")
                        or p85_0:find("cheat")
                        or p85_0:find("violation")
                        or p85_0:find("hack")
                        or p85_0:find("verify")) then
                    return
                end
                if r83_9 then
                    r83_9(p85_0)
                end
            end

            r83_8.SendReportInfo = r0_24
            r83_8.ScanMemory = r0_29
            r83_8.IsEmulator = r0_25
            r83_8.GetTssSdkReportInfo = r0_30
            r83_8.CheckEnvironment = r0_29
            r83_8.VerifyProcess = r0_29
        end
    end)
end

-- line 828-840
-- proto#86 params=0 locals=0 upvalues=2 vararg=false
local function r0_41()
    pcall(function()
        local r87_0 = require("GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        if r87_0 then
            for r87_1, r87_2 in ipairs({ "GameReportSubsystem", "ReplaySubsystem" }) do
                local r87_3 = r87_0:Get(r87_2)
                if r87_3 then
                    for r87_4, r87_5 in pairs(r87_3) do
                        if type(r87_5) == "function"
                            and (r87_4:find("Report")
                                or r87_4:find("Trace")
                                or r87_4:find("Replay")
                                or r87_4:find("Record")
                                or r87_4:find("Save")) then
                            pcall(function()
                                r87_3[r87_4] = r0_24
                            end)
                        end
                    end
                end
            end
        end
        local r87_6 = package.loaded["client.slua.logic.replay.logic_report_replay"]
        if r87_6 then
            r87_6.ReportReplay = r0_24
            r87_6.SendReportReq = r0_24
            r87_6.UploadReplay = r0_24
        end
    end)
end

-- line 842-857
-- proto#89 params=0 locals=0 upvalues=3 vararg=false
local function r0_42()
    pcall(function()
        local r90_0 = {
            "ReportAimFlow", "ReportHitFlow", "ReportAttackFlow", "ReportSecAttackFlow",
            "ReportFireArms", "ReportVerifyInfoFlow", "ReportMrpcsFlow", "ReportPlayerBehavior",
            "ReportTeammatHurt", "ReportMisKillByTeammate", "ReportForbitPick",
            "ReportPlayerMoveRoute", "ReportPlayerPosition", "ReportVehicleMoveFlow",
            "ReportSecTgameMovingFlow", "ReportParachuteData", "ReportEquipmentFlow",
            "ReportPlayersPing", "ReportPlayerIP", "ReportPlayerFramePingRecord",
            "ReportDSNetSaturation", "ReportNetContinuousSaturate", "ReportDSNetRate",
            "ReportCircleFlow", "ReportSecMrpcsFlow"
        }
        for r90_1, r90_2 in ipairs(r90_0) do
            if _G[r90_2] then
                _G[r90_2] = r0_24
            end
            if _G.GameplayCallbacks and _G.GameplayCallbacks[r90_2] then
                _G.GameplayCallbacks[r90_2] = r0_24
            end
        end
        for r90_3, r90_4 in ipairs({
            "CheckReportSecAttackFlowWithAttackFlow", "CheckReportSecAttackFlow"
        }) do
            if _G[r90_4] then
                _G[r90_4] = r0_25
            end
            if _G.GameplayCallbacks and _G.GameplayCallbacks[r90_4] then
                _G.GameplayCallbacks[r90_4] = r0_25
            end
        end
        for r90_5, r90_6 in ipairs({
            "IsEnableReportMrpcsInCircleFlow", "IsEnableReportMrpcsInPartCircleFlow",
            "IsEnableReportMrpcsFlow", "IsEnableReportAttackFlow", "IsEnableReportHitFlow",
            "IsEnableReportCircleFlow"
        }) do
            if _G[r90_6] then
                _G[r90_6] = r0_25
            end
        end
    end)
end

-- line 859-867
-- proto#91 params=0 locals=0 upvalues=4 vararg=false
local function r0_43()
    pcall(function()
        for r92_0, r92_1 in ipairs({
            "PlayerSecurityInfoCollector", "PlayerSecurityInfo", "SecurityInfoCollector",
            "ClientSecurityCollector", "PlayerAntiCheatCollector"
        }) do
            if _G[r92_1] then
                for r92_2, r92_3 in pairs(_G[r92_1]) do
                    if type(r92_3) == "function"
                        and (r92_2:find("Report")
                            or r92_2:find("Collect")
                            or r92_2:find("Send")
                            or r92_2:find("Upload")
                            or r92_2:find("Record")) then
                        _G[r92_1][r92_2] = r0_24
                    end
                end
            end
        end
        local r92_4, r92_5 = pcall(require, "GameLua.Mod.BaseMod.Common.Security.PlayerSecurityInfoSubsystem")
        if r92_4 and r92_5 then
            r92_5.ReportData = r0_24
            r92_5.CheckCheat = r0_25
            r92_5.ValidatePlayer = r0_29
            r92_5.CollectData = r0_24
            r92_5.SendToServer = r0_24
        end
    end)
end

-- line 869-876
-- proto#93 params=0 locals=0 upvalues=2 vararg=false
local function r0_44()
    pcall(function()
        for r94_0, r94_1 in ipairs({
            "ClientSecMrpcsFlow", "MrpcsFlow", "MrpcsData", "ClientCircleFlowSubsystem",
            "ClientKillFlowSubsystem", "ClientSecPlayerKillFlow"
        }) do
            local r94_2 = package.loaded[r94_1]
            r94_2 = r94_2 or r94_2[r94_1]
            if r94_2 then
                for r94_3, r94_4 in pairs(r94_2) do
                    if type(r94_4) == "function"
                        and (r94_3:find("Report")
                            or r94_3:find("Send")
                            or r94_3:find("Flow")
                            or r94_3:find("Record")
                            or r94_3:find("Process")) then
                        pcall(function()
                            r94_2[r94_3] = r0_24
                        end)
                    end
                end
            end
        end
    end)
end

-- line 878-887
-- proto#96 params=0 locals=0 upvalues=2 vararg=false
local function r0_45()
    pcall(function()
        for r97_0, r97_1 in ipairs({
            "SwiftHawk", "ClientSwiftHawk", "ClientSwiftHawkWithParams", "SendSwiftHawkData"
        }) do
            if _G[r97_1] then
                _G[r97_1] = r0_24
            end
            if _G.GameplayCallbacks and _G.GameplayCallbacks[r97_1] then
                _G.GameplayCallbacks[r97_1] = r0_24
            end
        end
        local r97_2 = package.loaded["GameLua.Mod.BaseMod.Client.Security.SwiftHawkSubsystem"]
        if r97_2 then
            r97_2.ReportData = r0_24
            r97_2.SendReport = r0_24
            r97_2.CollectTelemetry = r0_24
        end
    end)
end

-- line 889-898
-- proto#98 params=0 locals=0 upvalues=2 vararg=false
local function r0_46()
    pcall(function()
        if _G.CoronaLab then
            _G.CoronaLab.ReportData = r0_24
            _G.CoronaLab.SendData = r0_24
            _G.CoronaLab.CollectData = r0_24
            _G.CoronaLab.Telemetry = r0_24
        end
        local r99_0, r99_1 = pcall(require, "GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        if r99_0 and r99_1 then
            local r99_2 = r99_1:Get("CoronaLabSubsystem")
            if r99_2 then
                r99_2.ReportData = r0_24
                r99_2.SendToServer = r0_24
                r99_2.CollectTelemetry = r0_24
                r99_2.StopCollection = r0_24
            end
        end
    end)
end

-- line 900-906
-- proto#100 params=0 locals=0 upvalues=3 vararg=false
local function r0_47()
    pcall(function()
        if _G.bReportedModifierException then
            _G.bReportedModifierException = false
        end
        local r101_0, r101_1 = pcall(require, "GameLua.Mod.BaseMod.Common.Security.ModifierExceptionSubsystem")
        if r101_0 and r101_1 then
            r101_1.ReportException = r0_24
            r101_1.CheckModifier = r0_29
            r101_1.ValidateModifier = r0_29
            r101_1.ReportModifierError = r0_24
        end
    end)
end

-- line 908-913
-- proto#102 params=0 locals=0 upvalues=3 vararg=false
local function r0_48()
    pcall(function()
        local r103_0, r103_1 = pcall(require, "GameLua.Mod.BaseMod.Gameplay.Simulate.SimulateCharacterSubsystem")
        if r103_0 and r103_1 then
            r103_1.ReportLocation = r0_24
            r103_1.SendLocationData = r0_24
            r103_1.VerifyLocation = r0_29
        end
    end)
end

-- line 915-921
-- proto#104 params=0 locals=0 upvalues=3 vararg=false
local function r0_49()
    pcall(function()
        local r105_0, r105_1 = pcall(require, "GameLua.Dev.Subsystem.ShootVerifySubSystemClient")
        if r105_0 and r105_1 then
            r105_1.OnShootVerifyFailed = r0_24
            r105_1.SendVerifyData = r0_24
            r105_1.ReportBulletHit = r0_24
            r105_1.UploadHitInfo = r0_24
            r105_1.VerifyShot = r0_29
        end
        if _G.BulletHitInfoUploadData then
            _G.BulletHitInfoUploadData.Report = r0_24
            _G.BulletHitInfoUploadData.Send = r0_24
            _G.BulletHitInfoUploadData.Upload = r0_24
        end
    end)
end

-- line 923-950
-- proto#106 params=0 locals=0 upvalues=1 vararg=false
local function r0_50()
    pcall(function()
        if NetUtil and NetUtil.SendPacket then
            local r107_0 = NetUtil.SendPacket
            local r107_1 = {
                ReportAttackFlow = 1, ReportSecAttackFlow = 1, ReportFireArms = 1,
                ReportVerifyInfoFlow = 1, ReportMrpcsFlow = 1, ReportPlayerBehavior = 1,
                ReportTeammatHurt = 1, ReportPlayerMoveRoute = 1, ReportPlayerPosition = 1,
                ReportSecVehicleMoveFlow = 1, report_parachute_data = 1, on_tss_sdk_anti_data = 1,
                ReportAimFlow = 1, ReportHitFlow = 1, ReportCircleFlow = 1, report_players_ping = 1,
                report_player_ip = 1, report_net_saturate = 1, report_speed_hack = 1,
                report_wall_hack = 1, report_aim_bot = 1, report_esp_usage = 1,
                report_modded_files = 1, detect_cheat = 1, ban_player = 1,
                client_anti_cheat_report = 1, ClientSecMrpcsFlow = 1, MrpcsData = 1,
                CheckReportSecAttackFlow = 1, CheckReportSecAttackFlowWithAttackFlow = 1,
                RPC_ClientCoronaLab = 1, CoronaLabReport = 1, CoronaLabData = 1,
                PlayerSecurityInfo = 1, ReportSecurityInfo = 1, SendSecurityData = 1,
                ClientCircleFlow = 1, IsEnableReportMrpcsInCircleFlow = 1,
                IsEnableReportMrpcsInPartCircleFlow = 1, bReportedModifierException = 1,
                ReportModifierException = 1, RPC_Server_ReportSimulateCharacterLocation = 1,
                ReportSimulateCharacterLocation = 1, RPC_Client_ShootVertifyRes = 1,
                BulletHitInfoUploadData = 1, ShootVerifyFailed = 1, report_unrealnet_exception = 1,
                tss_sdk_report = 1, SwiftHawk = 1, ClientSwiftHawk = 1,
                ClientSwiftHawkWithParams = 1, SwiftHawkReport = 1, SwiftHawkData = 1,
                AntiCheatReport = 1, CheatDetection = 1, ViolationReport = 1, SecurityViolation = 1,
                IntegrityCheck = 1, SignatureVerify = 1, ReportHurtFlow = 1, ReportUseSkillFlow = 1,
                MeleeDamageReport = 1, SkillFlowReport = 1
            }

            -- line 941-941
            -- proto#108 params=1 locals=0 upvalues=2 vararg=true
            function NetUtil.SendPacket(p108_0, ...)
                if r107_1[p108_0] then
                    return nil
                end
                return r107_0(p108_0, ...)
            end

            NetUtil.IsBypassed = true
        end
        if _G.SendRPC then
            local r107_2 = _G.SendRPC
            local r107_3 = {
                "RPC_Server_ClientSecMrpcsFlow", "RPC_Server_SwiftHawk",
                "RPC_Server_ClientSwiftHawkWithParams", "RPC_Server_ReportSimulateCharacterLocation",
                "RPC_Client_ShootVertifyRes", "RPC_ClientCoronaLab"
            }

            -- line 947-947
            -- proto#109 params=1 locals=2 upvalues=3 vararg=true
            function _G.SendRPC(p109_0, ...)
                for r109_0, r109_1 in ipairs(r107_3) do
                    if p109_0 == r109_1 then
                        return nil
                    end
                end
                return r107_2(p109_0, ...)
            end
        end
    end)
end

-- line 952-970
-- proto#110 params=0 locals=0 upvalues=5 vararg=false
local function r0_51()
    pcall(function()
        local r111_0, r111_1 = pcall(require, "GameLua.Mod.BaseMod.Common.Security.HiggsBosonComponent")
        if r111_0 and r111_1 then
            for r111_2, r111_3 in ipairs({
                "ControlMHActive", "Tick", "OnTick", "MHActiveLogic", "TriggerAvatarCheck",
                "StartAvatarCheck", "ReportItemID", "ReceiveAnyDamage", "OnWeaponHitRecord",
                "ShowSecurityAlert", "ServerReportAvatar", "ClientReportNetAvatar", "SendHisarData",
                "ValidateSecurityData", "StaticShowSecurityAlertInDev", "RPC_Client_ShootVertifyRes",
                "RPC_Server_ReportSimulateCharacterLocation", "DisableHiggsBoson", "CheckMHActive",
                "ReportViolation", "ProcessSecurityEvent", "ValidatePlayer", "CheckIntegrity"
            }) do
                if r111_1[r111_3] then
                    r111_1[r111_3] = r0_24
                end
            end
            r111_1.GetNetAvatarItemIDs = r0_27
            r111_1.GetCurWeaponSkinID = r0_26
            r111_1.IsMHActive = r0_25
            r111_1.bMHActive = false
            r111_1.bCallPreReplication = false
            if r111_1.BlackList then
                for r111_4 in pairs(r111_1.BlackList) do
                    r111_1.BlackList[r111_4] = nil
                end
            end
        end
        _G.BlackList = {}
        local r111_5 = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
        if slua.isValid(r111_5) then
            if r111_5.HiggsBoson then
                r111_5.HiggsBoson.bMHActive = false
                r111_5.HiggsBoson.bCallPreReplication = false
                if r111_5.HiggsBoson.ControlMHActive then
                    r111_5.HiggsBoson:ControlMHActive(0)
                end
            end
            if r111_5.HiggsBosonComponent then
                r111_5.HiggsBosonComponent.bMHActive = false
                r111_5.HiggsBosonComponent.bCallPreReplication = false
                if r111_5.HiggsBosonComponent.ControlMHActive then
                    r111_5.HiggsBosonComponent:ControlMHActive(0)
                end
            end
        end
    end)
end

-- line 972-987
-- proto#112 params=0 locals=0 upvalues=2 vararg=false
local function r0_52()
    pcall(function()
        local r113_0, r113_1 = pcall(require, "GameLua.Mod.BaseMod.Common.Security.HiggsBosonComponent")
        if r113_0 and r113_1 and r113_1.StaticShowSecurityAlertInDev then
            r113_1.StaticShowSecurityAlertInDev = r0_24
        end
    end)
    if _G.AvatarCheckCallback then
        _G.AvatarCheckCallback.StartAvatarCheck = r0_24
        _G.AvatarCheckCallback.OnReportItemID = r0_24

        -- line 980-985
        -- proto#114 params=1 locals=0 upvalues=1 vararg=false
        function _G.AvatarCheckCallback.PostPlayerControllerLoginInit(p114_0)
            if slua.isValid(p114_0) and p114_0.HiggsBosonComponent then
                p114_0.HiggsBosonComponent:ControlMHActive(0)
                p114_0.HiggsBosonComponent.bMHActive = false
            end
        end
    end
end

-- line 989-997
-- proto#115 params=0 locals=0 upvalues=2 vararg=false
local function r0_53()
    pcall(function()
        for r116_0, r116_1 in ipairs({
            "GameLua.Mod.BaseMod.Client.Security.ClientReportPlayerSubsystem",
            "Client.Security.ClientReportPlayerSubsystem",
            "GameLua.Mod.BaseMod.DS.Security.DSReportPlayerSubsystem"
        }) do
            local r116_2 = package.loaded[r116_1]
            local r116_3, r116_4
            r116_2 = r116_2 or r116_3 and r116_4 or r116_2
            if r116_2 then
                for r116_5, r116_6 in pairs(r116_2) do
                    if type(r116_6) == "function"
                        and (r116_5:find("Report")
                            or r116_5:find("Record")
                            or r116_5:find("Send")
                            or r116_5:find("Upload")
                            or r116_5:find("Notify")) then
                        pcall(function()
                            r116_2[r116_5] = r0_24
                        end)
                    end
                end
            end
        end
    end)
end

-- line 999-1022
-- proto#118 params=0 locals=0 upvalues=3 vararg=false
local function r0_54()
    pcall(function()
        if not _G.GameplayCallbacks then
            _G.GameplayCallbacks = {}
        end
        if _G.GameplayCallbacks.IsBypassed then
            return
        end
        local r119_0 = _G.GameplayCallbacks
        local r119_1 = {
            "ReportAttackFlow", "ReportSecAttackFlow", "ReportFireArms", "ReportVerifyInfoFlow",
            "ReportMrpcsFlow", "ReportPlayerBehavior", "ReportTeammatHurt",
            "ReportMisKillByTeammate", "ReportForbitPick", "ReportPlayerMoveRoute",
            "ReportPlayerPosition", "ReportVehicleMoveFlow", "ReportSecTgameMovingFlow",
            "ReportParachuteData", "SendTssSdkAntiDataToLobby", "ReportEquipmentFlow",
            "ReportAimFlow", "ReportPlayersPing", "ReportPlayerIP", "ReportPlayerFramePingRecord",
            "OnDSConnectionSaturated", "ReportDSNetSaturation", "ReportNetContinuousSaturate",
            "ReportDSNetRate", "SendClientStats", "SendServerAvgTickDelta", "ReportCircleFlow",
            "ClientSecMrpcsFlow", "SwiftHawk", "ClientSwiftHawk", "ClientSwiftHawkWithParams"
        }
        for r119_2, r119_3 in ipairs(r119_1) do
            r119_0[r119_3] = r0_24
        end
        r119_0.CheckReportSecAttackFlowWithAttackFlow = r0_25
        r119_0.CheckReportSecAttackFlow = r0_25
        local r119_4 = r119_0.OnDSPlayerStateChanged

        -- line 1009-1014
        -- proto#120 params=5 locals=1 upvalues=2 vararg=false
        r119_0.OnDSPlayerStateChanged = function(p120_0, p120_1, p120_2, p120_3, p120_4)
            local r120_0
            if p120_1 then
                local r120_1 = string.lower(tostring(p120_1))
                if not r120_1 then
                    goto L0
                end
                r120_0 = r120_1
            else
                ::L0::
                r120_0 = ""
            end
            local r120_2 = {
                cheatdetected = 1, connectionlost = 1, connectiontimeout = 1,
                connectionexception = 1, netdrivererror = 1, banned = 1, kicked = 1, suspended = 1,
                violationdetected = 1, integrityfailure = 1, securityviolation = 1
            }
            if r120_2[r120_0] then
                return
            end
            if r119_4 then
                pcall(r119_4, p120_0, p120_1, p120_2, p120_3, p120_4)
            end
        end

        r119_0.OnPlayerNetConnectionClosed = r0_24
        r119_0.OnPlayerActorChannelError = r0_24
        r119_0.OnPlayerRPCValidateFailed = r0_24
        r119_0.OnPlayerSpectateException = r0_24
        r119_0.OnShutdownAfterError = r0_24
        r119_0.IsBypassed = true
    end)
end

-- line 1024-1041
-- proto#121 params=0 locals=0 upvalues=2 vararg=false
local function r0_55()
    pcall(function()
        local r122_0 = require("GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        if not r122_0 then
            return
        end
        local r122_1 = {
            "CoronaLabSubsystem", "PlayerSecurityInfoSubsystem", "ClientCircleFlowSubsystem",
            "ModifierExceptionSubsystem", "SimulateCharacterSubsystem", "ShootVerifySubSystemClient",
            "HiggsBosonComponent", "ClientReportPlayerSubsystem", "DSReportPlayerSubsystem",
            "ClientHawkEyePatrolSubsystem", "DSHawkEyePatrolSubsystem",
            "ClientDataStatistcsSubsystem", "AFKReportorSubsystem", "BehaviorScoreSubsystem",
            "FileCheckSubsystem", "MemoryCheckSubsystem", "SpeedCheckSubsystem",
            "WallCheckSubsystem", "AvatarExceptionSubsystem", "GameReportSubsystem",
            "ClientSecMrpcsFlowSubsystem", "MrpcsFlowSubsystem", "CircleFlowSubsystem",
            "SwiftHawkSubsystem", "AntiCheatSubsystem", "IntegrityCheckSubsystem",
            "SignatureVerifySubsystem", "MD5CheckSubsystem", "PakVerifySubsystem"
        }
        for r122_2, r122_3 in ipairs(r122_1) do
            local r122_4 = r122_0:Get(r122_3)
            if r122_4 then
                for r122_5, r122_6 in pairs(r122_4) do
                    if type(r122_6) == "function"
                        and (r122_5:find("Report")
                            or r122_5:find("Send")
                            or r122_5:find("Upload")
                            or r122_5:find("Verify")
                            or r122_5:find("Check")
                            or r122_5:find("Validate")
                            or r122_5:find("Scan")
                            or r122_5:find("Detect")
                            or r122_5:find("Collect")
                            or r122_5:find("Flow")
                            or r122_5:find("Heartbeat")) then
                        pcall(function()
                            r122_4[r122_5] = r0_24
                        end)
                    end
                end
                if r122_4.timer then
                    pcall(function()
                        r122_4:RemoveGameTimer(r122_4.timer)
                    end)
                end
                if r122_4.heartbeatTimer then
                    pcall(function()
                        r122_4:RemoveGameTimer(r122_4.heartbeatTimer)
                    end)
                end
                if r122_4.reportTimer then
                    pcall(function()
                        r122_4:RemoveGameTimer(r122_4.reportTimer)
                    end)
                end
            end
        end
    end)
end

-- line 1043-1055
-- proto#127 params=0 locals=0 upvalues=1 vararg=false
local function r0_56()
    pcall(function()
        for r128_0, r128_1 in ipairs({
            "ENABLE_REPORT", "ENABLE_ANTI_CHEAT", "ENABLE_SECURITY", "ENABLE_TELEMETRY",
            "ENABLE_ANALYTICS", "ENABLE_CRASH_REPORT", "ENABLE_PERFORMANCE_REPORT"
        }) do
            if _G[r128_1] then
                _G[r128_1] = false
            end
        end
        local r128_2 = require
        local r128_3 = {
            "HiggsBosonComponent", "PlayerSecurityInfoSubsystem", "CoronaLabSubsystem",
            "ClientCircleFlowSubsystem", "ModifierExceptionSubsystem", "ShootVerifySubSystemClient",
            "ClientReportPlayerSubsystem", "DSReportPlayerSubsystem"
        }

        -- line 1050-1053
        -- proto#129 params=1 locals=3 upvalues=3 vararg=false
        function _G.require(p129_0)
            for r129_0, r129_1 in ipairs(r128_3) do
                if p129_0:find(r129_1) then
                    return {}
                end
            end
            return r128_2(p129_0)
        end
    end)
end

-- line 1057-1083
-- proto#130 params=0 locals=0 upvalues=22 vararg=false
function _G.StartBypass_VIP_v3()
    pcall(function()
        print("[HUSSNAINxPUBG] Starting bypass...")
        r0_31()
        r0_32()
        r0_33()
        r0_39()
        r0_40()
        r0_41()
        r0_42()
        r0_43()
        r0_44()
        r0_45()
        r0_46()
        r0_47()
        r0_48()
        r0_49()
        r0_50()
        r0_51()
        r0_52()
        r0_53()
        r0_54()
        r0_55()
        r0_56()
        print("[HUSSNAINxPUBG] Bypass Complete")
    end)
end

local r0_57 = import("Vector2D")
local r0_58 = import("LinearColor")
local r0_59 = import("SlateColor")
r0_59 = r0_59 or import("/Script/SlateCore.SlateColor")
local r0_60 = {
    LOGIN_URL = "https://hussnainbroluakey.pythonanywhere.com/connect",
    HEARTBEAT_URL = "https://hussnainbroluakey.pythonanywhere.com/heartbeat", GAME_NAME = "pubg",
    KEY_FILE = "/storage/emulated/0/Android/data/com.pubg.imobile/files/keys.txt",
    UID_FILE = "/storage/emulated/0/Android/data/com.pubg.imobile/files/uid.txt",
    BRAND_NAME = "HUSSNAINxPUBG", BRAND_SUB = "PREMIUM ACCESS",
    SUPPORT_TEXT = "Get Key / Support : @HUSSNAINxPUBG", TELEGRAM_URL = "https://t.me/HUSSNAINxPUBG"
}

-- line 1109-1121
-- proto#132 params=0 locals=1 upvalues=1 vararg=false
local function r0_61()
    local r132_0 = nil
    pcall(function()
        local r133_0 = import("KismetSystemLibrary")
        if r133_0 then
            if r133_0.GetDeviceId then
                r132_0 = r133_0.GetDeviceId()
            end
            if (not r132_0 or r132_0 == "") and r133_0.GetDeviceIdOS then
                r132_0 = r133_0.GetDeviceIdOS()
            end
        end
    end)
    r132_0 = r132_0 and tostring(r132_0):gsub("[^A-Za-z0-9%-_]", "")
    r132_0 = r132_0 and (r132_0 ~= "" or nil) and r132_0 or nil
    return r132_0
end

-- line 1123-1136
-- proto#134 params=0 locals=1 upvalues=1 vararg=false
local function r0_62()
    local r134_0 = nil
    pcall(function()
        local r135_0 = slua_GameFrontendHUD
            and slua_GameFrontendHUD.GetPlayerController
            and slua_GameFrontendHUD:GetPlayerController()
        if r135_0 then
            if r135_0.UID then
                r134_0 = tostring(r135_0.UID)
            end
            if (not r134_0 or r134_0 == "" or r134_0 == "0")
                and r135_0.PlayerState
                and r135_0.PlayerState.UID then
                r134_0 = tostring(r135_0.PlayerState.UID)
            end
        end
    end)
    r134_0 = (r134_0 ~= "" or nil) and (r134_0 ~= "0" or nil) and r134_0
    return r134_0
end

-- line 1138-1152
-- proto#136 params=0 locals=1 upvalues=2 vararg=false
local function r0_63()
    local r136_0 = nil
    pcall(function()
        local r137_0 = io.open(r0_60.UID_FILE, "r")
        if r137_0 then
            local r137_1 = r137_0:read("*all")
            r136_0 = r137_1
            local r137_2 = r137_0
            r137_1 = r137_2.close
            r137_1(r137_2)
        end
        if r136_0 then
            r136_0 = r136_0:gsub("%s+", "")
        end
        if not r136_0 or r136_0 == "" then
            local r137_3 = tostring(math.random(100000, 999999))
            local r137_4 = tostring(os.time())
            r136_0 = "ZN-" .. r137_3 .. r137_4
            local r137_5 = io.open
            r137_3 = r0_60.UID_FILE
            r137_4 = "w"
            local r137_6 = r137_5(r137_3, r137_4)
            if r137_6 then
                r137_6:write(r136_0)
                r137_6:close()
            end
        end
        if r136_0 == "" then
            r136_0 = nil
        end
    end)
    return r136_0
end

-- line 1154-1159
-- proto#138 params=0 locals=1 upvalues=3 vararg=false
local function r0_64()
    local r138_0 = r0_61()
    r138_0 = r138_0 or r0_62()
    return r138_0 or r0_63()
end

-- line 1161-1170
-- proto#139 params=0 locals=1 upvalues=2 vararg=false
local function r0_65()
    local r139_0 = nil
    pcall(function()
        local r140_0 = io.open(r0_60.KEY_FILE, "r")
        if r140_0 then
            local r140_1 = r140_0:read("*all")
            r139_0 = r140_1
            local r140_2 = r140_0
            r140_1 = r140_2.close
            r140_1(r140_2)
        end
        if r139_0 then
            r139_0 = r139_0:gsub("%s+", "")
        end
        if r139_0 == "" then
            r139_0 = nil
        end
    end)
    return r139_0
end

-- line 1172-1178
-- proto#141 params=1 locals=0 upvalues=2 vararg=false
local function r0_66(p141_0)
    _G._LICENSE_KEY = p141_0
    pcall(function()
        local r142_0 = io.open(r0_60.KEY_FILE, "w")
        if r142_0 then
            r142_0:write(p141_0)
            r142_0:close()
        end
    end)
end

-- line 1180-1183
-- proto#143 params=0 locals=0 upvalues=2 vararg=false
local function r0_67()
    if _G._LICENSE_KEY and _G._LICENSE_KEY ~= "" then
        return _G._LICENSE_KEY
    end
    return r0_65()
end

-- line 1185-1192
-- proto#144 params=1 locals=0 upvalues=0 vararg=false
local function r0_68(p144_0)
    if p144_0 then
        if p144_0 == "USER BLOCKED" then
            return "blocked"
        end
        if p144_0 == "EXPIRED KEY" then
            return "expired"
        end
        if p144_0 == "MAX DEVICE REACHED" then
            return "device_limit"
        end
        if p144_0 == "USER OR GAME NOT REGISTERED" then
            return "invalid"
        end
        return "nonet"
    end
    return "nonet"
end

-- line 1194-1222
-- proto#145 params=3 locals=5 upvalues=3 vararg=false
local function r0_69(p145_0, p145_1, p145_2)
    local r145_0 = nil
    pcall(function()
        local r146_0 = ModuleManager.GetModule
        local r146_1 = ModuleManager.CommonModuleConfig
        r145_0 = r146_0(r146_1.http_manager)
    end)
    if r145_0 and r145_0.Post then
        local r145_1 = { ["Content-Type"] = "application/x-www-form-urlencoded" }
        local r145_2 = "game=" .. r0_60.GAME_NAME .. "&user_key=" .. p145_0 .. "&serial=" .. p145_1
        r145_0:Post(r0_60.LOGIN_URL, r145_1, r145_2, nil, function(p147_0, p147_1)
            if p147_0 and p147_1 then
                if p147_1:find('"status"%s*:%s*true') and p147_1:find('"data"%s*:') then
                    p145_2(true)
                    return
                end
                local r147_0 = nil
                pcall(function()
                    if p147_1 then
                        r147_0 = p147_1:match('"reason"%s*:%s*"([^"]+)"')
                    end
                end)
                p145_2(false, r0_68(r147_0), nil)
            else
                r147_0 = p145_2
                r147_0(false, "nonet", nil)
            end
        end, 15)
        return
    end
    p145_2(false, "nonet", nil)
end

-- line 1224-1233
-- proto#149 params=2 locals=0 upvalues=2 vararg=false
local function r0_70(p149_0, p149_1)
    pcall(function()
        if not (p149_0 and p149_1) then
            return
        end
        local r150_0 = ModuleManager.GetModule(ModuleManager.CommonModuleConfig.http_manager)
        if not (r150_0 and r150_0.Post) then
            return
        end
        local r150_1 = { ["Content-Type"] = "application/x-www-form-urlencoded" }
        local r150_2 = "user_key=" .. p149_0 .. "&serial=" .. p149_1
        r150_0:Post(r0_60.HEARTBEAT_URL, r150_1, r150_2, nil, function(p151_0, p151_1)

        end, 10)
    end)
end

-- line 1235-1240
-- proto#152 params=2 locals=0 upvalues=1 vararg=false
local function r0_71(p152_0, p152_1)
    pcall(function()
        local r153_0 = require("client.slua.logic.common.logic_common_msg_box")
        if r153_0 and r153_0.Show then
            r153_0.Show(4, p152_0, p152_1)
        end
    end)
end

-- line 1242-1247
-- proto#154 params=0 locals=0 upvalues=2 vararg=false
local function r0_72()
    pcall(function()
        local r155_0 = import("KismetSystemLibrary")
        if r155_0 and r155_0.LaunchURL then
            r155_0.LaunchURL(r0_60.TELEGRAM_URL)
        end
    end)
end

local r0_73 = {}

-- line 1259-1273
-- proto#156 params=0 locals=1 upvalues=1 vararg=false
local function r0_74()
    local r156_0 = nil
    pcall(function()
        local r157_0 = require("GameLua.Mod.BaseMod.Common.UI.InGameUITools").GetMainControlBaseUI()
        if r157_0 and slua.isValid(r157_0) then
            r156_0 = r157_0.CanvasPanel_0
            if not r156_0 or not slua.isValid(r156_0) then
                r156_0 = nil
            end
            if not r156_0 and r157_0.CanvasPanel_42 and slua.isValid(r157_0.CanvasPanel_42) then
                r156_0 = r157_0.CanvasPanel_42
            end
        end
    end)
    return r156_0
end

-- line 1275-1295
-- proto#158 params=6 locals=3 upvalues=3 vararg=false
local function r0_75(p158_0, p158_1, p158_2, p158_3, p158_4, p158_5)
    local r158_0 = CGame:NewObjectFromPath("/Script/UMG.TextBlock", p158_0)
    if r158_0 and slua.isValid(r158_0) then
        pcall(function()
            r158_0:SetText(tostring(p158_1))
            if r0_59 then
                r158_0:SetColorAndOpacity(r0_59(p158_3))
            else
                r158_0:SetColorAndOpacity(p158_3)
            end
            if r158_0.Font then
                local r159_0 = r158_0.Font
                r159_0.Size = p158_2
                r158_0.Font = r159_0
            end
            r158_0:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
        end)
        local r158_1 = p158_0:AddChildToCanvas(r158_0)
        if r158_1 then
            pcall(function()
                r158_1:SetAutoSize(true)
                r158_1:SetAlignment(r0_57(0.5, 0.5))
                r158_1:SetPosition(r0_57(p158_4, p158_5))
                r158_1:SetZOrder(9999)
            end)
        end
    end
    return r158_0
end

-- line 1297-1315
-- proto#161 params=7 locals=3 upvalues=2 vararg=false
local function r0_76(p161_0, p161_1, p161_2, p161_3, p161_4, p161_5, p161_6)
    local r161_0 = CGame:NewObjectFromPath("/Script/UMG.Border", p161_0)
    if r161_0 and slua.isValid(r161_0) then
        pcall(function()
            r161_0:SetBrushColor(p161_1)
            r161_0:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
        end)
        local r161_1 = p161_0:AddChildToCanvas(r161_0)
        if r161_1 then
            pcall(function()
                r161_1:SetAlignment(r0_57(0.5, 0.5))
                r161_1:SetPosition(r0_57(p161_2, p161_3))
                r161_1:SetSize(r0_57(p161_4, p161_5))
                r161_1:SetZOrder(p161_6 or 9999)
            end)
        end
    end
    return r161_0
end

-- line 1317-1351
-- proto#164 params=10 locals=6 upvalues=4 vararg=false
local function r0_77(p164_0, p164_1, p164_2, p164_3, p164_4, p164_5, p164_6, p164_7, p164_8, p164_9)
    local r164_0 = CGame:NewObjectFromPath("/Script/UMG.Button", p164_0)
    if r164_0 and slua.isValid(r164_0) then
        local r164_1 = p164_0:AddChildToCanvas(r164_0)
        if r164_1 then
            pcall(function()
                r164_1:SetAlignment(r0_57(0.5, 0.5))
                r164_1:SetPosition(r0_57(p164_1, p164_2))
                r164_1:SetSize(r0_57(p164_3, p164_4))
                r164_1:SetZOrder(9999)
            end)
        end
        local r164_2 = CGame:NewObjectFromPath("/Script/UMG.TextBlock", r164_0)
        if r164_2 and slua.isValid(r164_2) then
            pcall(function()
                r164_2:SetText(p164_5)
                local r166_0 = r0_58(p164_6, p164_7, p164_8, 1)
                if r0_59 then
                    r164_2:SetColorAndOpacity(r0_59(r166_0))
                else
                    r164_2:SetColorAndOpacity(r166_0)
                end
                if r164_2.Font then
                    local r166_1 = r164_2.Font
                    r166_1.Size = 24
                    r164_2.Font = r166_1
                end
                r164_2:SetWidgetVisibility(UEnums.ESlateVisibility.HitTestInvisible)
                pcall(function()
                    r164_0:AddChild(r164_2)
                end)
            end)
        end
        pcall(function()
            if r164_0.OnClicked and r164_0.OnClicked.Add then
                r164_0.OnClicked:Add(function()
                    p164_9()
                end)
            end
        end)
        pcall(function()
            if slua.addDelegate then
                slua.addDelegate(r164_0.OnClicked, function()
                    p164_9()
                end)
            end
        end)
        return r164_0
    end
    return nil
end

-- line 1353-1369
-- proto#172 params=5 locals=4 upvalues=2 vararg=false
local function r0_78(p172_0, p172_1, p172_2, p172_3, p172_4)
    local r172_0 = CGame:NewObjectFromPath("/Script/UMG.EditableTextBox", p172_0)
    if r172_0 and slua.isValid(r172_0) then
        local r172_1 = p172_0:AddChildToCanvas(r172_0)
        if r172_1 then
            pcall(function()
                r172_1:SetAlignment(r0_57(0.5, 0.5))
                r172_1:SetPosition(r0_57(p172_1, p172_2))
                r172_1:SetSize(r0_57(p172_3, p172_4))
                r172_1:SetZOrder(9999)
            end)
        end
        pcall(function()
            if r172_0.SetHintText then
                r172_0:SetHintText("Enter your key here")
            end
        end)
        return r172_0
    end
    return nil
end

-- line 1371-1384
-- proto#175 params=1 locals=1 upvalues=1 vararg=false
local function r0_79(p175_0)
    local r175_0 = nil
    pcall(function()
        repeat
            local r176_0
            if not p175_0 then
                break
            end
            do
                if not slua.isValid(p175_0) then
                    break
                end
                if not p175_0.GetText then
                    break
                end
                r176_0 = p175_0:GetText()
                if type(r176_0) == "string" then
                    r175_0 = r176_0
                    break
                end
                if not (not r176_0 or not r176_0.ToString) then
                    r175_0 = r176_0:ToString()
                    break
                end
            end
            r175_0 = tostring(r176_0)
        until true
    end)
    r175_0 = r175_0 and tostring(r175_0):gsub("[^A-Za-z0-9%-_]", "")
    r175_0 = r175_0 and (r175_0 ~= "" or nil) and r175_0 or nil
    return r175_0
end

-- line 1386-1397
-- proto#177 params=2 locals=0 upvalues=3 vararg=false
local function r0_80(p177_0, p177_1)
    pcall(function()
        if _G._LICENSE_STATUS_WIDGET and slua.isValid(_G._LICENSE_STATUS_WIDGET) then
            _G._LICENSE_STATUS_WIDGET:SetText(tostring(p177_0))
            pcall(function()
                local r179_0 = p177_1 and r0_58(1.0, 0.3, 0.3, 1.0) or r0_58(0.4, 0.8, 1.0, 1.0)
                if r0_59 then
                    _G._LICENSE_STATUS_WIDGET:SetColorAndOpacity(r0_59(r179_0))
                else
                    _G._LICENSE_STATUS_WIDGET:SetColorAndOpacity(r179_0)
                end
            end)
        end
    end)
end

-- line 1399-1412
-- proto#180 params=0 locals=0 upvalues=1 vararg=false
local function r0_81()
    pcall(function()
        if _G._LICENSE_UI and slua.isValid(_G._LICENSE_UI) then
            _G._LICENSE_UI:RemoveFromParent()
            if _G._LICENSE_UI.ConditionalBeginDestroy then
                _G._LICENSE_UI:ConditionalBeginDestroy()
            end
        end
    end)
    _G._LICENSE_UI = nil
    _G._LICENSE_DIM = nil
    _G._LICENSE_BOX = nil
    _G._LICENSE_BTN = nil
    _G._LICENSE_GETKEY = nil
    _G._LICENSE_STATUS_WIDGET = nil
end

-- line 1417-1484
-- proto#182 params=0 locals=0 upvalues=6 vararg=false
local function r0_82()
    pcall(function()
        local r183_0 = r0_74()
        if not r183_0 then
            return
        end
        local r183_1, r183_2 = 1920, 1080
        pcall(function()
            local r184_0 = require("client.common.ui_util")
            if r184_0 and r184_0.GetViewportSize then
                local r184_1 = r184_0.GetViewportSize()
                if r184_1 and r184_1.X and r184_1.X > 0 then
                    local r184_2 = r184_1.X
                    r183_2 = r184_1.Y
                    r183_1 = r184_2
                end
            end
        end)
        local r183_3 = r183_1 * 0.5
        local r183_4 = r183_2 * 0.5
        local r183_5 = math.min(r183_1 * 0.34, 700)
        r183_5 = r183_5 < 500 and 500 or r183_5
        local r183_6 = r183_5 * 0.55
        local r183_7 = r183_5 / 740
        local r183_8 = CGame:NewObjectFromPath("/Script/UMG.CanvasPanel", r183_0)
        if not (r183_8 and slua.isValid(r183_8)) then
            return
        end
        local r183_9 = r183_0:AddChildToCanvas(r183_8)
        if r183_9 then
            pcall(function()
                r183_9:SetPosition(r0_57(0, 0))
                r183_9:SetSize(r0_57(r183_1, r183_2))
                r183_9:SetZOrder(9995)
            end)
        end
        local r183_10 = r0_58(0.2, 1.0, 0.4, 1.0)
        local r183_11 = r0_58(0.6, 1.0, 0.75, 1.0)
        local r183_12 = r0_58(0.03, 0.15, 0.06, 0.96)
        local r183_13 = r0_58(0.01, 0.08, 0.03, 0.98)
        local r183_14 = r0_76
        local r183_15 = r0_58(0, 0, 0, 0.6)
        r183_14(r183_8, r183_15, r183_3, r183_4, r183_1 + 300, r183_2 + 300, 9996)
        local r183_16 = r0_76
        r183_15 = r183_12
        r183_16(r183_8, r183_15, r183_3, r183_4, r183_5, r183_6, 9997)
        r0_76(r183_8, r183_13, r183_3, r183_4, r183_5 - 10, r183_6 - 10, 9998)
        r0_76(r183_8, r183_10, r183_3, r183_4 - r183_6 * 0.5 + 3, r183_5, 4, 9999)
        r0_76(r183_8, r183_10, r183_3, r183_4 + r183_6 * 0.5 - 3, r183_5, 4, 9999)
        local r183_17 = r0_75
        local r183_18 = math.floor(26 * r183_7)
        r183_17(r183_8, "WELCOME TO", r183_18, r183_11, r183_3, r183_4 - r183_6 * 0.36)
        local r183_19 = r0_75
        r183_18 = math
        local r183_20 = r183_18.floor(48 * r183_7)
        r183_19(r183_8, "HUSSNAINXPUBG MOD", r183_20, r183_10, r183_3, r183_4 - r183_6 * 0.22)
        local r183_21 = r0_75
        r183_20 = math
        local r183_22 = r183_20.floor(18 * r183_7)
        r183_21(r183_8, "ANYONE FACE ISSUE TEXT DM", r183_22, r183_11, r183_3, r183_4 - r183_6 * 0.05)
        local r183_23 = r0_75
        r183_22 = math
        local r183_24 = r183_22.floor(24 * r183_7)
        r183_23(r183_8, "HUSSNAINxPUBG", r183_24, r183_10, r183_3, r183_4 + r183_6 * 0.06)
        local r183_25 = r0_75
        r183_24 = math
        local r183_26 = r183_24.floor(19 * r183_7)
        r183_25(r183_8, "Whatsapp: 03147396648", r183_26, r183_11, r183_3, r183_4 + r183_6 * 0.18)
        local r183_27 = r0_75
        r183_26 = math
        r183_27(r183_8, "Telegram: @HUSSNAINxPUBG", r183_26.floor(19 * r183_7), r183_11, r183_3, r183_4 + r183_6 * 0.29)
        _G._WELCOME_UI = r183_8
        pcall(function()
            local r186_0 = require("common.time_ticker")
            if r186_0 and r186_0.AddTimerOnce then
                r186_0.AddTimerOnce(6.0, function()
                    pcall(function()
                        if _G._WELCOME_UI and slua.isValid(_G._WELCOME_UI) then
                            _G._WELCOME_UI:RemoveFromParent()
                            if _G._WELCOME_UI.ConditionalBeginDestroy then
                                _G._WELCOME_UI:ConditionalBeginDestroy()
                            end
                        end
                    end)
                    _G._WELCOME_UI = nil
                end)
            end
        end)
    end)
end

-- line 1489-1653
-- proto#189 params=3 locals=1 upvalues=20 vararg=false
r0_73.Build = function(p189_0, p189_1, p189_2)
    r0_81()
    local r189_0 = false
    pcall(function()
        local r190_0 = r0_74()
        if not r190_0 then
            return
        end
        local r190_1, r190_2 = 1920, 1080
        pcall(function()
            local r191_0 = require("client.common.ui_util")
            if r191_0 and r191_0.GetViewportSize then
                local r191_1 = r191_0.GetViewportSize()
                if r191_1 and r191_1.X and r191_1.X > 0 then
                    local r191_2 = r191_1.X
                    r190_2 = r191_1.Y
                    r190_1 = r191_2
                end
            end
        end)
        local r190_3 = r190_1 * 0.5
        local r190_4 = r190_2 * 0.5
        local r190_5 = math.min(r190_1 * 0.28, 550)
        r190_5 = r190_5 < 420 and 420 or r190_5
        local r190_6 = r190_5 * 0.7027027027027027
        local r190_7 = r190_5 / 740
        local r190_8 = CGame:NewObjectFromPath("/Script/UMG.CanvasPanel", r190_0)
        if not (r190_8 and slua.isValid(r190_8)) then
            return
        end
        do
            local r190_9 = r190_0:AddChildToCanvas(r190_8)
            if r190_9 then
                pcall(function()
                    r190_9:SetPosition(r0_57(0, 0))
                    r190_9:SetSize(r0_57(r190_1, r190_2))
                    r190_9:SetZOrder(9989)
                end)
            end
            local r190_10 = r0_58(0.2, 0.6, 1.0, 1.0)
            local r190_11 = r0_58(0.4, 0.8, 1.0, 1.0)
            local r190_12 = r0_58(0.03, 0.06, 0.15, 0.96)
            local r190_13 = r0_58(0.01, 0.03, 0.08, 0.98)
            local r190_14 = r0_76
            local r190_15 = r0_58(0, 0, 0, 0.65)
            local r190_16 = r190_14(r190_8, r190_15, r190_3, r190_4, r190_1 + 300, r190_2 + 300, 9990)
            local r190_17 = r0_76
            r190_15 = r190_8
            r190_17(r190_15, r190_12, r190_3, r190_4, r190_5, r190_6, 9991)
            r0_76(r190_8, r190_13, r190_3, r190_4, r190_5 - 10, r190_6 - 10, 9992)
            r0_76(r190_8, r190_10, r190_3, r190_4 - r190_6 * 0.5 + 3, r190_5, 4, 9993)
            r0_76(r190_8, r190_10, r190_3, r190_4 + r190_6 * 0.5 - 3, r190_5, 4, 9993)
            r0_76(r190_8, r190_10, r190_3 - r190_5 * 0.5 + 2, r190_4, 4, r190_6, 9993)
            r0_76(r190_8, r190_10, r190_3 + r190_5 * 0.5 - 2, r190_4, 4, r190_6, 9993)
            local r190_18 = r0_75
            local r190_19 = r0_60.BRAND_NAME
            local r190_20 = math.floor(46 * r190_7)
            r190_18(r190_8, r190_19, r190_20, r190_10, r190_3, r190_4 - r190_6 * 0.356)
            local r190_21 = r0_75
            local r190_22 = r0_60.BRAND_SUB
            r190_20 = math
            local r190_23 = r190_20.floor(15 * r190_7)
            local r190_24 = r0_58(0.6, 0.75, 0.9, 1.0)
            r190_21(r190_8, r190_22, r190_23, r190_24, r190_3, r190_4 - r190_6 * 0.275)
            local r190_25 = r0_78
            r190_23 = r190_6 * 0.119
            local r190_26 = r190_4 - r190_23
            r190_24 = r190_5 * 0.865
            local r190_27 = r190_25(r190_8, r190_3, r190_26, r190_24, 54 * r190_7)
            _G._LICENSE_BOX = r190_27
            local r190_28 = p189_1 or "Type key, then press LOGIN"
            local r190_29 = p189_1 and r0_58(1.0, 0.3, 0.3, 1.0) or r190_11
            local r190_30 = _G
            local r190_31 = r0_75
            local r190_32 = math.floor(19 * r190_7)
            local r190_33 = r190_31(r190_8, r190_28, r190_32, r190_29, r190_3, r190_4 - r190_6 * 0.015)
            r190_30._LICENSE_STATUS_WIDGET = r190_33
            local r190_34 = r190_5 * 0.36
            r190_33 = 60 * r190_7
            local r190_35 = r190_5 * 0.05
            r190_32 = (r190_34 * 2 + r190_35) / 2
            local r190_36 = r190_3 - r190_32 + r190_34 / 2
            local r190_37 = _G
            local r190_38 = r0_77(r190_8, r190_36, r190_4 + r190_6 * 0.1, r190_34, r190_33, "GET KEY", 1.0, 0.75, 0.2, function()
                r0_80("Opening Telegram...", false)
                r0_72()
            end)
            r190_37._LICENSE_GETKEY = r190_38
            local r190_39 = _G
            r190_38 = r0_77
            local r190_40 = r190_36 + r190_34 + r190_35
            local r190_41 = r190_4 + r190_6 * 0.1

            -- line 1560-1643
            -- proto#194 params=0 locals=7 upvalues=13 vararg=false
            local function r190_42()
                local r194_0 = r0_79(_G._LICENSE_BOX)
                if r194_0 and not (#r194_0 < 4) then
                    if _G._LOGIN_TRYING then
                        return
                    end
                    do
                        _G._LOGIN_TRYING = true
                        r0_80("Checking...", false)
                        local r194_1 = r0_64()
                        local r194_2 = r0_69
                        local r194_3 = r194_0
                        local r194_4 = r194_1

                        -- line 1571-1642
                        -- proto#195 params=3 locals=0 upvalues=14 vararg=false
                        local function r194_5(p195_0, p195_1, p195_2)
                            _G._LOGIN_TRYING = false
                            if p195_0 then
                                r0_66(r194_0)
                                _G._LICENSE_OK = true
                                _G._LICENSE_UID = r194_1
                                _G._MOD_EXPIRED = false
                                r0_80("Activated! All Features ON", false)
                                r0_81()
                                r0_82()
                                pcall(function()
                                    if _G.StartBypass_VIP_v3 then
                                        _G.StartBypass_VIP_v3()
                                    end
                                end)
                                pcall(function()
                                    if _G.InitializeAutoHeadHooks then
                                        _G.InitializeAutoHeadHooks()
                                    end
                                end)
                                pcall(function()
                                    if _G.InitModMenuTab then
                                        _G.InitModMenuTab()
                                    end
                                end)
                                if p189_0 and p189_0.AddGameTimer then
                                    pcall(function()
                                        local r199_0, r199_1 = _G, p189_0
                                        local r199_2 = r199_1.AddGameTimer

                                        -- line 1600-1621
                                        -- proto#200 params=0 locals=2 upvalues=6 vararg=false
                                        local function r199_3()
                                            if not slua.isValid(p189_0.Object) then
                                                return
                                            end
                                            if not _G._LICENSE_OK then
                                                return
                                            end
                                            local r200_0 = r0_67()
                                            local r200_1 = _G._LICENSE_UID or r0_64()
                                            if not (r200_0 and r200_1) then
                                                return
                                            end
                                            r0_69(r200_0, r200_1, function(p201_0, p201_1)
                                                if not p201_0 and p201_1 ~= "nonet" then
                                                    _G._LICENSE_OK = false
                                                    _G._MOD_EXPIRED = true
                                                    if p201_1 == "expired" then
                                                        r0_71("LICENSE EXPIRED", "Aapki key expire ho gayi hai.")
                                                    elseif p201_1 == "blocked" then
                                                        r0_71("LICENSE BLOCKED", "Aapki key admin ne block kar di hai.")
                                                    elseif p201_1 == "device_limit" then
                                                        r0_71("DEVICE LIMIT", "Aapki key dusre device par use ho rahi hai.")
                                                    else
                                                        r0_71("LICENSE REVOKED", "License valid nahi hai.")
                                                    end
                                                end
                                            end)
                                        end

                                        local r199_4 = r199_2(r199_1, 180, true, r199_3)
                                        r199_0._PERIODIC_TIMER = r199_4
                                    end)
                                    pcall(function()
                                        local r202_0 = _G
                                        local r202_1 = p189_0:AddGameTimer(5, true, function()
                                            if not slua.isValid(p189_0.Object) then
                                                return
                                            end
                                            if not _G._LICENSE_OK then
                                                return
                                            end
                                            local r203_0 = r0_67()
                                            local r203_1 = _G._LICENSE_UID or r0_64()
                                            r0_70(r203_0, r203_1)
                                        end)
                                        r202_0._HEARTBEAT_TIMER = r202_1
                                    end)
                                end
                                if p189_2 then
                                    p189_2()
                                end
                            elseif p195_1 == "invalid" then
                                r0_80("Galat key - dobara likho", true)
                            elseif p195_1 == "blocked" then
                                r0_80("Key blocked hai", true)
                            elseif p195_1 == "expired" then
                                r0_80("Key expire ho gayi", true)
                            elseif p195_1 == "device_limit" then
                                r0_80("Dusre device par lock hai", true)
                            else
                                r0_80("Net error - fir se try karo", true)
                            end
                        end

                        r194_2(r194_3, r194_4, r194_5)
                        return
                    end
                end
                local r194_6 = r0_80
                r194_6("Pehle key likho", true)
            end

            local r190_43 = r190_38(r190_8, r190_40, r190_41, r190_34, r190_33, "LOGIN", 0.2, 0.9, 0.4, r190_42)
            r190_39._LICENSE_BTN = r190_43
            local r190_44 = r0_75
            r190_43 = r190_8
            local r190_45 = r0_60.SUPPORT_TEXT
            r190_44(r190_43, r190_45, math.floor(14 * r190_7), r190_11, r190_3, r190_4 + r190_6 * 0.323)
            _G._LICENSE_UI = r190_8
            _G._LICENSE_DIM = r190_16
            r189_0 = true
            return
        end
    end)
    return r189_0
end

-- line 1655-1673
-- proto#204 params=2 locals=0 upvalues=2 vararg=false
function r0_73.Start(p204_0, p204_1)
    if _G._LICENSE_OK then
        if p204_1 then
            p204_1()
        end
        return
    end
    local r204_0
    r204_0 = function()
        if _G._LICENSE_OK then
            return
        end
        if not r0_73.Build(p204_0, nil, p204_1) and p204_0 and p204_0.AddGameTimer then
            _G._LICENSE_CHAR = p204_0
            local r205_0 = _G
            local r205_1 = p204_0:AddGameTimer(1.0, false, r204_0)
            r205_0._LICENSE_TIMER = r205_1
        end
    end
    r204_0()
end

local r0_83 = _G
local r0_84 = {}
r0_84.Start = r0_73.Start
r0_84.Build = r0_73.Build
r0_84.CheckLicense = r0_69
r0_84.GetSerial = r0_64
r0_84.GetCurrentKey = r0_67
r0_84.SaveKey = r0_66
r0_84.Config = r0_60
r0_84.ShowWelcome = r0_82
r0_83.LicenseSystem = r0_84
print("[HUSSNAINxPUBG] LicenseSystem Ready")

-- line 1696-1706
-- proto#206 params=6 locals=1 upvalues=1 vararg=false
local function r0_85(p206_0, p206_1, p206_2, p206_3, p206_4, p206_5)
    local r206_0 = nil
    pcall(function()
        local r207_0 = require("GameLua.Mod.BaseMod.Common.InGameMarkTools")
        if r207_0 and r207_0.ClientAddMapMark then
            local r207_1 = r207_0.ClientAddMapMark(p206_0, p206_1, p206_2, p206_3, p206_4, p206_5)
            r206_0 = r207_1
            r207_1 = r206_0
            if r207_1 then
                local r207_2 = _G.LexusState
                r207_2.TrackedMarks[r206_0] = true
            end
        end
    end)
    return r206_0
end

r0_84 = function(p208_0)
    if not p208_0 then
        return
    end
    pcall(function()
        local r209_0 = require("GameLua.Mod.BaseMod.Common.InGameMarkTools")
        if r209_0 and r209_0.HideMapMark then
            r209_0.HideMapMark(p208_0)
        end
        if r209_0 and r209_0.RemoveMapMark then
            r209_0.RemoveMapMark(p208_0)
        end
    end)
    local r208_0 = _G.LexusState
    r208_0.TrackedMarks[p208_0] = nil
end

-- line 1718-1724
-- proto#210 params=1 locals=3 upvalues=2 vararg=false
local function r0_86(p210_0)
    if r0_11(p210_0) then
        if p210_0.PlayerKey then
            return tostring(p210_0.PlayerKey)
        end
        if type(p210_0.GetUniqueID) == "function" then
            local r210_0, r210_1 = tostring, p210_0
            return r210_0(r210_1.GetUniqueID(r210_1))
        end
    end
    return tostring(p210_0)
end

-- line 1726-1749
-- proto#211 params=2 locals=2 upvalues=2 vararg=false
local function r0_87(p211_0, p211_1)
    if p211_1.AK_IS_BOT == nil then
        local r211_0, r211_1 = false, false
        pcall(function()
            if p211_0.bIsAI == true or p211_0.IsAI == true then
                r211_0 = true
                r211_1 = true
            end
            if type(p211_0.IsBot) == "function" and p211_0:IsBot() then
                r211_0 = true
                r211_1 = true
            end
            local r212_0 = p211_0.PlayerState
            local r212_1
            if r212_0 then
                r212_1 = r212_0
            elseif type(p211_0.GetPlayerState) == "function" then
                r212_1 = p211_0:GetPlayerState()
            else
                r212_1 = false
            end
            if r0_11(r212_1) then
                r211_1 = true
                if r212_1.bIsABot == true or r212_1.bIsBot == true then
                    r211_0 = true
                end
                if type(r212_1.IsBot) == "function" and r212_1:IsBot() then
                    r211_0 = true
                end
            end
            if r211_0 then
                return
            end
            local r212_2 = p211_0.PlayerName
                or type(p211_0.GetPlayerName) == "function" and p211_0:GetPlayerName()
                or ""
            if r212_2 == "" then
                return
            end
            if not r212_2:find("Cobra")
                and not r212_2:find("Target")
                and not r212_2:find("bot_")
                and not r212_2:find("b_") then
                return
            end
            r211_0 = true
            r211_1 = true
        end)
        if r211_1 then
            p211_1.AK_IS_BOT = r211_0
        end
        return r211_0, r211_1
    end
    return p211_1.AK_IS_BOT, true
end

-- line 1754-1778
-- proto#213 params=0 locals=0 upvalues=1 vararg=false
function _G.InitializeAutoHeadHooks()
    pcall(function()
        local r214_0 = import("EAvatarDamagePosition")
        if not r214_0 then
            return
        end
        local r214_1 = {
            "GameLua.Mod.BaseMod.Common.Weapon.ShootWeaponEntity",
            "GameLua.Logic.Weapon.ShootWeaponEntity"
        }
        for r214_2, r214_3 in ipairs(r214_1) do
            local r214_4 = package.loaded[r214_3]
            if r214_4 then
                local r214_5 = r214_4.GetHitBodyType

                -- line 1766-1769
                -- proto#215 params=3 locals=0 upvalues=3 vararg=false
                r214_4.GetHitBodyType = function(p215_0, p215_1, p215_2)
                    if _G.LexusConfig.AutoHead then
                        return r214_0.BigHead
                    end
                    if not r214_5 then
                        return
                    end
                    return r214_5(p215_0, p215_1, p215_2)
                end

                local r214_6 = r214_4.GetHitBodyTypeByHitPos

                -- line 1771-1774
                -- proto#216 params=2 locals=0 upvalues=3 vararg=false
                r214_4.GetHitBodyTypeByHitPos = function(p216_0, p216_1)
                    if _G.LexusConfig.AutoHead then
                        return r214_0.BigHead
                    end
                    if not r214_6 then
                        return
                    end
                    return r214_6(p216_0, p216_1)
                end
            end
        end
    end)
end

_G.LostTomb_IgnoreFallingDamageMarkMap = {}

-- line 1785-1812
-- proto#217 params=3 locals=5 upvalues=3 vararg=false
function _G.LostTomb_MarkIgnoreFallingDamage(p217_0, p217_1, p217_2)
    if not _G.LexusConfig.IgnoreFallingDamage then
        return
    end
    local r217_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r217_0) then
        return
    end
    if p217_1 then
        _G.LostTomb_IgnoreFallingDamageMarkMap[p217_0] = nil
    else
        local r217_1 = os.time()
        _G.LostTomb_IgnoreFallingDamageMarkMap[p217_0] = r217_1 + p217_2
    end
    local r217_2 = os.time()
    for r217_3, r217_4 in pairs(_G.LostTomb_IgnoreFallingDamageMarkMap) do
        if r217_4 < r217_2 then
            _G.LostTomb_IgnoreFallingDamageMarkMap[r217_3] = nil
        end
    end
    pcall(function()
        if type(r217_0.CheckIgnoreFallingDamage) == "function" then
            local r218_0 = false
            for r218_1, r218_2 in pairs(_G.LostTomb_IgnoreFallingDamageMarkMap) do
                if r217_2 <= r218_2 then
                    r218_0 = true
                    break
                end
            end
            if r218_0 then
                r217_0:SetAttrValue("LandDamageReduce", 1, -1)
            else
                r217_0:SetAttrValue("LandDamageReduce", 0, -1)
            end
        end
    end)
end

-- line 1814-1821
-- proto#219 params=0 locals=1 upvalues=3 vararg=false
function _G.LostTomb_ShowHeadHPBar()
    if not _G.LexusConfig.ShowHeadHPBar then
        return
    end
    local r219_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r219_0) then
        return
    end
    if r0_11(r219_0.HeadHPBar) and type(r219_0.HeadHPBar.CreateSceneMark) == "function" then
        r219_0.HeadHPBar:CreateSceneMark()
    end
end

-- line 1823-1829
-- proto#220 params=0 locals=3 upvalues=3 vararg=false
function _G.LostTomb_GetCustomGender()
    if not _G.LexusConfig.EnableCustomGender then
        return
    end
    local r220_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r220_0) then
        return
    end
    if type(r220_0.GetCustomGender) == "function" then
        return r220_0:GetCustomGender()
    end
    return 0
end

-- line 1831-1839
-- proto#221 params=1 locals=1 upvalues=3 vararg=false
function _G.LostTomb_SetCloseCharacterOverrideAvatar(p221_0)
    if not _G.LexusConfig.EnableLoadingAvatar then
        return
    end
    local r221_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r221_0) then
        return
    end
    if type(r221_0.SetCloseCharacterOverrideAvatar) == "function" then
        r221_0:SetCloseCharacterOverrideAvatar(p221_0)
        _G.LexusState.IsCloseCharacterOverrideAvatar = p221_0
    end
end

-- line 1841-1848
-- proto#222 params=1 locals=1 upvalues=3 vararg=false
function _G.LostTomb_ShowSupplyBoxEvolution(p222_0)
    if not _G.LexusConfig.EnableSupplyBoxEvolution then
        return
    end
    local r222_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r222_0) then
        return
    end
    if type(r222_0.SetSupplyBoxEvolutionShow) == "function" then
        r222_0:SetSupplyBoxEvolutionShow(p222_0)
    end
end

-- line 1850-1857
-- proto#223 params=1 locals=1 upvalues=3 vararg=false
function _G.LostTomb_AddMaxWalkSpeedCurve(p223_0)
    if not _G.LexusConfig.EnableMaxWalkSpeedCurve then
        return
    end
    local r223_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r223_0) then
        return
    end
    if type(r223_0.AddMaxWalkSpeedCurve) == "function" then
        r223_0:AddMaxWalkSpeedCurve(p223_0)
    end
end

-- line 1859-1866
-- proto#224 params=1 locals=1 upvalues=3 vararg=false
function _G.LostTomb_RemoveMaxWalkSpeedCurve(p224_0)
    if not _G.LexusConfig.EnableMaxWalkSpeedCurve then
        return
    end
    local r224_0 = r0_7.GetPlayerCharacter()
    if not r0_11(r224_0) then
        return
    end
    if type(r224_0.RemoveMaxWalkSpeedCurve) == "function" then
        r224_0:RemoveMaxWalkSpeedCurve(p224_0)
    end
end

-- line 1868-1880
-- proto#225 params=1 locals=3 upvalues=3 vararg=false
function _G.LostTomb_UpdateStealLifeCount(p225_0)
    if not _G.LexusConfig.EnableStealLifeEffect then
        return
    end
    _G.LexusState.StealLifeCount = (_G.LexusState.StealLifeCount or 0) + p225_0
    local r225_0 = r0_7.GetPlayerCharacter()
    if r0_11(r225_0) and r225_0.StealLifeCount ~= nil then
        r225_0.StealLifeCount = _G.LexusState.StealLifeCount
        if type(r225_0.OnRep_StealLifeCount) == "function" then
            r225_0:OnRep_StealLifeCount()
        end
    end
end

local r0_88 = {
    [999000] = "HUSSNAIN MOD MENU @HUSSNAINxPUBG", [999001] = "CUSTOM ESP MENU",
    [999002] = "CUSTOM AIMBOT MENU", [999003] = "EXTRA FEATURES", [999100] = "ESP SKELETON BOX",
    [999101] = "ESP ENEMY DISTANCE", [999102] = "ESP HEALTH BAR", [999103] = "ESP HIT MARK",
    [999104] = "ESP BOX", [999105] = "ESP SKELETON ONLY", [999106] = "ESP REAL ENEMY/BOT",
    [999107] = "ESP GREEN ANTENNA", [999108] = "ESP ENEMY (RED AURA)", [999109] = "COLOR SIZE",
    [999200] = "LONG RANGE AIMBOT", [999201] = "AIMBOT SPEED", [999202] = "AIMBOT RECOIL ADS",
    [999203] = "CLOSE RANGE AIMBOT", [999204] = "AIMBOT CLOSE SPEED", [999214] = "SMALL CROSSHERE",
    [999215] = "FAST WEAPON CHANGE", [999216] = "X EFFECT", [999217] = "AUTO AIMBOT HEAD",
    [999219] = "AIM TOUCH ENABLE", [999220] = "HIPFIRE ENABLE", [999221] = "SHOTGUN ENABLE",
    [999222] = "SCOPE ALL ENABLE", [999223] = "SNIPER ENABLE", [999300] = "CUSTOM IPAD VIEW",
    [999301] = "IPAD FOV", [999302] = "165 REAL FPS", [999303] = "WALLHACK REAL",
    [999304] = "WHITE BODY", [999305] = "BLACK SKY", [999306] = "REMOVE FOG",
    [999307] = "REMOVE GRASS", [999308] = "WALL CLIMB", [999309] = "FAST CAR SPEED"
}

-- line 1932-1946
-- proto#226 params=0 locals=4 upvalues=2 vararg=false
local function r0_89()
    local r226_0 = _G.LocUtil
    local r226_1
    local r226_2 = r226_0
    if r226_2 then
        r226_1 = r226_2
    elseif package.loaded["client.common.LocUtil"] then
        r226_1 = require("client.common.LocUtil")
    else
        r226_1 = r226_0
    end
    if r226_1 and not r226_1._IsModMenuHooked then
        local r226_3 = r226_1.GetLocalizeResStr

        -- line 1939-1943
        -- proto#227 params=1 locals=0 upvalues=3 vararg=false
        r226_1.GetLocalizeResStr = function(p227_0)
            if type(p227_0) == "string" and not tonumber(p227_0) then
                return p227_0
            end
            if r0_88[p227_0] then
                return r0_88[p227_0]
            end
            return r226_3(p227_0)
        end

        r226_1._IsModMenuHooked = true
    end
end

local r0_90 = "rpad_settings.txt"
_G.LastConfigSaveStr = ""

-- line 1954-1973
-- proto#228 params=1 locals=1 upvalues=1 vararg=false
local function r0_91(p228_0)
    local r228_0 = {}
    -- [unluac error] HIR proto#228 still contains residual table-set-list during AST lowering
    pcall(function()
        if os and os.getenv then
            local r229_0 = os.getenv("HOME")
            if r229_0 and r229_0 ~= "" then
                table.insert(r228_0, 1, r229_0 .. "/Documents/ShadowTrackerExtra/Saved/Paks/" .. p228_0)
            end
        end
    end)
    return r228_0
end

-- line 1975-1996
-- proto#230 params=0 locals=0 upvalues=3 vararg=false
function _G.SaveModSettings()
    pcall(function()
        local r231_0 = [[return {
LexusConfig = {
]]
        for r231_1, r231_2 in pairs(_G.LexusConfig or {}) do
            local r231_3 = r231_0
            local r231_4 = tostring(r231_1)
            r231_0 = r231_3 .. '  ["' .. r231_4 .. '"] = ' .. tostring(r231_2) .. [[,
]]
        end
        local r231_5 = r231_0 .. [[},
CustomTextData = {
]]
        if _G.LexusState and _G.LexusState.CustomTextData then
            for r231_6, r231_7 in pairs(_G.LexusState.CustomTextData) do
                local r231_8 = r231_5
                local r231_9 = tostring(r231_6)
                r231_5 = r231_8 .. '  ["' .. r231_9 .. '"] = ' .. tostring(r231_7) .. [[,
]]
            end
        end
        local r231_10 = r231_5 .. [[}
}]]
        if r231_10 == _G.LastConfigSaveStr then
            return
        end
        _G.LastConfigSaveStr = r231_10
        local r231_11 = r0_91(r0_90)
        for r231_12, r231_13 in ipairs(r231_11) do
            local r231_14 = io.open(r231_13, "w")
            if r231_14 then
                r231_14:write(r231_10)
                r231_14:close()
                break
            end
        end
    end)
end

-- line 1998-2022
-- proto#232 params=0 locals=0 upvalues=3 vararg=false
function _G.LoadModSettings()
    pcall(function()
        local r233_0 = r0_91(r0_90)
        local r233_1 = nil
        for r233_2, r233_3 in ipairs(r233_0) do
            local r233_4 = io.open(r233_3, "r")
            if r233_4 then
                local r233_5 = r233_4:read("*a")
                r233_4:close()
                r233_1 = r233_5
                break
            end
        end
        if r233_1 then
            local r233_6 = load(r233_1)
            if r233_6 then
                local r233_7 = r233_6()
                if r233_7 and type(r233_7) == "table" then
                    if r233_7.LexusConfig then
                        for r233_8, r233_9 in pairs(r233_7.LexusConfig) do
                            _G.LexusConfig[r233_8] = r233_9
                        end
                    end
                    if r233_7.CustomTextData then
                        _G.LexusState.CustomTextData = _G.LexusState.CustomTextData or {}
                        for r233_10, r233_11 in pairs(r233_7.CustomTextData) do
                            local r233_12 = _G.LexusState
                            r233_12.CustomTextData[r233_10] = r233_11
                        end
                    end
                end
            end
        end
    end)
end

r0_0 = function()
    pcall(function()
        if _G.SaveModSettings then
            _G.SaveModSettings()
        end
    end)
    pcall(function()
        local r236_0, r236_1 = pcall(require, "common.time_ticker")
        if r236_0 and r236_1 and r236_1.AddTimerOnce then
            r236_1.AddTimerOnce(3.0, r0_0)
        end
    end)
end
if not _G.ModConfigLoaded then
    _G.LoadModSettings()
    r0_0()
    _G.ModConfigLoaded = true
end

-- line 2043-2200
-- proto#237 params=0 locals=42 upvalues=2 vararg=false
function _G.InitModMenuTab()
    if not _G._LICENSE_OK then
        return
    end
    r0_89()
    local r237_0 = require("client.logic.NewSetting.SettingPageDefine")
    local r237_1 = require("client.logic.NewSetting.SettingCatalog")
    local r237_2 = require("client.slua.umg.NewSetting.Item.AliasMap")
    local r237_3 = {}
    local r237_4 = {}
    r237_4.UI = r237_2.Title
    r237_4.Text = 999001
    local r237_5 = { Key = "ModMenu_ESP1" }
    r237_5.UI = r237_2.Switcher
    r237_5.Text = 999100

    -- line 2054-2054
    -- proto#238 params=0 locals=1 upvalues=1 vararg=false
    r237_5.GetFunc = function()
        return _G.LexusConfig.EspVip
    end

    -- line 2055-2055
    -- proto#239 params=2 locals=0 upvalues=1 vararg=false
    r237_5.SetFunc = function(p239_0, p239_1)
        _G.LexusConfig.EspVip = p239_1
        return true
    end

    local r237_6 = { Key = "ModMenu_ESP2" }
    r237_6.UI = r237_2.Switcher
    r237_6.Text = 999101

    -- line 2057-2057
    -- proto#240 params=0 locals=1 upvalues=1 vararg=false
    r237_6.GetFunc = function()
        return _G.LexusConfig.EspDistance
    end

    -- line 2058-2058
    -- proto#241 params=2 locals=0 upvalues=1 vararg=false
    r237_6.SetFunc = function(p241_0, p241_1)
        _G.LexusConfig.EspDistance = p241_1
        return true
    end

    local r237_7 = { Key = "ModMenu_ESP3" }
    r237_7.UI = r237_2.Switcher
    r237_7.Text = 999102

    -- line 2060-2060
    -- proto#242 params=0 locals=1 upvalues=1 vararg=false
    r237_7.GetFunc = function()
        return _G.LexusConfig.EspVipPro
    end

    -- line 2061-2061
    -- proto#243 params=2 locals=0 upvalues=1 vararg=false
    r237_7.SetFunc = function(p243_0, p243_1)
        _G.LexusConfig.EspVipPro = p243_1
        return true
    end

    local r237_8 = { Key = "ModMenu_ESP4" }
    r237_8.UI = r237_2.Switcher
    r237_8.Text = 999103

    -- line 2063-2063
    -- proto#244 params=0 locals=1 upvalues=1 vararg=false
    r237_8.GetFunc = function()
        return _G.LexusConfig.EspRadar
    end

    -- line 2064-2064
    -- proto#245 params=2 locals=0 upvalues=1 vararg=false
    r237_8.SetFunc = function(p245_0, p245_1)
        _G.LexusConfig.EspRadar = p245_1
        return true
    end

    local r237_9 = { Key = "ModMenu_ESP5" }
    r237_9.UI = r237_2.Switcher
    r237_9.Text = 999104

    -- line 2066-2066
    -- proto#246 params=0 locals=1 upvalues=1 vararg=false
    r237_9.GetFunc = function()
        return _G.LexusConfig.EspLoai5
    end

    -- line 2067-2067
    -- proto#247 params=2 locals=0 upvalues=1 vararg=false
    r237_9.SetFunc = function(p247_0, p247_1)
        _G.LexusConfig.EspLoai5 = p247_1
        return true
    end

    local r237_10 = { Key = "ModMenu_ESP6" }
    r237_10.UI = r237_2.Switcher
    r237_10.Text = 999105

    -- line 2069-2069
    -- proto#248 params=0 locals=1 upvalues=1 vararg=false
    r237_10.GetFunc = function()
        return _G.LexusConfig.EspLoai6
    end

    -- line 2070-2070
    -- proto#249 params=2 locals=0 upvalues=1 vararg=false
    r237_10.SetFunc = function(p249_0, p249_1)
        _G.LexusConfig.EspLoai6 = p249_1
        return true
    end

    local r237_11 = { Key = "ModMenu_ESP7" }
    r237_11.UI = r237_2.Switcher
    r237_11.Text = 999106

    -- line 2072-2072
    -- proto#250 params=0 locals=1 upvalues=1 vararg=false
    r237_11.GetFunc = function()
        return _G.LexusConfig.EspLoai7
    end

    -- line 2073-2073
    -- proto#251 params=2 locals=0 upvalues=1 vararg=false
    r237_11.SetFunc = function(p251_0, p251_1)
        _G.LexusConfig.EspLoai7 = p251_1
        return true
    end

    local r237_12 = { Key = "ModMenu_ESPAntenna" }
    r237_12.UI = r237_2.Switcher
    r237_12.Text = 999107

    -- line 2075-2075
    -- proto#252 params=0 locals=1 upvalues=1 vararg=false
    r237_12.GetFunc = function()
        return _G.LexusConfig.EspAntenna
    end

    -- line 2076-2076
    -- proto#253 params=2 locals=0 upvalues=1 vararg=false
    r237_12.SetFunc = function(p253_0, p253_1)
        _G.LexusConfig.EspAntenna = p253_1
        return true
    end

    local r237_13 = { Key = "ModMenu_ESPOutline_Ex" }
    r237_13.UI = r237_2.TitleSwitcher
    r237_13.Text = 999108
    r237_13.ExpandIndex = 0

    -- line 2078-2078
    -- proto#254 params=0 locals=1 upvalues=1 vararg=false
    r237_13.GetFunc = function()
        return _G.LexusConfig.EspOutline
    end

    -- line 2079-2079
    -- proto#255 params=2 locals=0 upvalues=1 vararg=false
    r237_13.SetFunc = function(p255_0, p255_1)
        _G.LexusConfig.EspOutline = p255_1
        return true
    end

    local r237_14 = { Key = "ModMenu_ESPOutline_Thickness" }
    r237_14.UI = r237_2.Slider
    r237_14.Text = 999109
    r237_14.ExpandHandle = "ModMenu_ESPOutline_Ex"
    r237_14.MinValue = 1
    r237_14.MaxValue = 20
    r237_14.min = 1
    r237_14.max = 20

    -- line 2082-2082
    -- proto#256 params=0 locals=1 upvalues=1 vararg=false
    r237_14.GetFunc = function()
        return _G.LexusConfig.OutlineThickness or 10
    end

    -- line 2083-2083
    -- proto#257 params=2 locals=0 upvalues=1 vararg=false
    r237_14.SetFunc = function(p257_0, p257_1)
        _G.LexusConfig.OutlineThickness = p257_1
        return true
    end

    -- [unluac error] HIR proto#237 still contains residual table-set-list during AST lowering
    local r237_15 = {}
    local r237_16 = {}
    r237_16.UI = r237_2.Title
    r237_16.Text = 999002
    local r237_17 = { Key = "ModMenu_Aimbot_Ex" }
    r237_17.UI = r237_2.TitleSwitcher
    r237_17.Text = 999200
    r237_17.ExpandIndex = 0

    -- line 2089-2089
    -- proto#258 params=0 locals=1 upvalues=1 vararg=false
    r237_17.GetFunc = function()
        return _G.LexusConfig.CustomAimbot
    end

    -- line 2090-2090
    -- proto#259 params=2 locals=0 upvalues=1 vararg=false
    r237_17.SetFunc = function(p259_0, p259_1)
        _G.LexusConfig.CustomAimbot = p259_1
        return true
    end

    local r237_18 = { Key = "ModMenu_Aimbot_Speed" }
    r237_18.UI = r237_2.Slider
    r237_18.Text = 999201
    r237_18.ExpandHandle = "ModMenu_Aimbot_Ex"
    r237_18.MinValue = 1
    r237_18.MaxValue = 100
    r237_18.min = 1
    r237_18.max = 100

    -- line 2093-2093
    -- proto#260 params=0 locals=2 upvalues=1 vararg=false
    r237_18.GetFunc = function()
        return _G.LexusState.CustomTextData and _G.LexusState.CustomTextData.OuterSpeed or 10
    end

    -- line 2094-2094
    -- proto#261 params=2 locals=1 upvalues=1 vararg=false
    r237_18.SetFunc = function(p261_0, p261_1)
        local r261_0 = _G.LexusState
        r261_0.CustomTextData.OuterSpeed = p261_1
        return true
    end

    local r237_19 = { Key = "ModMenu_Aimbot_Recoil" }
    r237_19.UI = r237_2.Slider
    r237_19.Text = 999202
    r237_19.ExpandHandle = "ModMenu_Aimbot_Ex"
    r237_19.MinValue = 1
    r237_19.MaxValue = 50
    r237_19.min = 1
    r237_19.max = 50

    -- line 2097-2097
    -- proto#262 params=0 locals=2 upvalues=1 vararg=false
    r237_19.GetFunc = function()
        return _G.LexusState.CustomTextData and _G.LexusState.CustomTextData.OuterRecoil or 0.1
    end

    -- line 2098-2098
    -- proto#263 params=2 locals=1 upvalues=1 vararg=false
    r237_19.SetFunc = function(p263_0, p263_1)
        local r263_0 = _G.LexusState
        r263_0.CustomTextData.OuterRecoil = p263_1
        return true
    end

    local r237_20 = { Key = "ModMenu_AimbotClose_Ex" }
    r237_20.UI = r237_2.TitleSwitcher
    r237_20.Text = 999203
    r237_20.ExpandIndex = 0

    -- line 2100-2100
    -- proto#264 params=0 locals=1 upvalues=1 vararg=false
    r237_20.GetFunc = function()
        return _G.LexusConfig.CustomAimbotClose
    end

    -- line 2101-2101
    -- proto#265 params=2 locals=0 upvalues=1 vararg=false
    r237_20.SetFunc = function(p265_0, p265_1)
        _G.LexusConfig.CustomAimbotClose = p265_1
        return true
    end

    local r237_21 = { Key = "ModMenu_AimbotClose_Speed" }
    r237_21.UI = r237_2.Slider
    r237_21.Text = 999204
    r237_21.ExpandHandle = "ModMenu_AimbotClose_Ex"
    r237_21.MinValue = 1
    r237_21.MaxValue = 100
    r237_21.min = 1
    r237_21.max = 100

    -- line 2104-2104
    -- proto#266 params=0 locals=2 upvalues=1 vararg=false
    r237_21.GetFunc = function()
        return _G.LexusState.CustomTextData and _G.LexusState.CustomTextData.InnerSpeed or 10
    end

    -- line 2105-2105
    -- proto#267 params=2 locals=1 upvalues=1 vararg=false
    r237_21.SetFunc = function(p267_0, p267_1)
        local r267_0 = _G.LexusState
        r267_0.CustomTextData.InnerSpeed = p267_1
        return true
    end

    local r237_22 = { Key = "ModMenu_Crosshair" }
    r237_22.UI = r237_2.Switcher
    r237_22.Text = 999214

    -- line 2107-2107
    -- proto#268 params=0 locals=1 upvalues=1 vararg=false
    r237_22.GetFunc = function()
        return _G.LexusConfig.Crosshair
    end

    -- line 2108-2108
    -- proto#269 params=2 locals=0 upvalues=1 vararg=false
    r237_22.SetFunc = function(p269_0, p269_1)
        _G.LexusConfig.Crosshair = p269_1
        return true
    end

    local r237_23 = { Key = "ModMenu_AutoHead" }
    r237_23.UI = r237_2.Switcher
    r237_23.Text = 999217

    -- line 2110-2110
    -- proto#270 params=0 locals=1 upvalues=1 vararg=false
    r237_23.GetFunc = function()
        return _G.LexusConfig.AutoHead
    end

    -- line 2111-2111
    -- proto#271 params=2 locals=0 upvalues=1 vararg=false
    r237_23.SetFunc = function(p271_0, p271_1)
        _G.LexusConfig.AutoHead = p271_1
        return true
    end

    local r237_24 = { Key = "ModMenu_AT_Ex" }
    r237_24.UI = r237_2.TitleSwitcher
    r237_24.Text = 999219
    r237_24.ExpandIndex = 0

    -- line 2113-2113
    -- proto#272 params=0 locals=1 upvalues=1 vararg=false
    r237_24.GetFunc = function()
        return _G.LexusConfig.AimTouchEnable
    end

    -- line 2114-2114
    -- proto#273 params=2 locals=0 upvalues=1 vararg=false
    r237_24.SetFunc = function(p273_0, p273_1)
        _G.LexusConfig.AimTouchEnable = p273_1
        return true
    end

    local r237_25 = { Key = "ModMenu_AT_Hip_Ex" }
    r237_25.UI = r237_2.TitleSwitcher
    r237_25.Text = 999220
    r237_25.ExpandHandle = "ModMenu_AT_Ex"
    r237_25.ExpandIndex = 0

    -- line 2117-2117
    -- proto#274 params=0 locals=1 upvalues=1 vararg=false
    r237_25.GetFunc = function()
        return _G.LexusConfig.AimTouchHipfire
    end

    -- line 2118-2118
    -- proto#275 params=2 locals=0 upvalues=1 vararg=false
    r237_25.SetFunc = function(p275_0, p275_1)
        _G.LexusConfig.AimTouchHipfire = p275_1
        return true
    end

    local r237_26 = { Key = "ModMenu_AT_SG_Ex" }
    r237_26.UI = r237_2.TitleSwitcher
    r237_26.Text = 999221
    r237_26.ExpandHandle = "ModMenu_AT_Ex"
    r237_26.ExpandIndex = 0

    -- line 2121-2121
    -- proto#276 params=0 locals=1 upvalues=1 vararg=false
    r237_26.GetFunc = function()
        return _G.LexusConfig.AimTouchSG
    end

    -- line 2122-2122
    -- proto#277 params=2 locals=0 upvalues=1 vararg=false
    r237_26.SetFunc = function(p277_0, p277_1)
        _G.LexusConfig.AimTouchSG = p277_1
        return true
    end

    local r237_27 = { Key = "ModMenu_AT_ScopeAll_Ex" }
    r237_27.UI = r237_2.TitleSwitcher
    r237_27.Text = 999222
    r237_27.ExpandHandle = "ModMenu_AT_Ex"
    r237_27.ExpandIndex = 0

    -- line 2125-2125
    -- proto#278 params=0 locals=1 upvalues=1 vararg=false
    r237_27.GetFunc = function()
        return _G.LexusConfig.AimTouchScopeAll
    end

    -- line 2126-2126
    -- proto#279 params=2 locals=0 upvalues=1 vararg=false
    r237_27.SetFunc = function(p279_0, p279_1)
        _G.LexusConfig.AimTouchScopeAll = p279_1
        return true
    end

    local r237_28 = { Key = "ModMenu_AT_Sniper_Ex" }
    r237_28.UI = r237_2.TitleSwitcher
    r237_28.Text = 999223
    r237_28.ExpandHandle = "ModMenu_AT_Ex"
    r237_28.ExpandIndex = 0

    -- line 2129-2129
    -- proto#280 params=0 locals=1 upvalues=1 vararg=false
    r237_28.GetFunc = function()
        return _G.LexusConfig.AimTouchScopeSniper
    end

    -- line 2130-2130
    -- proto#281 params=2 locals=0 upvalues=1 vararg=false
    r237_28.SetFunc = function(p281_0, p281_1)
        _G.LexusConfig.AimTouchScopeSniper = p281_1
        return true
    end

    -- [unluac error] HIR proto#237 still contains residual table-set-list during AST lowering
    local r237_29 = {}
    local r237_30 = {}
    r237_30.UI = r237_2.Title
    r237_30.Text = 999003
    local r237_31 = { Key = "ModMenu_Ipad_Ex" }
    r237_31.UI = r237_2.TitleSwitcher
    r237_31.Text = 999300
    r237_31.ExpandIndex = 0

    -- line 2136-2136
    -- proto#282 params=0 locals=1 upvalues=1 vararg=false
    r237_31.GetFunc = function()
        return _G.LexusConfig.IpadView
    end

    -- line 2137-2137
    -- proto#283 params=2 locals=0 upvalues=1 vararg=false
    r237_31.SetFunc = function(p283_0, p283_1)
        _G.LexusConfig.IpadView = p283_1
        return true
    end

    local r237_32 = { Key = "ModMenu_Ipad_FOV" }
    r237_32.UI = r237_2.Slider
    r237_32.Text = 999301
    r237_32.ExpandHandle = "ModMenu_Ipad_Ex"
    r237_32.MinValue = 1
    r237_32.MaxValue = 100
    r237_32.min = 1
    r237_32.max = 100

    -- line 2140-2140
    -- proto#284 params=0 locals=2 upvalues=1 vararg=false
    r237_32.GetFunc = function()
        local r284_0 = _G.LexusState.CustomTextData and _G.LexusState.CustomTextData.IpadViewFOV
            or 120
        return r284_0 - 90
    end

    -- line 2141-2141
    -- proto#285 params=2 locals=1 upvalues=1 vararg=false
    r237_32.SetFunc = function(p285_0, p285_1)
        local r285_0 = _G.LexusState
        r285_0.CustomTextData.IpadViewFOV = 90 + p285_1
        return true
    end

    local r237_33 = { Key = "ModMenu_165FPS" }
    r237_33.UI = r237_2.Switcher
    r237_33.Text = 999302

    -- line 2143-2143
    -- proto#286 params=0 locals=1 upvalues=1 vararg=false
    r237_33.GetFunc = function()
        return _G.LexusConfig.UnlockFPS
    end

    -- line 2144-2144
    -- proto#287 params=2 locals=0 upvalues=1 vararg=false
    r237_33.SetFunc = function(p287_0, p287_1)
        _G.LexusConfig.UnlockFPS = p287_1
        return true
    end

    local r237_34 = { Key = "ModMenu_WallColor" }
    r237_34.UI = r237_2.Switcher
    r237_34.Text = 999303

    -- line 2146-2146
    -- proto#288 params=0 locals=1 upvalues=1 vararg=false
    r237_34.GetFunc = function()
        return _G.LexusConfig.WallXuyenTuong
    end

    -- line 2147-2147
    -- proto#289 params=2 locals=0 upvalues=1 vararg=false
    r237_34.SetFunc = function(p289_0, p289_1)
        _G.LexusConfig.WallXuyenTuong = p289_1
        _G.LexusConfig.ColorBodyV2 = p289_1
        return true
    end

    local r237_35 = { Key = "ModMenu_WhiteBody" }
    r237_35.UI = r237_2.Switcher
    r237_35.Text = 999304

    -- line 2149-2149
    -- proto#290 params=0 locals=1 upvalues=1 vararg=false
    r237_35.GetFunc = function()
        return _G.LexusConfig.WhiteBody
    end

    -- line 2150-2150
    -- proto#291 params=2 locals=0 upvalues=1 vararg=false
    r237_35.SetFunc = function(p291_0, p291_1)
        _G.LexusConfig.WhiteBody = p291_1
        return true
    end

    local r237_36 = { Key = "ModMenu_BlackSky" }
    r237_36.UI = r237_2.Switcher
    r237_36.Text = 999305

    -- line 2152-2152
    -- proto#292 params=0 locals=1 upvalues=1 vararg=false
    r237_36.GetFunc = function()
        return _G.LexusConfig.BlackSky
    end

    -- line 2153-2153
    -- proto#293 params=2 locals=0 upvalues=1 vararg=false
    r237_36.SetFunc = function(p293_0, p293_1)
        _G.LexusConfig.BlackSky = p293_1
        return true
    end

    local r237_37 = { Key = "ModMenu_RemoveFog" }
    r237_37.UI = r237_2.Switcher
    r237_37.Text = 999306

    -- line 2155-2155
    -- proto#294 params=0 locals=1 upvalues=1 vararg=false
    r237_37.GetFunc = function()
        return _G.LexusConfig.RemoveFog
    end

    -- line 2156-2156
    -- proto#295 params=2 locals=0 upvalues=1 vararg=false
    r237_37.SetFunc = function(p295_0, p295_1)
        _G.LexusConfig.RemoveFog = p295_1
        return true
    end

    local r237_38 = { Key = "ModMenu_RemoveGrass" }
    r237_38.UI = r237_2.Switcher
    r237_38.Text = 999307

    -- line 2158-2158
    -- proto#296 params=0 locals=1 upvalues=1 vararg=false
    r237_38.GetFunc = function()
        return _G.LexusConfig.RemoveGrass
    end

    -- line 2159-2159
    -- proto#297 params=2 locals=0 upvalues=1 vararg=false
    r237_38.SetFunc = function(p297_0, p297_1)
        _G.LexusConfig.RemoveGrass = p297_1
        return true
    end

    -- [unluac error] HIR proto#237 still contains residual table-set-list during AST lowering
    if not r237_0.MyModMenu then
        local r237_39 = { Key = "MyModMenu", Text = 999000, UIKey = "Setting_Page_Privacy" }
        local r237_40 = {
            { Key = "Cat_ESP", Text = 999001, Stack = r237_3 },
            { Key = "Cat_Aimbot", Text = 999002, Stack = r237_15 },
            { Key = "Cat_Combat", Text = 999003, Stack = r237_29 }
        }
        r237_39.Category = r237_40
        r237_0.MyModMenu = r237_39
        table.insert(r237_1, r237_0.MyModMenu)
    end
    local r237_41 = _G.UIManager
    if r237_41 and not r237_41._IsModMenuHooked then
        r237_31 = r237_41.ShowUI

        -- line 2178-2197
        -- proto#298 params=1 locals=7 upvalues=3 vararg=true
        r237_41.ShowUI = function(p298_0, ...)
            local r298_0 = { ... }
            local r298_1 = select("#", ...)
            if p298_0
                and p298_0.keyName
                and string.find(string.lower(p298_0.keyName), "setting_main") then
                local r298_2 = r298_0[1]
                if type(r298_2) == "table" then
                    local r298_3 = false
                    for r298_4, r298_5 in ipairs(r298_2) do
                        if type(r298_5) == "table" and r298_5.Key == "MyModMenu" then
                            r298_3 = true
                            break
                        end
                    end
                    if not r298_3 and r237_0.MyModMenu then
                        table.insert(r298_2, 1, r237_0.MyModMenu)
                    end
                end
            end
            local r298_6 = table.unpack or unpack
            return r237_31(p298_0, r298_6(r298_0, 1, r298_1))
        end

        r237_41._IsModMenuHooked = true
    end
end

-- line 2210-2246
-- proto#299 params=0 locals=0 upvalues=1 vararg=false
local function r0_92()
    if _G.LexusState.NativeESPReady then
        return
    end
    pcall(function()
        local r300_0 = require("GameLua.Mod.BaseMod.Common.GamePlayTools").GetCurrentConfig("ScreenMarkConfig")

        -- line 2215-2237
        -- proto#301 params=1 locals=18 upvalues=1 vararg=false
        local function r300_1(p301_0)
            if not p301_0 then
                return
            end
            if p301_0[1006] then
                p301_0[1006].bBindBlocked = true
                p301_0[1006].bBindOutScreen = true
                p301_0[1006].MaxWidgetNum = 99
                p301_0[1006].MaxShowDistance = 6000000
                p301_0[1006].bScaleByDistance = false
                p301_0[1006].BindSocketName = "root"
                p301_0[1006].bUseLuaWorldSocketName = true
                local r301_0 = p301_0[1006]
                local r301_1 = FVector(0, 0, -30)
                r301_0.WorldPositionOffset = r301_1
            end
            if p301_0[1003] then
                p301_0[1003].bBindBlocked = true
                p301_0[1003].bBindOutScreen = true
                p301_0[1003].MaxWidgetNum = 99
                p301_0[1003].MaxShowDistance = 6000000
                p301_0[1003].bScaleByDistance = false
                p301_0[1003].BindSocketName = "head"
                p301_0[1003].bUseLuaWorldSocketName = true
            end
            local r301_2 = {
                UIPathName = "/Game/Mod/EvoBase/BluePrints/UIBP/QuickSign/QuickSign_TipHitEnemy_UIBP_New.QuickSign_TipHitEnemy_UIBP_New_C",
                MaxWidgetNum = 99, MaxShowDistance = 6000000, bBindOutScreen = true,
                bBindBlocked = true, bIsBindingActor = true, BindSocketName = "head",
                bUseLuaWorldSocketName = true
            }
            local r301_3 = FVector(0, 0, 50)
            r301_2.WorldPositionOffset = r301_3
            r301_2.bNeedPreLoad = true
            r301_2.Priority = 2
            p301_0[9999] = r301_2
        end

        r300_1(r300_0)
        for r300_2, r300_3 in pairs(package.loaded) do
            if type(r300_2) == "string"
                and string.find(r300_2, "ScreenMarkConfig")
                and type(r300_3) == "table" then
                r300_1(r300_3)
            end
        end
    end)
    _G.LexusState.NativeESPReady = true
end

-- line 2251-2281
-- proto#302 params=2 locals=5 upvalues=2 vararg=false
local function r0_93(p302_0, p302_1)
    local r302_0 = os.clock()
    if p302_1
        and p302_1.CachedMeshes
        and p302_1.CachedMeshTime
        and r302_0 - p302_1.CachedMeshTime < 3.0 then
        local r302_1 = {}
        for r302_2, r302_3 in ipairs(p302_1.CachedMeshes) do
            if r0_11(r302_3) then
                table.insert(r302_1, r302_3)
            end
        end
        p302_1.CachedMeshes = r302_1
        return r302_1
    end
    local r302_4 = {}
    if r0_11(p302_0.Mesh) then
        table.insert(r302_4, p302_0.Mesh)
    end
    pcall(function()
        local r303_0 = import("SkeletalMeshComponent")
        if r303_0 and type(p302_0.GetComponentsByClass) == "function" then
            local r303_1 = p302_0:GetComponentsByClass(r303_0)
            if r303_1 then
                local r303_2 = type(r303_1.Num)
                r303_2 = r303_2 == "function" and r303_1:Num() or #r303_1
                for r303_3 = 1, r303_2 do
                    local r303_4 = type(r303_1.Get)
                    r303_4 = r303_4 == "function" and r303_1:Get(r303_3 - 1) or r303_1[r303_3]
                    if r0_11(r303_4) and r303_4 ~= p302_0.Mesh then
                        table.insert(r302_4, r303_4)
                    end
                end
            end
        end
    end)
    if p302_1 then
        p302_1.CachedMeshes = r302_4
        p302_1.CachedMeshTime = r302_0
    end
    return r302_4
end

-- line 2283-2302
-- proto#304 params=2 locals=0 upvalues=3 vararg=false
local function r0_94(p304_0, p304_1)
    pcall(function()
        if p304_1.WallhackApplied then
            local r305_0 = r0_93(p304_0, p304_1)
            for r305_1, r305_2 in ipairs(r305_0) do
                if r0_11(r305_2) then
                    pcall(function()
                        if type(r305_2.SetRenderCustomDepth) == "function" then
                            r305_2:SetRenderCustomDepth(false)
                        end
                    end)
                    for r305_3 = 0, 10 do
                        local r305_4 = r305_2:GetMaterial(r305_3)
                        if r0_11(r305_4) then
                            local r305_5 = r305_4:GetBaseMaterial()
                            if r0_11(r305_5) then
                                r305_5.bDisableDepthTest = false
                            end
                        end
                    end
                end
            end
            p304_1.WallhackApplied = false
        end
    end)
end

-- line 2304-2325
-- proto#307 params=2 locals=0 upvalues=3 vararg=false
local function r0_95(p307_0, p307_1)
    pcall(function()
        local r308_0 = r0_93(p307_0, p307_1)
        for r308_1, r308_2 in ipairs(r308_0) do
            if r0_11(r308_2) then
                pcall(function()
                    if type(r308_2.SetRenderCustomDepth) == "function" then
                        r308_2:SetRenderCustomDepth(true)
                    end
                    if type(r308_2.SetCustomDepthStencilValue) == "function" then
                        r308_2:SetCustomDepthStencilValue(252)
                    end
                end)
                for r308_3 = 0, 10 do
                    local r308_4 = r308_2:GetMaterial(r308_3)
                    if not r0_11(r308_4) then
                        break
                    end
                    local r308_5 = r308_4:GetBaseMaterial()
                    if r0_11(r308_5) then
                        r308_5.bDisableDepthTest = true
                        r308_5.BlendMode = 2
                    end
                end
            end
        end
    end)
end

-- line 2327-2395
-- proto#310 params=3 locals=0 upvalues=4 vararg=false
local function r0_96(p310_0, p310_1, p310_2)
    pcall(function()
        local r311_0 = r0_93(p310_0, p310_2)
        if #r311_0 == 0 then
            return
        end
        local r311_1 = true
        pcall(function()
            if r0_11(p310_1) and type(p310_1.LineOfSightTo) == "function" then
                r311_1 = not p310_1:LineOfSightTo(p310_0)
            end
        end)
        local r311_2 = _G.LexusState.CustomTextData or {}
        local r311_3 = {}
        r311_3.R = r311_2.HiddenR or 150
        r311_3.G = r311_2.HiddenG or 0
        r311_3.B = r311_2.HiddenB or 0
        r311_3.A = r311_2.HiddenA or 25
        local r311_4 = {}
        r311_4.R = r311_2.VisibleR or 0
        r311_4.G = r311_2.VisibleG or 150
        r311_4.B = r311_2.VisibleB or 0
        r311_4.A = r311_2.VisibleA or 25
        local r311_5 = r311_1 and r311_3 or r311_4
        local r311_6 = string.format("%d_%d_%d_%d", r311_5.R, r311_5.G, r311_5.B, r311_5.A)
        local r311_7 = #r311_0
        local r311_8 = p310_2.LastMeshCount ~= r311_7
        if not r311_8 and p310_2.LastHiddenState == r311_1 and p310_2.LastColorHash == r311_6 then
            return
        end
        p310_2.LastHiddenState = r311_1
        p310_2.LastMeshCount = r311_7
        p310_2.LastColorHash = r311_6
        p310_2.ColorApplied = true
        for r311_9, r311_10 in ipairs(r311_0) do
            if r0_11(r311_10) then
                pcall(function()
                    r311_10.LDMaxDrawDistance = -99999
                    r311_10.MaxDrawDistanceOffset = -99999
                    r311_10.CachedMaxDrawDistance = -99999
                    r311_10.UseScopeDistanceCulling = true
                    r311_10.PrimitiveShadingStrategy = 1
                    r311_10.ShadingRate = 6
                end)
                for r311_11 = 0, 10 do
                    local r311_12 = r311_10:GetMaterial(r311_11)
                    if not r0_11(r311_12) then
                        break
                    end
                    local r311_13 = r311_12:GetBaseMaterial()
                    if r0_11(r311_13) then
                        local r311_14 = tostring(r311_13)
                        local r311_15 = string.find(r311_14, "Master_Mask", 1, true)
                        if r311_15 then
                            if not p310_2.MIDs then
                                local r311_16 = {}
                                p310_2.MIDs = r311_16
                            end
                            local r311_17 = tostring(r311_10)
                            if not p310_2.MIDs[r311_17] then
                                p310_2.MIDs[r311_17] = {}
                            end
                            local r311_18 = p310_2.MIDs[r311_17][r311_11]
                            local r311_19
                            if r0_11(r311_18) then
                                r311_19 = r311_18
                            else
                                local r311_20 = r311_10:CreateAndSetMaterialInstanceDynamic(r311_11)
                                p310_2.MIDs[r311_17][r311_11] = r311_20
                                r311_19 = r311_20
                            end
                            if r0_11(r311_19) then
                                r311_19:SetVectorParameterValue("颜色", r311_5)
                                r311_19:SetVectorParameterValue("Extra Light Color", r311_5)
                                r311_19:SetVectorParameterValue("Para_Color", r311_5)
                                r311_19:SetVectorParameterValue("Para_ColorTint", r311_5)
                                r311_19:SetVectorParameterValue("Para_Color_1", r311_5)
                                r311_19:SetVectorParameterValue("Tint", r311_5)
                                r311_19:SetVectorParameterValue("Color", r311_5)
                                r311_19:SetVectorParameterValue("BaseColor", r311_5)
                                r311_19:SetVectorParameterValue("BodyColor", r311_5)
                                r311_19:SetVectorParameterValue("MainColor", r311_5)
                                r311_19:SetVectorParameterValue("DiffuseColor", r311_5)
                                r311_19:SetVectorParameterValue("EmissiveColor", r311_5)
                                r311_19:SetVectorParameterValue("ParaScaleOffset", r0_18)
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- line 2397-2432
-- proto#314 params=2 locals=0 upvalues=3 vararg=false
local function r0_97(p314_0, p314_1)
    pcall(function()
        if p314_1.ColorApplied then
            local r315_0 = r0_93(p314_0, p314_1)
            for r315_1, r315_2 in ipairs(r315_0) do
                if r0_11(r315_2) then
                    pcall(function()
                        r315_2.PrimitiveShadingStrategy = 0
                        r315_2.ShadingRate = 1
                    end)
                    if p314_1.MIDs and p314_1.MIDs[tostring(r315_2)] then
                        for r315_3, r315_4 in pairs(p314_1.MIDs[tostring(r315_2)]) do
                            if r0_11(r315_4) then
                                local r315_5 = { R = 1, G = 1, B = 1, A = 1 }
                                r315_4:SetVectorParameterValue("颜色", r315_5)
                                r315_4:SetVectorParameterValue("Extra Light Color", r315_5)
                                r315_4:SetVectorParameterValue("Para_Color", r315_5)
                                r315_4:SetVectorParameterValue("Para_ColorTint", r315_5)
                                r315_4:SetVectorParameterValue("Para_Color_1", r315_5)
                                r315_4:SetVectorParameterValue("Tint", r315_5)
                                r315_4:SetVectorParameterValue("Color", r315_5)
                                r315_4:SetVectorParameterValue("BaseColor", r315_5)
                                r315_4:SetVectorParameterValue("BodyColor", r315_5)
                                r315_4:SetVectorParameterValue("MainColor", r315_5)
                                r315_4:SetVectorParameterValue("DiffuseColor", r315_5)
                                r315_4:SetVectorParameterValue("EmissiveColor", r315_5)
                            end
                        end
                    end
                end
            end
            p314_1.ColorApplied = false
            p314_1.LastColorHash = ""
        end
    end)
end

-- line 2437-2457
-- proto#317 params=1 locals=9 upvalues=2 vararg=false
function _G.GetEnemyTargetsFromActors(p317_0)
    local r317_0 = {}
    local r317_1 = r0_7.GetPlayerCharacter()
    if slua.isValid(r317_1) then
        local r317_2 = {}
        if r0_7.GetAllPlayerCharacters then
            r317_2 = r0_7.GetAllPlayerCharacters()
        elseif r0_7.GameCharacters then
            for r317_3, r317_4 in pairs(r0_7.GameCharacters) do
                table.insert(r317_2, r317_4)
            end
        end
        local r317_5 = r317_1:GetTeamID()
        for r317_6, r317_7 in pairs(r317_2) do
            if slua.isValid(r317_7)
                and r317_7 ~= r317_1
                and r317_7.GetTeamID
                and r317_7:IsAlive()
                and r317_7:GetTeamID() ~= r317_5
                and r317_1:GetDistanceTo(r317_7) <= p317_0 then
                table.insert(r317_0, r317_7)
            end
        end
        return r317_0
    end
    return r317_0
end

-- line 2459-2675
-- proto#318 params=0 locals=0 upvalues=2 vararg=false
function _G.AimTouch()
    pcall(function()
        if _G.LexusConfig.AimTouchEnable then
            local r319_0 = r0_7.GetPlayerCharacter()
            if slua.isValid(r319_0) then
                local r319_1 = r319_0:GetPlayerControllerSafety()
                if slua.isValid(r319_1) then
                    local r319_2 = r319_0.bIsWeaponFiring
                    local r319_3 = r319_0.bIsGunADS
                    local r319_4 = r319_0.WeaponManagerComponent
                        and r319_0.WeaponManagerComponent.CurrentWeaponReplicated
                    local r319_5 = r319_4
                    local r319_6, r319_7, r319_8, r319_9, r319_10, r319_11, r319_12, r319_13, r319_14, r319_15, r319_16
                    if r319_5 then
                        r319_6 = r319_5
                    elseif type(r319_0.GetCurrentShootWeapon) == "function" then
                        r319_6 = r319_0:GetCurrentShootWeapon()
                    else
                        r319_6 = r319_4
                    end
                    local r319_17, r319_18 = false, false
                    if slua.isValid(r319_6) then
                        local r319_19 = type(r319_6.GetWeaponID)
                        r319_19 = r319_19 == "function" and r319_6:GetWeaponID() or 0
                        local r319_20 = type(r319_6.GetWeaponName)
                        r319_20 = r319_20 == "function" and r319_6:GetWeaponName() or ""
                        local r319_21
                        if r319_19 >= 1030000 then
                            if r319_19 < 1040000 then
                                r319_21 = true
                            elseif r319_20:find("S686") then
                                r319_21 = true
                            elseif r319_20:find("S1897") then
                                r319_21 = true
                            elseif r319_20:find("S12") then
                                r319_21 = true
                            elseif r319_20:find("DBS") then
                                r319_21 = true
                            elseif r319_20:find("M1014") then
                                r319_21 = true
                            else
                                r319_21 = r319_17
                            end
                        elseif r319_20:find("S686") then
                            r319_21 = true
                        elseif r319_20:find("S1897") then
                            r319_21 = true
                        elseif r319_20:find("S12") then
                            r319_21 = true
                        elseif r319_20:find("DBS") then
                            r319_21 = true
                        elseif r319_20:find("M1014") then
                            r319_21 = true
                        else
                            r319_21 = r319_17
                        end
                        if not r319_20:find("Kar98") then
                            if not r319_20:find("M24") then
                                if not r319_20:find("AWM") then
                                    if not r319_20:find("Mosin") then
                                        if not r319_20:find("Win94") then
                                            if not r319_20:find("AMR") then
                                                if not r319_20:find("SKS") then
                                                    if not r319_20:find("SLR") then
                                                        if not r319_20:find("Mini") then
                                                            if not r319_20:find("Mk14") then
                                                                if not r319_20:find("QBU") then
                                                                    if not r319_20:find("Mk12") then
                                                                        if not r319_20:find("VSS") then
                                                                            r319_7, r319_8 = r319_21, r319_18
                                                                            goto L2
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        r319_7, r319_8 = r319_21, true
                    else
                        r319_7, r319_8 = r319_17, r319_18
                    end
                    ::L2::
                    if r319_7 and _G.LexusConfig.AimTouchSG then
                        local r319_22 = _G.LexusState.CustomTextData.AimTouchSGCond or 1
                        if (_G.LexusConfig.AimTouchSGAutoFire and 2 or r319_22) == 1 and not r319_2 then
                            return
                        end
                        local r319_23 = _G.LexusState.CustomTextData.AimTouchSGPrio or 1
                        local r319_24 = _G.LexusState.CustomTextData.AimTouchSGBone or 2
                        local r319_25 = _G.LexusState.CustomTextData.AimTouchSGSpeed or 80
                        local r319_26 = _G.LexusState.CustomTextData.AimTouchSGFOV or 40
                        local r319_27 = _G.LexusState.CustomTextData.AimTouchSGDist or 30
                        r319_9, r319_10, r319_11, r319_12, r319_13, r319_14, r319_15, r319_16 = r319_23, r319_24, r319_25, r319_26, r319_27, _G.LexusConfig.AimTouchSGVisCheck, _G.LexusConfig.AimTouchSGIgKnock, _G.LexusConfig.AimTouchSGIgBot
                    elseif r319_3 then
                        if r319_8 and _G.LexusConfig.AimTouchScopeSniper then
                            if (_G.LexusState.CustomTextData.AimTouchSniperCond or 2) == 1
                                and not r319_2 then
                                return
                            end
                            local r319_28 = _G.LexusState.CustomTextData.AimTouchSniperPrio or 1
                            local r319_29 = _G.LexusState.CustomTextData.AimTouchSniperBone or 1
                            local r319_30 = _G.LexusState.CustomTextData.AimTouchSniperSpeed or 30
                            local r319_31 = _G.LexusState.CustomTextData.AimTouchSniperFOV or 20
                            local r319_32 = _G.LexusState.CustomTextData.AimTouchSniperDist or 400
                            r319_9, r319_10, r319_11, r319_12, r319_13, r319_14, r319_15, r319_16 = r319_28, r319_29, r319_30, r319_31, r319_32, _G.LexusConfig.AimTouchSniperVisCheck, _G.LexusConfig.AimTouchSniperIgKnock, _G.LexusConfig.AimTouchSniperIgBot
                        else
                            if not _G.LexusConfig.AimTouchScopeAll then
                                return
                            end
                            if (_G.LexusState.CustomTextData.AimTouchScopeCond or 1) == 1
                                and not r319_2 then
                                return
                            end
                            local r319_33 = _G.LexusState.CustomTextData.AimTouchScopePrio or 1
                            local r319_34 = _G.LexusState.CustomTextData.AimTouchScopeBone or 2
                            local r319_35 = _G.LexusState.CustomTextData.AimTouchScopeSpeed or 40
                            local r319_36 = _G.LexusState.CustomTextData.AimTouchScopeFOV or 20
                            local r319_37 = _G.LexusState.CustomTextData.AimTouchScopeDist or 300
                            r319_9, r319_10, r319_11, r319_12, r319_13, r319_14, r319_15, r319_16 = r319_33, r319_34, r319_35, r319_36, r319_37, _G.LexusConfig.AimTouchScopeVisCheck, _G.LexusConfig.AimTouchScopeIgKnock, _G.LexusConfig.AimTouchScopeIgBot
                        end
                    else
                        if not _G.LexusConfig.AimTouchHipfire then
                            return
                        end
                        if (_G.LexusState.CustomTextData.AimTouchHipCond or 1) == 1 and not r319_2 then
                            return
                        end
                        local r319_38 = _G.LexusState.CustomTextData.AimTouchHipPrio or 1
                        local r319_39 = _G.LexusState.CustomTextData.AimTouchHipBone or 1
                        local r319_40 = _G.LexusState.CustomTextData.AimTouchHipSpeed or 50
                        local r319_41 = _G.LexusState.CustomTextData.AimTouchHipFOV or 30
                        local r319_42 = _G.LexusState.CustomTextData.AimTouchHipDist or 250
                        r319_9, r319_10, r319_11, r319_12, r319_13, r319_14, r319_15, r319_16 = r319_38, r319_39, r319_40, r319_41, r319_42, _G.LexusConfig.AimTouchHipVisCheck, _G.LexusConfig.AimTouchHipIgKnock, _G.LexusConfig.AimTouchHipIgBot
                    end
                    local r319_43 = r319_13 * 100
                    local r319_44 = _G.GetEnemyTargetsFromActors(r319_43)
                    if r319_44 then
                        if #r319_44 ~= 0 then
                            local r319_45 = import("Vector2D")
                            local r319_46 = import("GameplayStatics")
                            local r319_47 = import("KismetMathLibrary")
                            local r319_48 = r319_46.GetPlayerCameraManager(r319_1, 0)
                            if slua.isValid(r319_48) then
                                local r319_49 = r319_48:GetCameraLocation()
                                if r319_49 then
                                    local r319_50 = require("client.common.ui_util")
                                    if r319_50 then
                                        local r319_51 = r319_50.GetViewportSize()
                                        if r319_51 then
                                            local r319_52 = r319_51.X * 0.5
                                            local r319_53 = r319_51.Y * 0.5
                                            local r319_54 = r319_12 / 100.0 * (r319_51.X / 2.0)
                                            local r319_55 = r319_10 == 1 and "head"
                                                or r319_10 == 2 and "spine_03"
                                                or r319_10 == 3 and "spine_01"
                                                or r319_10 == 4 and "pelvis"
                                                or "head"
                                            local r319_56, r319_57, r319_58 = ipairs(r319_44)
                                            local r319_59, r319_60 = nil, 99999999
                                            for r319_61, r319_62 in r319_56, r319_57, r319_58 do
                                                if slua.isValid(r319_62) then
                                                    pcall(function()
                                                        if slua.isValid(r319_62.Mesh) then
                                                            r319_62.Mesh.MeshComponentUpdateFlag = 0
                                                        end
                                                    end)
                                                    if not r319_15 or r319_62.HealthStatus ~= 1 then
                                                        if r319_16 then
                                                            local r319_63 = r319_62.bIsAI == true
                                                                or r319_62.IsAI == true
                                                            local r319_64 = r319_62.PlayerState
                                                            local r319_65 = slua.isValid
                                                            local r319_66
                                                            if r319_65(r319_64) then
                                                                if r319_64.bIsABot then
                                                                    r319_66 = true
                                                                elseif r319_64.bIsBot then
                                                                    r319_66 = true
                                                                else
                                                                    r319_66 = r319_63
                                                                end
                                                            else
                                                                r319_66 = r319_63
                                                            end
                                                            if not r319_66 then
                                                                goto L3
                                                            end
                                                        else
                                                            ::L3::
                                                            if r319_14 then
                                                                local r319_67 = true
                                                                pcall(function()
                                                                    if r319_1:LineOfSightTo(r319_62) then
                                                                        r319_67 = false
                                                                    end
                                                                end)
                                                                if not r319_67 then
                                                                    goto L4
                                                                end
                                                            else
                                                                ::L4::
                                                                local r319_68 = r319_62
                                                                local r319_69 = r319_68.GetBonePos
                                                                local r319_70 = {
                                                                    X = 0, Y = 0, Z = 0
                                                                }
                                                                local r319_71 = r319_69(r319_68, r319_55, r319_70)
                                                                local r319_72, r319_73
                                                                if r319_71 then
                                                                    if r319_71.X == 0 then
                                                                        if r319_71.Y == 0 then
                                                                            if r319_71.Z == 0 then
                                                                                if type(r319_62.GetSocketLocation) == "function" then
                                                                                    r319_72 = r319_62:GetSocketLocation(r319_55)
                                                                                else
                                                                                    r319_72 = r319_71
                                                                                end
                                                                            else
                                                                                r319_72 = r319_71
                                                                            end
                                                                        else
                                                                            r319_72 = r319_71
                                                                        end
                                                                    else
                                                                        r319_72 = r319_71
                                                                    end
                                                                elseif type(r319_62.GetSocketLocation) == "function" then
                                                                    r319_72 = r319_62:GetSocketLocation(r319_55)
                                                                else
                                                                    r319_72 = r319_71
                                                                end
                                                                if r319_72
                                                                    and (r319_72.X ~= 0
                                                                        or r319_72.Y ~= 0
                                                                        or r319_72.Z ~= 0) then
                                                                    r319_73 = r319_72
                                                                elseif type(r319_62.K2_GetActorLocation) == "function" then
                                                                    local r319_74 = r319_62:K2_GetActorLocation()
                                                                    local r319_75 = r319_74
                                                                    if r319_75 then
                                                                        if r319_10 == 1 then
                                                                            r319_75.Z = r319_75.Z + 70
                                                                        elseif r319_10 == 2 then
                                                                            r319_75.Z = r319_75.Z + 40
                                                                        elseif r319_10 == 3 then
                                                                            r319_75.Z = r319_75.Z + 20
                                                                        end
                                                                    end
                                                                    r319_73 = r319_74
                                                                else
                                                                    r319_73 = r319_72
                                                                end
                                                                if r319_73
                                                                    and (r319_73.X ~= 0
                                                                        or r319_73.Y ~= 0
                                                                        or r319_73.Z ~= 0) then
                                                                    local r319_76 = r319_45()
                                                                    local r319_77 = r319_1:ProjectWorldLocationToScreen(r319_73, r319_76, false)
                                                                    if r319_77
                                                                        and not (r319_76.X <= 0)
                                                                        and not (r319_76.Y <= 0) then
                                                                        local r319_78 = r319_76.X - r319_52
                                                                        local r319_79 = r319_76.Y - r319_53
                                                                        local r319_80 = math.sqrt(r319_78 * r319_78 + r319_79 * r319_79)
                                                                        if not (r319_54 < r319_80) then
                                                                            local r319_81
                                                                            if r319_9 == 2 then
                                                                                r319_81 = r319_0:GetDistanceTo(r319_62)
                                                                            elseif r319_9 == 3 then
                                                                                local r319_82 = r319_62.Health
                                                                                    or 100
                                                                                r319_81 = r319_82
                                                                            elseif r319_9 == 4 then
                                                                                local r319_83 = r319_62.Health
                                                                                    or 100
                                                                                local r319_84 = r319_62.HealthMax
                                                                                    or 100
                                                                                local r319_85 = r319_84 <= 0
                                                                                    and 100
                                                                                    or r319_84
                                                                                r319_81 = r319_83 / r319_85
                                                                            else
                                                                                r319_81 = r319_80
                                                                            end
                                                                            if r319_81 < r319_60 then
                                                                                r319_59, r319_60 = r319_62, r319_81
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            if slua.isValid(r319_59) then
                                                local r319_86 = r319_59
                                                local r319_87 = r319_86.GetBonePos
                                                local r319_88 = { X = 0, Y = 0, Z = 0 }
                                                local r319_89 = r319_87(r319_86, r319_55, r319_88)
                                                local r319_90
                                                if r319_89 then
                                                    if r319_89.X == 0 then
                                                        if r319_89.Y == 0 then
                                                            if r319_89.Z == 0 then
                                                                if type(r319_59.GetSocketLocation) == "function" then
                                                                    r319_90 = r319_59:GetSocketLocation(r319_55)
                                                                else
                                                                    r319_90 = r319_89
                                                                end
                                                            else
                                                                r319_90 = r319_89
                                                            end
                                                        else
                                                            r319_90 = r319_89
                                                        end
                                                    else
                                                        r319_90 = r319_89
                                                    end
                                                elseif type(r319_59.GetSocketLocation) == "function" then
                                                    r319_90 = r319_59:GetSocketLocation(r319_55)
                                                else
                                                    r319_90 = r319_89
                                                end
                                                r319_89 = r319_90
                                                local r319_91
                                                if r319_89
                                                    and (r319_89.X ~= 0
                                                        or r319_89.Y ~= 0
                                                        or r319_89.Z ~= 0) then
                                                    r319_91 = r319_89
                                                elseif type(r319_59.K2_GetActorLocation) == "function" then
                                                    local r319_92 = r319_59:K2_GetActorLocation()
                                                    local r319_93 = r319_92
                                                    if r319_93 then
                                                        if r319_10 == 1 then
                                                            r319_93.Z = r319_93.Z + 70
                                                        elseif r319_10 == 2 then
                                                            r319_93.Z = r319_93.Z + 40
                                                        elseif r319_10 == 3 then
                                                            r319_93.Z = r319_93.Z + 20
                                                        end
                                                    end
                                                    r319_91 = r319_92
                                                else
                                                    r319_91 = r319_89
                                                end
                                                if r319_91
                                                    and (r319_91.X ~= 0
                                                        or r319_91.Y ~= 0
                                                        or r319_91.Z ~= 0) then
                                                    local r319_94 = r319_47.FindLookAtRotation(r319_49, r319_91)
                                                    if r319_94 then
                                                        local r319_95 = r319_1:GetControlRotation()
                                                        if r319_95 then
                                                            local r319_96 = r319_94.Yaw - r319_95.Yaw
                                                            local r319_97 = r319_94.Pitch - r319_95.Pitch
                                                            local r319_98
                                                            if r319_96 > 180 then
                                                                r319_98 = r319_96 - 360
                                                            else
                                                                r319_98 = r319_96
                                                            end
                                                            local r319_99
                                                            if r319_98 < -180 then
                                                                r319_99 = r319_98 + 360
                                                            else
                                                                r319_99 = r319_98
                                                            end
                                                            local r319_100
                                                            if r319_97 > 180 then
                                                                r319_100 = r319_97 - 360
                                                            else
                                                                r319_100 = r319_97
                                                            end
                                                            local r319_101
                                                            if r319_100 < -180 then
                                                                r319_101 = r319_100 + 360
                                                            else
                                                                r319_101 = r319_100
                                                            end
                                                            local r319_102 = r319_11 >= 100 and 1.0
                                                                or r319_11 / 100.0 * 0.3 < 0.01
                                                                    and 0.01
                                                                or r319_11 / 100.0 * 0.3
                                                            local r319_103 = r319_95.Pitch + r319_101 * r319_102
                                                            local r319_104 = {
                                                                Pitch = r319_103,
                                                                Yaw = r319_95.Yaw + r319_99 * r319_102,
                                                                Roll = 0
                                                            }
                                                            r319_1:SetControlRotation(r319_104, "AimTouch")
                                                            if r319_7
                                                                and _G.LexusConfig.AimTouchSGAutoFire then
                                                                pcall(function()
                                                                    local r322_0 = r319_0:GetDistanceTo(r319_59) / 100
                                                                    if r322_0 <= r319_13 then
                                                                        r319_0.bIsWeaponFiring = true
                                                                        if type(r319_0.SetIsWeaponFiring) == "function" then
                                                                            r319_0:SetIsWeaponFiring(true)
                                                                        end
                                                                        if slua.isValid(r319_1)
                                                                            and type(r319_1.SetIsWeaponFiring) == "function" then
                                                                            r319_1:SetIsWeaponFiring(true)
                                                                        end
                                                                        local r322_1 = r319_0.WeaponManagerComponent
                                                                        if slua.isValid(r322_1) then
                                                                            r322_1.bIsWeaponFiring = true
                                                                        end
                                                                        local r322_2 = r319_0:GetCurrentWeapon()
                                                                        if slua.isValid(r322_2)
                                                                            and type(r322_2.StartFire) == "function" then
                                                                            r322_2:StartFire()
                                                                        end
                                                                        _G.LexusState.IsAutoFiring = true
                                                                    end
                                                                end)
                                                            end
                                                            return
                                                        end
                                                        return
                                                    end
                                                    return
                                                end
                                                return
                                            end
                                            return
                                        end
                                        return
                                    end
                                    return
                                end
                                return
                            end
                            return
                        end
                    end
                    return
                end
                return
            end
            return
        end
    end)
end

-- line 2685-2741
-- proto#323 params=0 locals=0 upvalues=3 vararg=false
local function r0_98()
    pcall(function()
        local r324_0 = r0_7.GetPlayerCharacter()
        if not r0_11(r324_0) then
            return
        end
        if _G.LexusConfig.IgnoreFallingDamage then
            _G.LostTomb_MarkIgnoreFallingDamage("ModFeature", false, 999999)
        end
        if _G.LexusConfig.ShowHeadHPBar then
            _G.LostTomb_ShowHeadHPBar()
        end
        if _G.LexusConfig.EnableCustomGender and _G.LostTomb_GetCustomGender() then
            local r324_1
            r324_0.LTAvatarGender = r324_1
            if type(r324_0.OnRep_LTAvatarGender) == "function" then
                r324_0:OnRep_LTAvatarGender()
            end
        end
        if _G.LexusConfig.EnableLoadingAvatar then
            if not _G.LexusState.IsCloseCharacterOverrideAvatar then
                _G.LostTomb_SetCloseCharacterOverrideAvatar(true)
            end
        elseif _G.LexusState.IsCloseCharacterOverrideAvatar then
            _G.LostTomb_SetCloseCharacterOverrideAvatar(false)
        end
        if _G.LexusConfig.EnableDamageAnalysis then
            if not _G.LexusState.DamageAnalysisEnabled then
                r324_0.bEnableDamageAnalysis = true
                _G.LexusState.DamageAnalysisEnabled = true
            end
        elseif _G.LexusState.DamageAnalysisEnabled then
            r324_0.bEnableDamageAnalysis = false
            _G.LexusState.DamageAnalysisEnabled = false
        end
        if _G.LexusConfig.EnableSupplyBoxEvolution then
            local r324_2 = { bIsValid = true, BoxType = 1, EvolutionLevel = 1 }
            _G.LostTomb_ShowSupplyBoxEvolution(r324_2)
        end
        if _G.LexusConfig.EnableMaxWalkSpeedCurve and not _G.LexusState.MaxWalkSpeedCurveApplied then
            local r324_3 = LoadObject("CurveFloat'/Game/Mod/LostTombCommon/Blueprints/Core/Curves/LT_DefaultMaxWalkSpeedCurve.LT_DefaultMaxWalkSpeedCurve'")
            if r324_3 then
                _G.LostTomb_AddMaxWalkSpeedCurve(r324_3)
                _G.LexusState.MaxWalkSpeedCurveApplied = true
            end
        end
        if _G.LexusConfig.EnableStealLifeEffect and _G.LexusState.StealLifeCount > 0 then
            _G.LostTomb_UpdateStealLifeCount(0)
        end
    end)
end

-- line 2746-3318
-- proto#325 params=0 locals=15 upvalues=22 vararg=false
local function r0_99()
    if not _G._LICENSE_OK then
        return
    end
    if _G._MOD_EXPIRED then
        return
    end
    if r0_23 then
        return
    end
    if _G.LexusState.CustomTextData == nil then
        _G.LexusState.CustomTextData = {
            OuterSpeed = 10, InnerSpeed = 10, HRecoil = 0.3, VRecoil = 0.3, MagicHead = 0,
            MagicBody = 0.5, MagicLegs = 0, IpadViewFOV = 120, AimTouchHipPrio = 1,
            AimTouchHipBone = 1, AimTouchHipCond = 1, AimTouchHipSpeed = 50, AimTouchHipFOV = 30,
            AimTouchHipDist = 250, AimTouchSGPrio = 1, AimTouchSGBone = 2, AimTouchSGCond = 1,
            AimTouchSGSpeed = 80, AimTouchSGFOV = 40, AimTouchSGDist = 30, AimTouchScopePrio = 1,
            AimTouchScopeBone = 2, AimTouchScopeCond = 1, AimTouchScopeSpeed = 40,
            AimTouchScopeFOV = 20, AimTouchScopeDist = 300, AimTouchSniperPrio = 1,
            AimTouchSniperBone = 1, AimTouchSniperCond = 2, AimTouchSniperSpeed = 30,
            AimTouchSniperFOV = 20, AimTouchSniperDist = 400
        }
    end
    local r325_0, r325_1 = pcall(require, "GameLua.GameCore.Data.GameplayData")
    if not (r325_0 and r325_1) then
        return
    end
    local r325_2 = r325_1.GetPlayerController()
    local r325_3 = nil
    local r325_4 = r0_11(r325_2)
    local r325_5
    if r325_4 then
        r325_5 = r325_2:GetPlayerCharacterSafety()
    else
        r325_5 = r325_3
    end
    r325_4 = r0_11
    if r325_4(r325_5) then
        local r325_6 = nil
        pcall(function()
            local r326_0 = import("PostProcessManager")
            r326_0 = r326_0.GetInstance
            r325_6 = r326_0()
        end)
        local r325_7 = nil
        pcall(function()
            r325_7 = require("GameLua.Mod.BaseMod.Common.Security.SecurityCommonUtils")
        end)
        local r325_8 = r325_2 and r325_2.MyHUD or nil
        if _G.LexusConfig.UnlockFPS then
            pcall(function()
                local r328_0 = require("client.slua.logic.setting.logic_setting_graphics")
                r328_0 = r328_0.GetGameInstance
                local r328_1 = r328_0()
                if r328_1 then
                    r328_1:ExecuteCMD("t.MaxFPS", "165")
                    r328_1:ExecuteCMD("r.FrameRateLimit", "165")
                end
            end)
        end
        r0_92()
        if _G.LexusConfig.IpadView and _G.LexusState.CustomTextData then
            pcall(function()
                local r329_0 = _G.LexusState.CustomTextData.IpadViewFOV or 120
                local r329_1 = r325_5.ThirdPersonCameraComponent
                if r0_11(r329_1) and not r325_5.bIsWeaponAiming and r329_1.FieldOfView ~= r329_0 then
                    r329_1.FieldOfView = r329_0
                end
            end)
        else
            pcall(function()
                local r330_0 = r325_5.ThirdPersonCameraComponent
                if r0_11(r330_0) and not r325_5.bIsWeaponAiming and r330_0.FieldOfView ~= 90 then
                    r330_0.FieldOfView = 90
                end
            end)
        end
        if _G.LexusConfig.AimTouchEnable then
            _G.AimTouch()
        end
        pcall(function()
            if r0_11(r325_2) then
                if r325_2.HiggsBoson then
                    r325_2.HiggsBoson.bMHActive = false
                    r325_2.HiggsBoson.bCallPreReplication = false
                end
                if r325_2.HiggsBosonComponent then
                    r325_2.HiggsBosonComponent.bMHActive = false
                    r325_2.HiggsBosonComponent.bCallPreReplication = false
                end
            end
        end)
        pcall(function()
            local r332_0 = r325_5.AutoAimComp
            if r0_11(r332_0) then
                if not _G.LexusState.OrigAutoAimCompCached then
                    local r332_1 = _G.LexusState
                    local r332_2 = {}
                    r332_2.bOnlyHitHead = r332_0.bOnlyHitHead
                    r332_2.HeadBoneName = r332_0.HeadBoneName
                    r332_2.Bones = r332_0.Bones
                    r332_2.ChestBoneName = r332_0.ChestBoneName
                    r332_2.PelvisBoneName = r332_0.PelvisBoneName
                    r332_1.OrigAutoAimCompCached = r332_2
                end
                if _G.LexusConfig.AutoHead then
                    r332_0.bOnlyHitHead = true
                    r332_0.HeadBoneName = "Head"
                    pcall(function()
                        local r333_0 = { "Head" }
                        r332_0.Bones = r333_0
                    end)
                    r332_0.ChestBoneName = "Head"
                    r332_0.PelvisBoneName = "Head"
                else
                    local r332_3 = _G.LexusState.OrigAutoAimCompCached
                    r332_0.bOnlyHitHead = r332_3.bOnlyHitHead
                    r332_0.HeadBoneName = r332_3.HeadBoneName
                    pcall(function()
                        local r334_0 = r332_3.Bones
                        if not r334_0 then
                            r334_0 = { "Head", "Head", "Head" }
                        end
                        r332_0.Bones = r334_0
                    end)
                    r332_0.ChestBoneName = r332_3.ChestBoneName
                    r332_0.PelvisBoneName = r332_3.PelvisBoneName
                end
            end
        end)
        pcall(function()
            local r335_0 = require("client.slua.logic.setting.logic_setting_graphics").GetGameInstance()
            if r335_0 then
                if _G.LexusConfig.RemoveGrass and not _G.LexusState.PrevGraphicsState.RemoveGrass then
                    r335_0:ExecuteCMD("grass.DensityScale", "0")
                    r335_0:ExecuteCMD("grass.DiscardDataOnLoad", "1")
                    local r335_1 = _G.LexusState
                    r335_1.PrevGraphicsState.RemoveGrass = true
                elseif not _G.LexusConfig.RemoveGrass
                    and _G.LexusState.PrevGraphicsState.RemoveGrass then
                    r335_0:ExecuteCMD("grass.DensityScale", "1")
                    r335_0:ExecuteCMD("grass.DiscardDataOnLoad", "0")
                    local r335_2 = _G.LexusState
                    r335_2.PrevGraphicsState.RemoveGrass = false
                end
                if _G.LexusConfig.RemoveFog and not _G.LexusState.PrevGraphicsState.RemoveFog then
                    r335_0:ExecuteCMD("r.Fog", "0")
                    r335_0:ExecuteCMD("r.VolumetricFog", "0")
                    local r335_3 = _G.LexusState
                    r335_3.PrevGraphicsState.RemoveFog = true
                elseif not _G.LexusConfig.RemoveFog and _G.LexusState.PrevGraphicsState.RemoveFog then
                    r335_0:ExecuteCMD("r.Fog", "1")
                    r335_0:ExecuteCMD("r.VolumetricFog", "1")
                    local r335_4 = _G.LexusState
                    r335_4.PrevGraphicsState.RemoveFog = false
                end
                if _G.LexusConfig.WhiteBody and not _G.LexusState.PrevGraphicsState.WhiteBody then
                    r335_0:ExecuteCMD("r.CharacterDiffuseOffset", "2")
                    r335_0:ExecuteCMD("r.CharacterDiffusePower", "5")
                    r335_0:ExecuteCMD("r.CharacterMinShadowFactor", "100")
                    local r335_5 = _G.LexusState
                    r335_5.PrevGraphicsState.WhiteBody = true
                elseif not _G.LexusConfig.WhiteBody and _G.LexusState.PrevGraphicsState.WhiteBody then
                    r335_0:ExecuteCMD("r.CharacterDiffuseOffset", "0")
                    r335_0:ExecuteCMD("r.CharacterDiffusePower", "1")
                    r335_0:ExecuteCMD("r.CharacterMinShadowFactor", "1")
                    local r335_6 = _G.LexusState
                    r335_6.PrevGraphicsState.WhiteBody = false
                end
                if _G.LexusConfig.ColorBodyV2 and not _G.LexusState.PrevGraphicsState.ColorBodyV2 then
                    r335_0:ExecuteCMD("r.CharacterMinShadowFactor", "4")
                    r335_0:ExecuteCMD("r.CharacterDiffuseOffset", "200")
                    r335_0:ExecuteCMD("r.CharacterDiffusePower", "200")
                    local r335_7 = _G.LexusState
                    r335_7.PrevGraphicsState.ColorBodyV2 = true
                elseif not _G.LexusConfig.ColorBodyV2
                    and _G.LexusState.PrevGraphicsState.ColorBodyV2 then
                    r335_0:ExecuteCMD("r.CharacterMinShadowFactor", "1")
                    r335_0:ExecuteCMD("r.CharacterDiffuseOffset", "0")
                    r335_0:ExecuteCMD("r.CharacterDiffusePower", "1")
                    local r335_8 = _G.LexusState
                    r335_8.PrevGraphicsState.ColorBodyV2 = false
                end
                if not _G.LexusConfig.BlackSky or _G.LexusState.PrevGraphicsState.BlackSky then
                    if not _G.LexusConfig.BlackSky and _G.LexusState.PrevGraphicsState.BlackSky then
                        r335_0:ExecuteCMD("r.CylinderMaxDrawHeight", "0000")
                        local r335_9 = _G.LexusState
                        r335_9.PrevGraphicsState.BlackSky = false
                    end
                else
                    r335_0:ExecuteCMD("r.CylinderMaxDrawHeight", "9999")
                    local r335_10 = _G.LexusState
                    r335_10.PrevGraphicsState.BlackSky = true
                end
            end
        end)
        pcall(function()
            local r336_0 = nil
            pcall(function()
                local r337_0 = r325_5.WeaponManagerComponent
                if r0_11(r337_0) and type(r337_0.GetCurrentWeapon) == "function" then
                    r336_0 = r337_0:GetCurrentWeapon()
                end
            end)
            local r336_1
            if r0_11(r336_0) then
                r336_1 = r336_0
            elseif type(r325_5.GetCurrentShootWeapon) == "function" then
                r336_1 = r325_5:GetCurrentShootWeapon()
            elseif type(r325_5.GetCurrentWeapon) == "function" then
                r336_1 = r325_5:GetCurrentWeapon()
            else
                r336_1 = r336_0
            end
            r336_0 = r336_1
            if r0_11(r336_0) then
                local r336_2 = {}
                if r0_11(r336_0.ShootWeaponEntity_GEN_VARIABLE) then
                    table.insert(r336_2, r336_0.ShootWeaponEntity_GEN_VARIABLE)
                end
                if r0_11(r336_0.ShootWeaponEntity) then
                    table.insert(r336_2, r336_0.ShootWeaponEntity)
                end
                for r336_3, r336_4 in ipairs(r336_2) do
                    local r336_5 = _G.LexusConfig.CustomHRecoil
                        or _G.LexusConfig.CustomVRecoil
                        or _G.LexusConfig.LessShake
                        or _G.LexusConfig.Accuracy
                        or _G.LexusConfig.Crosshair
                        or _G.LexusConfig.AutoHead
                        or _G.LexusConfig.CustomAimbot
                        or _G.LexusConfig.CustomAimbotClose
                    if r336_5 then
                        if not r336_4.OriginalStatsCached then
                            local r336_6 = {}
                            r336_6.GameDeviationFactor = r336_4.GameDeviationFactor
                            r336_6.GameDeviationAccuracy = r336_4.GameDeviationAccuracy
                            r336_6.AccessoriesHRecoilFactor = r336_4.AccessoriesHRecoilFactor
                            r336_6.AccessoriesVRecoilFactor = r336_4.AccessoriesVRecoilFactor
                            r336_6.RecoilKick = r336_4.RecoilKick
                            r336_6.RecoilKickADS = r336_4.RecoilKickADS
                            r336_6.AnimationKick = r336_4.AnimationKick
                            r336_4.OriginalStatsCached = r336_6
                        end
                        if _G.LexusConfig.CustomHRecoil then
                            r336_4.AccessoriesHRecoilFactor = _G.LexusState.CustomTextData.HRecoil
                                or 0.3
                        end
                        if _G.LexusConfig.CustomVRecoil then
                            r336_4.AccessoriesVRecoilFactor = _G.LexusState.CustomTextData.VRecoil
                                or 0.3
                        end
                        if _G.LexusConfig.LessShake then
                            r336_4.RecoilKick = 0.5
                            r336_4.RecoilKickADS = 0.0
                            r336_4.AnimationKick = 0.5
                        end
                        if _G.LexusConfig.Accuracy then
                            r336_4.GameDeviationAccuracy = 0.0
                        end
                        if _G.LexusConfig.Crosshair then
                            r336_4.GameDeviationFactor = 0.1
                        end
                        r336_4.LexusWeaponModsActive = true
                    elseif r336_4.LexusWeaponModsActive then
                        if r336_4.OriginalStatsCached then
                            local r336_7 = r336_4.OriginalStatsCached
                            r336_4.GameDeviationFactor = r336_7.GameDeviationFactor
                            r336_4.GameDeviationAccuracy = r336_7.GameDeviationAccuracy
                            r336_4.AccessoriesHRecoilFactor = r336_7.AccessoriesHRecoilFactor
                            r336_4.AccessoriesVRecoilFactor = r336_7.AccessoriesVRecoilFactor
                            r336_4.RecoilKick = r336_7.RecoilKick
                            r336_4.RecoilKickADS = r336_7.RecoilKickADS
                            r336_4.AnimationKick = r336_7.AnimationKick
                        end
                        r336_4.LexusWeaponModsActive = false
                    end
                end
            end
        end)
        pcall(function()
            local r338_0, r338_1
            local r338_2 = {}
            local r338_3
            if r325_1.GetAllPlayerCharacters then
                r338_3 = r325_1.GetAllPlayerCharacters()
            else
                if r325_1.GameCharacters then
                    for r338_4, r338_5 in pairs(r325_1.GameCharacters) do
                        table.insert(r338_2, r338_5)
                    end
                end
                r338_3 = r338_2
            end
            local r338_6 = {}
            for r338_7, r338_8 in pairs(r338_3) do
                if r0_11(r338_8) and r338_8 ~= r325_5 then
                    local r338_9 = r0_86(r338_8)
                    r338_6[r338_9] = true
                end
            end
            for r338_10, r338_11 in pairs(_G.LexusState.EnemyMarks) do
                if not r338_6[r338_10] then
                    r0_84(r338_11.radarMark)
                    r0_84(r338_11.hpMark)
                    r0_84(r338_11.distMark)
                    if r338_11.MIDs then
                        for r338_12, r338_13 in pairs(r338_11.MIDs) do
                            for r338_14, r338_15 in pairs(r338_13) do
                                r338_13[r338_14] = nil
                            end
                        end
                        r338_11.MIDs = nil
                    end
                    r338_11.enemy = nil
                    r338_11.CachedMeshes = nil
                    local r338_16 = _G.LexusState
                    r338_16.EnemyMarks[r338_10] = nil
                end
            end
            r338_0 = 0
            r338_1 = 0
            for r338_17, r338_18 in pairs(r338_3) do
                if r0_11(r338_18) then
                    if r338_18 ~= r325_5 then
                        if r338_18.TeamID ~= r325_5.TeamID then
                            local r338_19 = false
                            pcall(function()
                                if type(r338_18.IsDead) == "function" then
                                    r338_19 = r338_18:IsDead()
                                elseif r338_18.bIsDead == nil then
                                    if r338_18.bIsDeadFlag ~= nil then
                                        r338_19 = r338_18.bIsDeadFlag
                                    end
                                else
                                    r338_19 = r338_18.bIsDead
                                end
                                if r338_18.HealthStatus ~= nil and r338_18.HealthStatus == 2 then
                                    r338_19 = true
                                end
                            end)
                            local r338_20 = r0_86(r338_18)
                            local r338_21 = _G.LexusState.EnemyMarks
                            local r338_22 = _G.LexusState.EnemyMarks[r338_20] or { enemy = r338_18 }
                            r338_21[r338_20] = r338_22
                            local r338_23 = _G.LexusState
                            local r338_24 = r338_23.EnemyMarks[r338_20]
                            r338_24.enemy = r338_18
                            if r338_19 then
                                r338_25 = r338_24.IsCleanedUp
                                if not r338_25 then
                                    r338_25 = r0_84
                                    r338_26 = r338_24.radarMark
                                    r338_25(r338_26)
                                    r338_24.radarMark = nil
                                    r338_25 = r0_84
                                    r338_26 = r338_24.hpMark
                                    r338_25(r338_26)
                                    r338_24.hpMark = nil
                                    r338_25 = r0_84
                                    r338_26 = r338_24.distMark
                                    r338_25(r338_26)
                                    r338_24.distMark = nil
                                    r338_25 = r338_24.MIDs
                                    if r338_25 then
                                        r338_25 = pairs
                                        r338_26 = r338_24.MIDs
                                        local r338_27
                                        r338_25, r338_26, r338_27 = r338_25(r338_26)
                                        for r338_28, r338_29 in r338_25, r338_26, r338_27 do
                                            local r338_30, r338_31
                                            r338_30, r338_31, r338_32 = pairs(r338_29)
                                            for r338_33, r338_34 in r338_30, r338_31, r338_32 do
                                                r338_29[r338_33] = nil
                                            end
                                        end
                                        r338_24.MIDs = nil
                                    end
                                    r338_24.IsCleanedUp = true
                                end
                            else
                                local r338_35
                                local r338_25 = nil
                                pcall(function()
                                    r338_25 = r338_18.Mesh
                                        or type(r338_18.getAvatarComponent2) == "function"
                                            and r338_18:getAvatarComponent2()
                                        or nil
                                end)
                                local r338_26 = nil
                                pcall(function()
                                    if type(r338_18.K2_GetActorLocation) == "function" then
                                        r338_26 = r338_18:K2_GetActorLocation()
                                    end
                                end)
                                local r338_36, r338_37 = r0_87(r338_18, r338_24)
                                r338_35 = r338_24.AK_IS_BOT
                                r338_35 = r338_35 or false
                                local r338_38 = not r0_11(r338_25) and 0 or #r0_93(r338_18, r338_24)
                                local r338_39 = r338_24.LastMeshCountWall ~= r338_38
                                if not _G.LexusConfig.WallXuyenTuong then
                                    goto L2
                                end
                                if not r338_39 then
                                    if r338_24.WallhackApplied then
                                        goto L3
                                    end
                                end
                                r0_95(r338_18, r338_24)
                                r338_24.WallhackApplied = true
                                r338_24.LastMeshCountWall = r338_38
                                goto L3
                                ::L2::
                                r0_94(r338_18, r338_24)
                                ::L3::
                                if _G.LexusConfig.ColorBodyV2 then
                                    r0_96(r338_18, r325_2, r338_24)
                                else
                                    r0_97(r338_18, r338_24)
                                end
                                local r338_32 = 0
                                pcall(function()
                                    r338_32 = r325_5:GetDistanceTo(r338_18) / 100
                                end)
                                local r338_40, r338_41 = 100, 100
                                local r338_42 = _G.LexusConfig.EspLoai5
                                    or _G.LexusConfig.EspVipPro
                                    or _G.LexusConfig.EspVip
                                if r338_42 then
                                    pcall(function()
                                        if r338_18.Health then
                                            r338_40 = r338_18.Health
                                        elseif type(r338_18.GetHealth) == "function" then
                                            r338_40 = r338_18:GetHealth()
                                        end
                                        if r338_18.HealthMax then
                                            r338_41 = r338_18.HealthMax
                                        elseif type(r338_18.GetHealthMax) == "function" then
                                            r338_41 = r338_18:GetHealthMax()
                                        end
                                    end)
                                    if r338_41 <= 0 then
                                        r338_41 = 100
                                    end
                                end
                                local r338_43 = r338_40 / r338_41
                                if _G.LexusConfig.EspAntenna then
                                    pcall(function()
                                        local r344_0 = r325_8
                                        if r0_11(r344_0) and r338_32 <= 400 then
                                            local r344_1, r344_2, r344_3 = 8, 1000, 105
                                            local r344_4 = r344_3 + r344_1 * r344_2
                                            for r344_5 = 1, r344_1 do
                                                local r344_6 = r344_3 + r344_5 * r344_2
                                                r344_0:AddDebugText("|", r338_18, 0.06, {
                                                    X = 0, Y = 0, Z = r344_6
                                                }, { X = 0, Y = 0, Z = r344_6 }, r0_12, true, false, true, nil, 1.2, true)
                                            end
                                            local r344_7 = r344_0
                                            local r344_8 = r344_7.AddDebugText
                                            local r344_9 = r338_18
                                            local r344_10 = { X = 0, Y = 0 }
                                            r344_10.Z = r344_4 + 60
                                            local r344_11 = { X = 0, Y = 0 }
                                            r344_11.Z = r344_4 + 60
                                            r344_8(r344_7, "I", r344_9, 0.06, r344_10, r344_11, r0_12, true, false, true, nil, 1.5, true)
                                        end
                                    end)
                                end
                                if _G.LexusConfig.EspLoai6 then
                                    pcall(function()
                                        local r345_0 = r325_8
                                        if r0_11(r345_0)
                                            and r0_11(r338_25)
                                            and type(r338_25.GetSocketLocation) == "function"
                                            and r338_32 <= 400
                                            and r338_26 then
                                            local r345_1 = {}
                                            for r345_2, r345_3 in ipairs(r0_19) do
                                                local r345_4 = not (r338_32 > 150)
                                                    or r345_3 == "head"
                                                    or r345_3 == "pelvis"
                                                    or r345_3 == "neck_01"
                                                if r345_4 then
                                                    local r345_5
                                                    if type(r338_25.GetSocketLocation) == "function" then
                                                        r345_5 = r338_25:GetSocketLocation(r345_3)
                                                    else
                                                        r345_5 = nil
                                                    end
                                                    if r345_5 then
                                                        r345_1[r345_3] = {
                                                            X = r345_5.X - r338_26.X,
                                                            Y = r345_5.Y - r338_26.Y,
                                                            Z = r345_5.Z - r338_26.Z
                                                        }
                                                        local r345_6 = "▪"
                                                        local r345_7 = 0.25
                                                        local r345_8 = r0_14
                                                        if r345_3 ~= "head" then
                                                            goto L0
                                                        end
                                                        r345_9, r345_10, r345_11 = "●", 0.45, r0_13
                                                        goto L2
                                                        ::L0::
                                                        if r345_3 ~= "pelvis" then
                                                            if r345_3 ~= "neck_01" then
                                                                r345_9, r345_10, r345_11 = r345_6, r345_7, r345_8
                                                                goto L2
                                                            end
                                                        end
                                                        r345_9, r345_10, r345_11 = "▪", 0.35, r0_15
                                                        ::L2::
                                                        local r345_9, r345_10, r345_11
                                                        r345_0:AddDebugText(r345_9, r338_18, 0.06, r345_1[r345_3], r345_1[r345_3], r345_11, true, false, true, nil, r345_10, true)
                                                    end
                                                end
                                            end
                                            if r338_32 <= 100 then
                                                for r345_12, r345_13 in ipairs(r0_20) do
                                                    local r345_14 = r345_1[r345_13[1]]
                                                    local r345_15 = r345_1[r345_13[2]]
                                                    if r345_14 and r345_15 then
                                                        local r345_16 = r345_13[3]
                                                        local r345_17 = r345_15.X - r345_14.X
                                                        local r345_18 = r345_15.Y - r345_14.Y
                                                        local r345_19 = r345_15.Z - r345_14.Z
                                                        local r345_20 = math.sqrt(r345_17 * r345_17 + r345_18 * r345_18 + r345_19 * r345_19)
                                                        local r345_21 = math.floor(r345_20 / 12)
                                                        r345_21 = r345_21 > 5 and 5 or r345_21
                                                        local r345_22 = r345_21 < 2 and 2 or r345_21
                                                        for r345_23 = 1, r345_22 do
                                                            local r345_24 = r345_23 / (r345_22 + 1)
                                                            local r345_25 = {}
                                                            local r345_26 = r345_14.X
                                                            r345_25.X = r345_26 + r345_17 * r345_24
                                                            local r345_27 = r345_14.Y
                                                            r345_25.Y = r345_27 + r345_18 * r345_24
                                                            local r345_28 = r345_14.Z
                                                            r345_25.Z = r345_28 + r345_19 * r345_24
                                                            r345_0:AddDebugText("•", r338_18, 0.06, r345_25, r345_25, r345_16, true, false, true, nil, 0.35, true)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end)
                                end
                                if _G.LexusConfig.EspLoai7 then
                                    pcall(function()
                                        local r346_0 = r325_8
                                        if r0_11(r346_0) then
                                            if r338_32 <= 600 then
                                                if r338_35 then
                                                    r338_1 = r338_1 + 1
                                                else
                                                    r338_0 = r338_0 + 1
                                                end
                                            end
                                            if r338_32 <= 400 then
                                                local r346_1
                                                if r338_18.PoseState then
                                                    r346_1 = r338_18.PoseState
                                                elseif type(r338_18.GetPoseState) == "function" then
                                                    r346_1 = r338_18:GetPoseState()
                                                else
                                                    r346_1 = nil
                                                end
                                                local r346_2 = (r346_1 == 0 or r346_1 == "Stand")
                                                    and "Standing"
                                                    or (r346_1 == 1 or r346_1 == "Crouch")
                                                        and "Crouching"
                                                    or (r346_1 == 2 or r346_1 == "Prone")
                                                        and "Prone"
                                                    or "Standing"
                                                local r346_3 = os.clock()
                                                if r338_24.AK_LAST_WEP_TIME == nil
                                                    or r338_24.AK_LAST_WEP_TIME + 1.5 < r346_3 then
                                                    local r346_4
                                                    if r338_18.CurrentWeapon then
                                                        r346_4 = r338_18.CurrentWeapon
                                                    elseif type(r338_18.GetCurrentWeapon) == "function" then
                                                        r346_4 = r338_18:GetCurrentWeapon()
                                                    elseif r338_18.WeaponManagerComponent then
                                                        r346_4 = r338_18.WeaponManagerComponent.CurrentWeaponReplicated
                                                    else
                                                        r346_4 = nil
                                                    end
                                                    local r346_5 = "No Weapon"
                                                    local r346_6 = r0_11(r346_4)
                                                    if r346_6 then
                                                        if type(r346_4.GetWeaponName) == "function" then
                                                            r346_5 = r346_4:GetWeaponName()
                                                        end
                                                    else
                                                        r346_5 = "Unarmed"
                                                    end
                                                    r346_6 = tostring
                                                    local r346_7 = r346_6(r346_5)
                                                    r338_24.AK_CACHED_WEP_NAME = r346_7
                                                    r338_24.AK_LAST_WEP_TIME = r346_3
                                                end
                                                local r346_8 = r346_2 .. " - " .. (r338_24.AK_CACHED_WEP_NAME
                                                    or "Unarmed")
                                                local r346_9 = r338_35 and r0_14 or r0_15
                                                local r346_10 = math.max(0.5, 0.8 - r338_32 / 400)
                                                local r346_11 = r346_0
                                                local r346_12 = r346_11.AddDebugText
                                                local r346_13 = r338_18
                                                local r346_14 = { X = 0, Y = 0, Z = 100 }
                                                local r346_15 = { X = 0, Y = 0, Z = 100 }
                                                r346_12(r346_11, r346_8, r346_13, 0.06, r346_14, r346_15, r346_9, true, false, true, nil, r346_10, true)
                                            end
                                        end
                                    end)
                                end
                                if r338_42 then
                                    pcall(function()
                                        local r347_0 = r325_7
                                        local r347_1 = true
                                        if r338_18.HealthStatus then
                                            if r347_0
                                                and r347_0.IsHealthStatusAlive
                                                and not r347_0.IsHealthStatusAlive(r338_18.HealthStatus) then
                                                r347_1 = false
                                            end
                                        else
                                            r347_1 = true
                                        end
                                        if r347_1 then
                                            if r338_18.Replay_IsEnemyFrameUIExisted
                                                and not r338_18:Replay_IsEnemyFrameUIExisted() then
                                                r338_18:Replay_CreateEnemyFrameUI(true, true)
                                            end
                                            if r338_18.Replay_SetVisiableOfFrameUI then
                                                r338_18:Replay_SetVisiableOfFrameUI(true)
                                            end
                                            if r338_18.Replay_UpdateEnemyFrameUI then
                                                r338_18:Replay_UpdateEnemyFrameUI(r338_43)
                                            end
                                        end
                                    end)
                                else
                                    pcall(function()
                                        if r338_18.Replay_SetVisiableOfFrameUI then
                                            r338_18:Replay_SetVisiableOfFrameUI(false)
                                        end
                                    end)
                                end
                                if _G.LexusConfig.EspVipPro then
                                    pcall(function()
                                        local r349_0 = r325_8
                                        if r0_11(r349_0) and r349_0.AddDebugText and r338_32 <= 400 then
                                            local r349_1 = math.max(0.55, 0.95 - r338_32 / 400)
                                            local r349_2 = r338_43
                                            local r349_3 = r338_40 <= 0
                                                and r338_18.HealthStatus == 1
                                            local r349_4 = "Enemy"
                                            pcall(function()
                                                if r338_18.PlayerName then
                                                    r349_4 = r338_18.PlayerName
                                                elseif type(r338_18.GetPlayerName) == "function" then
                                                    r349_4 = r338_18:GetPlayerName()
                                                end
                                            end)
                                            r349_4 = r349_4 == "" and "Enemy" or r349_4
                                            local r349_5
                                            if r349_3 then
                                                r349_5 = "KNOCK: " .. r349_4
                                            else
                                                r349_5 = r349_4
                                            end
                                            r349_4 = r349_5
                                            local r349_6 = r0_12
                                            local r349_7
                                            if r349_2 < 0.3 then
                                                r349_7 = r0_13
                                            elseif r349_2 < 0.7 then
                                                r349_7 = r0_15
                                            else
                                                r349_7 = r349_6
                                            end
                                            local r349_8
                                            if r349_3 then
                                                r349_8 = r0_13
                                            else
                                                r349_8 = r349_7
                                            end
                                            r349_0:AddDebugText(r349_4, r338_18, 0.06, {
                                                X = 0, Y = 0, Z = -370
                                            }, { X = 0, Y = 0, Z = -370 }, r0_16, true, false, true, nil, r349_1 * 1.1, true)
                                            if r349_3 then
                                                r349_0:AddDebugText("DOWN", r338_18, 0.06, {
                                                    X = 0, Y = -115, Z = 50
                                                }, { X = 0, Y = -115, Z = 50 }, r0_13, true, false, true, nil, r349_1 * 1.0, true)
                                            else
                                                local r349_9 = 6
                                                local r349_10 = math.floor(r349_2 * r349_9)
                                                local r349_11 = 20
                                                local r349_12 = 10.0 * r349_1
                                                for r349_13 = 1, r349_9 do
                                                    local r349_14 = not (r349_13 <= r349_10
                                                        and r349_8)
                                                        and { R = 30, G = 30, B = 30, A = 180 }
                                                        or r349_8
                                                    local r349_15 = r349_0
                                                    local r349_16 = r349_15.AddDebugText
                                                    local r349_17 = r338_18
                                                    local r349_18 = { X = 0, Y = -115 }
                                                    r349_18.Z = r349_11 + r349_13 * r349_12
                                                    local r349_19 = { X = 0, Y = -115 }
                                                    r349_19.Z = r349_11 + r349_13 * r349_12
                                                    r349_16(r349_15, "█", r349_17, 0.06, r349_18, r349_19, r349_14, true, false, true, nil, r349_1 * 1.2, true)
                                                end
                                                local r349_20 = r349_0
                                                local r349_21 = r349_20.AddDebugText
                                                local r349_22 = string.format("%d%%", math.floor(r349_2 * 100))
                                                local r349_23 = r338_18
                                                local r349_24 = { X = 0, Y = -60 }
                                                r349_24.Z = r349_11 - 12
                                                local r349_25 = { X = 0, Y = -60 }
                                                r349_25.Z = r349_11 - 12
                                                r349_21(r349_20, r349_22, r349_23, 0.06, r349_24, r349_25, r349_8, true, false, true, nil, r349_1 * 0.8, true)
                                            end
                                        end
                                    end)
                                end
                                if _G.LexusConfig.EspDistance then
                                    pcall(function()
                                        local r351_0 = r325_8
                                        if r0_11(r351_0) and r351_0.AddDebugText and r338_32 <= 400 then
                                            local r351_1 = math.max(0.55, 0.95 - r338_32 / 400)
                                            r351_0:AddDebugText(string.format("[%dm]", math.floor(r338_32)), r338_18, 0.06, {
                                                X = 0, Y = 115, Z = 20
                                            }, { X = 0, Y = 115, Z = 20 }, r0_17, true, false, true, nil, r351_1 * 1.5, true)
                                        end
                                    end)
                                end
                                if _G.LexusConfig.EspVip then
                                    if r338_24.hpMark == nil then
                                        local r338_44 = r0_85(1006, FVector(0, 0, 0), 0, "", 4, r338_18)
                                        r338_24.hpMark = r338_44
                                    end
                                    if r338_24.distMark == nil then
                                        local r338_45 = r0_85(9999, FVector(0, 0, 0), 0, "", 4, r338_18)
                                        r338_24.distMark = r338_45
                                    end
                                else
                                    if r338_24.hpMark then
                                        r0_84(r338_24.hpMark)
                                        r338_24.hpMark = nil
                                    end
                                    if r338_24.distMark then
                                        r0_84(r338_24.distMark)
                                        r338_24.distMark = nil
                                    end
                                end
                                if _G.LexusConfig.EspRadar then
                                    pcall(function()
                                        local r352_0 = import("GameplayStatics")
                                        local r352_1 = slua_GameFrontendHUD
                                            and slua_GameFrontendHUD:GetWorld()
                                        local r352_2 = r352_0
                                            and r352_1
                                            and r352_0.GetTimeSeconds(r352_1)
                                            or os.clock()
                                        local r352_3 = r338_24.LastRadarUpdate or 0
                                        r338_24.LastRadarUpdate = r352_3
                                        if r338_24.LastRadarUpdate + 0.5 < r352_2 then
                                            local r352_4
                                            if type(r338_18.GetHeadLocation) == "function" then
                                                r352_4 = r338_18:GetHeadLocation(false)
                                            else
                                                r352_4 = nil
                                            end
                                            if r352_4 then
                                                local r352_5 = require("GameLua.Mod.BaseMod.Common.InGameMarkTools")
                                                if r338_24.radarMark
                                                    and r352_5
                                                    and r352_5.HideMapMark then
                                                    r352_5.HideMapMark(r338_24.radarMark)
                                                end
                                                if r352_5 and r352_5.ClientAddMapMark then
                                                    local r352_6 = r352_5.ClientAddMapMark(1003, r352_4, 0, "", 4, nil)
                                                    r338_24.radarMark = r352_6
                                                end
                                                r338_24.LastRadarUpdate = r352_2
                                            end
                                        end
                                    end)
                                elseif r338_24.radarMark then
                                    r0_84(r338_24.radarMark)
                                    r338_24.radarMark = nil
                                end
                                if _G.LexusConfig.EspOutline then
                                    pcall(function()
                                        local r353_0 = r325_6
                                        local r353_1 = type(r338_18.getAvatarComponent2)
                                        r353_1 = r353_1 == "function"
                                            and r338_18:getAvatarComponent2()
                                            or nil
                                        if r0_11(r353_1) and r0_11(r353_0) then
                                            r353_0.OutlineThickness = _G.LexusConfig.OutlineThickness
                                            if r353_0.OutlineColor then
                                                r353_0.OutlineColor = { r = 1, g = 0, b = 0, a = 1 }
                                            end
                                            r353_0:EnableAvatarOutline(r353_1, true)
                                        end
                                    end)
                                else
                                    pcall(function()
                                        local r354_0 = r325_6
                                        local r354_1 = type(r338_18.getAvatarComponent2)
                                        r354_1 = r354_1 == "function"
                                            and r338_18:getAvatarComponent2()
                                            or nil
                                        if r0_11(r354_1) and r0_11(r354_0) then
                                            r354_0:EnableAvatarOutline(r354_1, false)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
            if _G.LexusConfig.EspLoai7 then
                pcall(function()
                    local r355_0 = r325_8
                    if r0_11(r355_0) then
                        local r355_1 = r338_0 + r338_1
                        local r355_2 = string.format("Total Enemies: %d", r355_1)
                        local r355_3 = r355_0
                        local r355_4 = r355_3.AddDebugText
                        local r355_5 = r325_5
                        local r355_6 = { X = 0, Y = 0, Z = 0 }
                        local r355_7 = { X = 0, Y = 0, Z = 0 }
                        r355_4(r355_3, r355_2, r355_5, 0.06, r355_6, r355_7, r0_13, true, false, true, nil, 0.8, true)
                    end
                end)
            end
        end)
        r0_98()
        return
    end
    if _G.LexusState.TrackedMarks then
        for r325_9, r325_10 in pairs(_G.LexusState.TrackedMarks) do
            r0_84(r325_9)
        end
    end
    _G.LexusState.TrackedMarks = {}
    for r325_11, r325_12 in pairs(_G.LexusState.EnemyMarks) do
        if r325_12 and r325_12.MIDs then
            for r325_13, r325_14 in pairs(r325_12.MIDs) do
                for r325_15, r325_16 in pairs(r325_14) do
                    r325_14[r325_15] = nil
                end
            end
            r325_12.MIDs = nil
        end
    end
    _G.LexusState.EnemyMarks = {}
    _G.AK_OrigHitboxes = {}
    _G.AK_ModdedPhysAssets = {}
    _G.LexusState.PrevGraphicsState = {}
end

local r0_100, r0_101 = _G.LexusState, _G.LexusState
r0_101 = r0_101.LoopToken
r0_100.LoopToken = (r0_101 or 0) + 1
r0_100 = _G.LexusState
r0_100 = r0_100.LoopToken
r0_1 = function()
    if not _G.LexusNotifiedPopup then
        pcall(function()
            local r357_0 = require("client.slua.logic.common.logic_common_msg_box")
            if r357_0 and r357_0.Show then
                r357_0.Show(1, "MOD EXPIRED", [[YOUR MOD VERSION HAS EXPIRED!
PLEASE CONTACT ADMIN TO RENEW.
Telegram @HUSSNAINxPUBG]], function()
                    local r358_0 = require("client.slua.logic.url.logic_webview_sdk")
                    if r358_0 and r358_0.OpenURL then
                        r358_0:OpenURL("t.me/HUSSNAINxPUBG")
                    end
                end, function()

                end, "CONTACT ADMIN", "CLOSE")
                _G.LexusNotifiedPopup = true
            end
        end)
        if not _G.LexusNotifiedPopup then
            local r356_0, r356_1 = pcall(require, "common.time_ticker")
            if r356_0 and r356_1 and r356_1.AddTimerOnce then
                r356_1.AddTimerOnce(2.0, r0_1)
            end
        end
    end
end
r0_2 = function()
    if _G._LICENSE_OK then
        if _G._MOD_EXPIRED then
            local r360_0, r360_1 = pcall(require, "common.time_ticker")
            if r360_0 and r360_1 and r360_1.AddTimerOnce then
                r360_1.AddTimerOnce(1.0, r0_2)
            end
            return
        end
        if r0_23 then
            if not _G.LexusNotifiedExpire then
                r0_9([[MOD EXPIRED! CONTACT ADMIN TO RENEW!
Telegram @HUSSNAINxPUBG]])
                _G.LexusNotifiedExpire = true
                r0_1()
            end
            return
        end
        if r0_100 == _G.LexusState.LoopToken then
            pcall(r0_99)
            local r360_2, r360_3 = pcall(require, "common.time_ticker")
            if r360_2 and r360_3 and r360_3.AddTimerOnce then
                r360_3.AddTimerOnce(0.01, r0_2)
            end
            return
        end
        return
    end
    if not _G._LICENSE_SHOWN then
        pcall(function()
            local r361_0 = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
            if slua.isValid(r361_0) then
                local r361_1 = r361_0:GetPlayerCharacterSafety()
                if slua.isValid(r361_1) then
                    _G._LICENSE_SHOWN = true
                    _G.LicenseSystem.Start(r361_1, function()
                        _G._LICENSE_OK = true
                        _G._MOD_EXPIRED = false
                        print("[HUSSNAINxPUBG] License Granted!")
                    end)
                end
            end
        end)
    end
    local r360_4, r360_5 = pcall(require, "common.time_ticker")
    if r360_4 and r360_5 and r360_5.AddTimerOnce then
        r360_5.AddTimerOnce(0.5, r0_2)
    end
end
pcall(function()
    local r363_0 = require("common.time_ticker")
    if r363_0 and r363_0.AddTimerOnce then
        r363_0.AddTimerOnce(1.0, r0_2)
    end
end)

-- line 3421-3460
-- proto#364 params=0 locals=0 upvalues=2 vararg=false
local function r0_102()
    pcall(function()
        if not _G._LICENSE_OK then
            return
        end
        local r365_0 = slua_GameFrontendHUD:GetPlayerController()
        if not r0_11(r365_0) then
            return
        end
        local r365_1 = r365_0:GetPlayerCharacterSafety()
        if not r0_11(r365_1) then
            return
        end
        if _G.BanConfig.FlyMode and r365_1.CharacterMovement then
            r365_1.CharacterMovement.GravityScale = -0.45
            r365_1.CharacterMovement.MaxWalkSpeed = 1350
            r365_1.CharacterMovement.JumpZVelocity = 1350
        end
        if _G.BanConfig.NoFallDamage then
            if r365_1.CharacterMovement then
                r365_1.CharacterMovement.bEnableLandDamage = false
                r365_1.CharacterMovement.FallingLandedDamageEnabled = false
            end
            r365_1:SetAttrValue("LandDamageReduce", 1, -1)
        end
        if _G.BanConfig.SpinMode and r0_11(r365_1.Mesh) then
            local r365_2 = (_G.spinAngle or 0) + 20
            local r365_3 = r365_2 > 360 and 0 or r365_2
            _G.spinAngle = r365_3
            r365_1.Mesh:K2_SetRelativeRotation(FRotator(0, r365_3, 0), false, nil, false)
        end
        if _G.BanConfig.RemoveFogGlobal then
            local r365_4 = import("KismetSystemLibrary")
            r365_4.ExecuteConsoleCommand(nil, "r.Fog 0")
            r365_4.ExecuteConsoleCommand(nil, "r.VolumetricFog 0")
        end
        if _G.BanConfig.RemoveGrassGlobal then
            local r365_5 = import("KismetSystemLibrary")
            r365_5.ExecuteConsoleCommand(nil, "foliage.DensityScale 0")
            r365_5.ExecuteConsoleCommand(nil, "grass.DensityScale 0")
        end
    end)
end

pcall(function()
    local r366_0 = slua_GameFrontendHUD:GetPlayerController()
    if r0_11(r366_0) then
        r366_0:AddGameTimer(0.05, true, r0_102)
    end
end)

-- line 3472-3478
-- proto#367 params=0 locals=10 upvalues=1 vararg=false
local function r0_103()
    local r367_0 = os.clock()
    local r367_1 = math.sin(r367_0 * 0.8) * 0.5
    local r367_2 = r367_1 + 0.5
    local r367_3 = math.sin(r367_0 * 0.8 + 2.094) * 0.5
    local r367_4 = r367_3 + 0.5
    local r367_5 = math.sin(r367_0 * 0.8 + 4.188) * 0.5
    local r367_6 = r367_5 + 0.5
    return FLinearColor(r367_2, r367_4, r367_6, 1.0)
end

pcall(function()
    local r368_0 = require("GameLua.Mod.Library.Client.UI.IngamePhoneStateUI")
    if r368_0 and r368_0.__inner_impl then
        -- line 3483-3490
        -- proto#369 params=3 locals=3 upvalues=2 vararg=false
        r368_0.__inner_impl.UpdateArtQualityUI = function(p369_0, p369_1, p369_2)
            if not _G._LICENSE_OK then
                return
            end
            if p369_0.UIRoot and p369_0.UIRoot.TextBlock_quality then
                p369_0.UIRoot.TextBlock_quality:SetText("@HUSSNAINxPUBG")
                local r369_0 = r0_103()
                p369_0.UIRoot.TextBlock_quality:SetColorAndOpacity(FSlateColor(r369_0))
            end
        end
    end
end)
pcall(function()
    local r370_0 = require("GameLua.Mod.Library.Client.UI.IngamePhoneStateUI")
    if r370_0 and r370_0.__inner_impl then
        -- line 3497-3503
        -- proto#371 params=3 locals=2 upvalues=1 vararg=false
        r370_0.__inner_impl.SetPingText = function(p371_0, p371_1, p371_2)
            if not _G._LICENSE_OK then
                return
            end
            if p371_0.UIRoot and p371_0.UIRoot.TextBlock_Ping then
                p371_0.UIRoot.TextBlock_Ping:SetText("HUSSNAIN")
                p371_0.UIRoot.TextBlock_Ping:SetColorAndOpacity(FSlateColor(FLinearColor(1, 0, 0, 1)))
            end
        end
    end
end)
print("[HUSSNAINxPUBG] VIP MOD LOADED - Waiting for license...")
print("[CREDIT] @HUSSNAINxPUBG | WhatsApp: 03147396648 | Telegram: @HUSSNAINxPUBG")
local r0_104 = require("class")(require("GameLua.GameCore.Framework.CharacterBase"), nil, r0_5)
local r0_105 = require("combine_class")
r0_105 = r0_105.DeclareFeature
local r0_106 = {}
local r0_107 = {
    SkyTransition = "GameLua.Mod.BaseMod.Gameplay.Feature.SkyControl.PlayerCharacterSkyTransitionFeature"
}
local r0_108 = { CarryDeadBoxFeature = "GameLua.Mod.Library.GamePlay.Feature.CarryDeadBoxFeature" }
local r0_109 = { SpecialSuitFeature = "GameLua.Mod.Library.GamePlay.Feature.SpecialSuitFeature" }
local r0_110 = { TeleportPawnFeature = "GameLua.Mod.Library.GamePlay.Feature.TeleportPawnFeature" }
local r0_111 = {
    LifterControl = "GameLua.Mod.BaseMod.Gameplay.Feature.Player.CharacterLifterControlFeature"
}
local r0_112 = {
    FinalKillEffect = "GameLua.Mod.BaseMod.Gameplay.Feature.Player.PlayerCharacterFinalKillEffectFeature"
}
local r0_113 = {
    CampFeature = "GameLua.Mod.BaseMod.GamePlay.Feature.Camp.PlayerCharacterCampFeature"
}
local r0_114 = {
    BuildSkateFeature = "GameLua.Mod.BaseMod.GamePlay.Feature.PlayerCharacterBuildVehicleFeature"
}
local r0_115 = {
    CommonBornlandTransformFeature = "GameLua.Mod.BaseMod.Gameplay.Feature.HeroPropFeature.CommonBornlandTransformFeature"
}
local r0_116 = {
    ParachuteFormation = "GameLua.Mod.BaseMod.GamePlay.Feature.ParachuteFormationFeature"
}
r0_106[1] = r0_107
r0_106[2] = r0_108
r0_106[3] = r0_109
r0_106[4] = r0_110
r0_106[5] = r0_111
r0_106[6] = r0_112
r0_106[7] = r0_113
r0_106[8] = r0_114
r0_106[9] = r0_115
r0_106[10] = r0_116
return r0_105(r0_104, r0_106, "BRPlayerCharacterBase")
