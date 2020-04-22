--[[
TAX SYSTEM BY DANID18 WIP

DO NOT CHANGE THIS FILE IF YOU DONT KNOW HOW TO CODE!

TO CHANGE THE PRICE USE CONFIG FILE.

  ]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
MySQL.ready(function ()
    print(MySQL.Sync.fetchScalar('SELECT @parameters', {
        ['@parameters'] =  'string'
    }))
end)
end)

Citizen.CreateThread(function()
local xPlayers = ESX.GetPlayers()
local Interval = Config.timeInterval
--for i=1, #xPlayers, 1 do
if Interval ~= nil then
while true do
Citizen.Wait(0)
MySQL.Async.fetchAll('SELECT tax_type, tax_amount FROM gov', {}, function(taxs_type)
	data = taxs_type[1]
	data2 = taxs_type[2]
	if data ~= nil then
	tax_t = tostring(data.tax_type)
	tax_t2= tostring(data2.tax_type)
	tax_a = tonumber(data.tax_amount)
	tax_a2 = tonumber(data2.tax_amount)
    --print(tax_t .. " " .. tax_a)
    --print(tax_t2 .. " " .. tax_a2)
    --print("______________")
	end
	end)
Citizen.Wait(Interval * 60000)
end
end
end)

RegisterServerEvent('esx_tax_system:takeTax')
AddEventHandler('esx_tax_system:takeTax', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	-- Can citizen pay tax?
	if (tax_a ~= nil) then
		local tax_amount = tax_a*0.01
		amount = ESX.Math.Round(amount)
		tax_procent = tax_amount*amount
		if xPlayer.getMoney() >= tax_procent then
			xPlayer.removeMoney(tax_procent/2)
			xPlayer.showNotification('Tax: ' .. ESX.Math.GroupDigits(tax_procent) .. "$.")
		
		else
			local missingMoney = tax_procent - xPlayer.getMoney()
			xPlayer.showNotification('You need more ' .. ESX.Math.GroupDigits(missingMoney) .. "$" .. ' To pay the buy tax.')
		end
	end
end)
