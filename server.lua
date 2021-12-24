

local Plakalar = {}

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)




QBCore.Functions.CreateCallback("tgiann-kiralik:kira-kontrol", function(source, cb, price)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if Plakalar[xPlayer.PlayerData.citizenid] then
        TriggerClientEvent("QBCore:Notify", src, "Zaten Kiralık Bir Aracın Var!", "error")
        cb(false)
    else
        if xPlayer.Functions.RemoveMoney("bank", price) then
            local plate = "K"..src
            Plakalar[xPlayer.PlayerData.citizenid] = {
                plate = plate,
                price = price/2
            }
            cb(true, plate)
        else
            TriggerClientEvent("QBCore:Notify", src, "Banka Hesabında Yeteri Kadar Para Yok!", "error")
            cb(false)
        end
    end
    print(json.encode(Plakalar))
end)



QBCore.Functions.CreateCallback("tgiann-kiralik:aracBirak", function(source, cb, plate)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if Plakalar[xPlayer.PlayerData.citizenid] then
        if Plakalar[xPlayer.PlayerData.citizenid].plate == QBCore.Shared.Trim(plate) then
            xPlayer.Functions.AddMoney('bank', Plakalar[xPlayer.PlayerData.citizenid].price)
            TriggerClientEvent("QBCore:Notify", src, "Aracı İade Ettin, $"..Plakalar[xPlayer.PlayerData.citizenid].price.." Banka Hesabına Yatırıldı!")
            Plakalar[xPlayer.PlayerData.citizenid] = nil
            cb(true)
        else
            TriggerClientEvent("QBCore:Notify", src, "Kiraladığın Araç Bu Değil!", "error")
            cb(false)
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "Kiraladığın Bir Araç Yok!", "error")
        cb(false)
    end
end)