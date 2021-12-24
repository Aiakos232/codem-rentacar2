$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        var state = false;
        if (event.data.type === "data") {
            $(".anasayfa").css('display', "block");
            var i;
            for (i = 0; i < event.data.item.length; i++) {
                console.log(event.data.item[i].dukkan)
                $('.marketyazisi').text(event.data.item[i].dukkan)
                
               
              
                $('.container').append(
                    ` 
                    <div class='card' data-id="1" id = ${event.data.item[i].price} itemcode =${event.data.item[i].itemscode} label =${event.data.item[i].name} spawnx =${event.data.item[i].spawnnoktasix} spawny =${event.data.item[i].spawnnoktasiy   } spawnz =${event.data.item[i].spawnnoktasiz} spawnh =${event.data.item[i].spawnnoktasih} >
                <div class='card-content'>
                    <div class="itemscode">${event.data.item[i].itemscode}</div>
                
                    <div class='top-bar'><span>${event.data.item[i].price} $</span><span class='float-right lnr lnr-heart'></span></div>
                    <div class='img' ><img  src="${event.data.item[i].image}"></div> 
                </div>
                <div class='card-description'>
                    <div class='title' >${event.data.item[i].name}  </div>
                </div>
                </div>`
                );
            }
            state = true;
            $(".card").on("click", function() {
                var price = $(this).attr('id');
                var itemcode = $(this).attr('itemcode');
                var itemsname = $(this).attr('label');
                var spawnx = $(this).attr('spawnx');
                var spawny = $(this).attr('spawny');
                var spawnz = $(this).attr('spawnz');
                var spawnh = $(this).attr('spawnh');
             
                $.post("http://codem-rentacar/itemdata", JSON.stringify({
                    price: price,
                    itemcode: itemcode,
                    itemsname: itemsname,
                    spawnx : spawnx,
                    spawny : spawny,
                    spawnz : spawnz ,
                    spawnh : spawnh
                }));
                $('.anasayfa').hide();
                $.post('http://codem-rentacar/escape');
                document.querySelectorAll(".card").forEach(function(a) { a.remove() })
            })
        }
        
    })
});


   $(document).keydown(function(e) {
                    if (e.keyCode == 27) {
                        $('.anasayfa').hide();
                        $.post('http://codem-rentacar/escape');
                        document.querySelectorAll(".card").forEach(function(a) { a.remove() })
                    }
    });

