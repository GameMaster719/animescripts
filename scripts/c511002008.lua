--Saint Instrument
function c511002008.initial_effect(c)
	aux.AddEquipProcedure(c)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34408491,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c511002008.atkcon)
	e3:SetOperation(c511002008.atkop)
	c:RegisterEffect(e3)
	--target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e4:SetCondition(c511002008.atcon)
	e4:SetValue(c511002008.atlimit)
	c:RegisterEffect(e4)
end
function c511002008.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsSetCard(0x9b)
end
function c511002008.atlimit(e,c)
	return c~=e:GetHandler():GetEquipTarget()
end
function c511002008.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	c511002008[ev]=cv
	if ex then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	c511002008[ev]=cv
	return ex and Duel.IsPlayerAffectedByEffect(cp,EFFECT_REVERSE_RECOVER)
end
function c511002008.atkop(e,tp,eg,ep,ev,re,r,rp)
	local cid=c511002008[ev]
	local tc=e:GetHandler():GetEquipTarget()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(cid)
		if tc:RegisterEffect(e1) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_CHANGE_DAMAGE)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetTargetRange(1,1)
			e2:SetLabel(cid)
			e2:SetValue(c511002008.damcon)
			e2:SetReset(RESET_CHAIN)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c511002008.damcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return val end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return 0
end
