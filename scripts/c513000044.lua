--時械神 サディオン
function c513000044.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c513000044.damop)
	c:RegisterEffect(e1)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	--4000 lp
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetDescription(aux.Stringid(513000003,0))
	e6:SetCode(EVENT_BATTLED)
	e6:SetCondition(c513000044.con)
	e6:SetOperation(c513000044.op)
	c:RegisterEffect(e6)
	--to deck
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(512000003,2))
	e7:SetCategory(CATEGORY_TODECK)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e7:SetProperty(EFFECT_FLAG_REPEAT)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c513000044.tdcon)
	e7:SetTarget(c513000044.tdtg)
	e7:SetOperation(c513000044.tdop)
	c:RegisterEffect(e7)
	--disable summon
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetTargetRange(1,0)
	e9:SetTarget(c513000044.sumlimit)
	c:RegisterEffect(e9)
end
function c513000044.damop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsPosition(POS_FACEUP_ATTACK) and Duel.SelectYesNo(tp,aux.Stringid(93816465,1)) then
		Duel.ChangeBattleDamage(tp,0)
		Duel.ChangeBattleDamage(1-tp,0)
	end
end
function c513000044.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<4000
end
function c513000044.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,4000,REASON_EFFECT)
end
function c513000044.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c513000044.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c513000044.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:IsAbleToDeck() then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	end
end
function c513000044.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not se:GetHandler():IsCode(100000013) and not se:GetHandler():IsCode(100000014)
end
