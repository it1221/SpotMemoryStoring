$(function() {
    $('#id_submit').on('click', function() {
        //テキストボックスの入力値をサーバーへ送る
        var id_list = [$('#id1').val(), $('#id2').val(), $('#id3').val()];
        $.ajax({
            url: '/test/search',
            dataType: 'json',
            type: 'POST',
            data: {
                id_list: id_list
            },
        }).done(function(result) {
            //今呼び出しているパーシャルを消して、受け取ったパーシャルを表示
            $('#target').children().remove();
            $('#target').html(result.html);
        }).fail(function(err) {
            console.log(err);
        })
    })
})