local x, y = GetSpellTargetX(), GetSpellTargetY();
TimerStart(CreateTimer(), 1, false, function()
    DoSomeone(x, y);
end)