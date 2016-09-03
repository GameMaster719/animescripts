--Nemuriko (DOR)
--scripted by GameMaster (GM)
--cannnot change position or attack
function c511005617.initial_effect(c)
    --warrior race cannot atk/ chg pos
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_ATTACK)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    e1:SetCondition(function(e)return e:GetHandler():IsDefensePos() end)
    e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WARRIOR))
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
    c:RegisterEffect(e2)
end