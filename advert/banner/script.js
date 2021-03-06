/*
v0.0.9 jQuery baigoADS banner 插件
(c) 2013 baigo studio - http://www.baigo.net/ads/
License: http://www.opensource.org/licenses/mit-license.php
*/

(function($){
    $.fn.adsBanner = function(options) {
        "use strict";
        var thisObj = $(this); //定义当前对象
        var _parent_id = thisObj.attr("id");

        var defaults = {
            loading: "Loading..."
        };

        var opts = $.extend(defaults, options);

        $.ajax({
            url: opts.data_url, //url
            type: "get",
            dataType: "jsonp", //数据格式为jsonp
            data: "",
            beforeSend: function(){
                var _str_advert = "<div class='bannerChild'></div>";
                thisObj.html(_str_advert);

                $("#" + _parent_id + " .bannerChild").text(opts.loading);
            }, //输出消息
            success: function(_result){ //读取返回结果
                var _posiRow = _result.posiRow;
                var _str_media;
                if (_posiRow.posi_type == "media") {
                    _str_media = "<img src='" + _result.advertRows[0].mediaRow.media_url + "' width='100%'>";
                } else {
                    _str_media = _result.advertRows[0].advert_content;
                }

                var _str_advert = "<a href='" + _result.advertRows[0].advert_href + "' target='_blank'>" + _str_media + "</a>";

                $("#" + _parent_id + " .bannerChild").html(_str_advert);
            }
        });
    };
})(jQuery);