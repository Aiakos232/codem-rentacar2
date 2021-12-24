-- Codem Store  https://discord.gg/zj3QsUfxWs
-- Codem Store  https://discord.gg/zj3QsUfxWs
-- Codem Store  https://discord.gg/zj3QsUfxWs
-- Codem Store  https://discord.gg/zj3QsUfxWs


QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)



local markets = {
    {name="Rent James", x = -181.68, y = -2469.23, z = 5.15 ,h = 137.77},
    {name="Rent Gustavo", x = 4495.22, y = -4516.50, z = 3.08,h = 24.71},
    {name="Rent Hakan", x =  -1292.74, y = 272.9, z = 63.38,h = 137.69},
    {name="Rent Vecihi", x =  -1254.61, y = -3402.90, z = 12.94,h = 49.74},
    {name="Rent Ekrem", x =   -1798.31, y = -1225.01, z = 0.59,h = 219.34},




  
}



Citizen.CreateThread(function()
  local model = GetHashKey("s_m_y_valet_01")
  RequestModel(model)
  while not HasModelLoaded(model) do
      Citizen.Wait(0)
  end
  for k,v in pairs(markets) do
   charPed = CreatePed(2, model, v.x, v.y, v.z, v.h, false, true)
   SetPedComponentVariation(charPed, 0, 0, 0, 2)
   FreezeEntityPosition(charPed, true)
   SetEntityInvincible(charPed, true)
   PlaceObjectOnGroundProperly(charPed)
   SetBlockingOfNonTemporaryEvents(charPed, true)
  end
end)

Citizen.CreateThread(function()
      for _, item in pairs(markets) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 227)
        SetBlipColour(item.blip, 29)
        SetBlipScale(item.blip, 0.6)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)

      end
end)

RegisterNUICallback('escape', function() 
SetNuiFocus(false, false) end)

RegisterNUICallback("itemdata", function(data,cb)
    money =  tonumber(data.price) 
    itemname = data.itemcode 
    itemstring = data.itemsname
    carspawnx = tonumber(data.spawnx)
    carspawny = tonumber(data.spawny)
    carspawnz = tonumber(data.spawnz)
    carspawnh = tonumber(data.spawnh)
    print(carspawnh)
    Citizen.Wait(100)
    local spawnPoint = {x = carspawnx, y = carspawny, z = carspawnz, h = carspawnh}
    QBCore.Functions.TriggerCallback("kirakontrol", function(durum, plaka)
      if durum then
           local playerPed = PlayerPedId()
           local playerCoords = GetEntityCoords(playerPed)

            QBCore.Functions.SpawnVehicle(itemname, function(yourVehicle)
                local vehicleProps = {}
                vehicleProps.plate = plaka
                QBCore.Functions.SetVehicleProperties(yourVehicle, vehicleProps)
                NetworkFadeInEntity(yourVehicle, true, true)
                TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle, -1)
                SetVehicleHasBeenOwnedByPlayer(yourVehicle, true)
                local id = NetworkGetNetworkIdFromEntity(yourVehicle)
                SetNetworkIdCanMigrate(id, true)
                SetVehicleFuelLevel(yourVehicle, 90.0)
                DecorSetFloat(yourVehicle, "_FUEL_LEVEL", 90.0)
                TriggerEvent("garage:addKeys", vehicleProps.plate)                    
                QBCore.Functions.Notify("Araç çıkartıldı")
          
            end, spawnPoint , false)
         
      end
  end, money)

end)





RentJames = vector3(-181.68,-2469.23, 5.15)
RentJames2 = vector3(4495.22, -4516.50, 3.08)
RentHakan = vector3(-1292.74, 272.9, 63.38)
RentVecihi = vector3(-1254.61, -3402.90, 12.94)
RentEkrem = vector3( -1798.31,-1225.01,0.59)



RegisterNetEvent('vlast-rentacarmenu')
AddEventHandler('vlast-rentacarmenu',function()


    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if QBCore then
            if #(playerCoords - RentJames) < 2 then 
              time = 1 
         
            
                  
                  SetNuiFocus(true, true)
                   SendNUIMessage({
                       type = "data",
                       item = Config.items
                   })
                         
            end
          if #(playerCoords - RentJames2) < 2 then 
            time = 1 
              
                SetNuiFocus(true, true)
                SendNUIMessage({
                  type = "data",
                  item = Config.rentacar2
               })        
            
          end
          if #(playerCoords - RentHakan) < 2 then 
            time = 1 
                SetNuiFocus(true, true)
                SendNUIMessage({
                  type = "data",
                  item = Config.renthakan
               })        
            
          end

          if #(playerCoords - RentEkrem) < 2 then 
            time = 1 
                SetNuiFocus(true, true)
                SendNUIMessage({
                  type = "data",
                  item = Config.rentekrem
               })        
            
          end

end

end)





RegisterNetEvent('aracteslimet')
AddEventHandler('aracteslimet', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local Arac = GetVehiclePedIsUsing(playerPed)
    local Plaka = QBCore.Shared.Trim(GetVehicleNumberPlateText(Arac))

        if string.starts(Plaka, "K") and (string.match(Plaka, "K%d") or string.match(Plaka, "K%d%d") or string.match(Plaka, "K%d%d%d")) then
            local free = true
            for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(Arac)) do
                if i ~= 1 then
                    if not IsVehicleSeatFree(Arac, i-2) then 
                        QBCore.Functions.Notify('Araçta Başkaları Varken Aracı İade Edemezsin')
                        free = false
                    end
                end
            end

            if free then
                QBCore.Functions.TriggerCallback("aracteslim", function(durum)
                    if durum then
                        if DoesEntityExist(Arac) then
                            TaskLeaveVehicle(playerPed, Arac, 0)
                            while IsPedInVehicle(playerPed, Arac, true) do
                                Citizen.Wait(0)
                            end
                            NetworkFadeOutEntity(Arac, true, true)
                            Citizen.Wait(100)
                            QBCore.Functions.DeleteVehicle(Arac)
                        end
                    end
                end, Plaka)
            end
        else
            QBCore.Functions.Notify("Bu Araç Kiralık Değil!", "error")
        end
              

end)



function string.starts(String,Start)
  if String   ~=  nil then
    print('oldu')
    print(String,Start)
    return string.sub(String,1,#Start)==Start
  else 
    print('olmadı')
  end

end