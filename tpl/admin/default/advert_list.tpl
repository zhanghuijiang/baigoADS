{* admin_list.tpl 管理员列表 *}
{$cfg = [
    title          => $adminMod.advert.main.title,
    menu_active    => "advert",
    sub_active     => "list",
    baigoCheckall  => "true",
    baigoValidator => "true",
    baigoSubmit    => "true",
    tokenReload    => "true",
    tooltip        => "true",
    str_url        => "{$smarty.const.BG_URL_ADMIN}ctl.php?mod=advert&{$tplData.query}"
]}

{include "{$smarty.const.BG_PATH_TPL}admin/default/include/admin_head.tpl" cfg=$cfg}

    <li>{$adminMod.advert.main.title}</li>

    {include "{$smarty.const.BG_PATH_TPL}admin/default/include/admin_left.tpl" cfg=$cfg}

    <div class="form-group">
        <div class="pull-left">
            <ul class="nav nav-pills nav_baigo">
                <li>
                    <a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=advert&act_get=form">
                        <span class="glyphicon glyphicon-plus"></span>
                        {$lang.href.add}
                    </a>
                </li>
                <li>
                    <a href="{$smarty.const.BG_URL_HELP}ctl.php?mod=admin&act_get=advert" target="_blank">
                        <span class="glyphicon glyphicon-question-sign"></span>
                        {$lang.href.help}
                    </a>
                </li>
            </ul>
        </div>
        <div class="pull-right">
            <form name="advert_search" id="advert_search" action="{$smarty.const.BG_URL_ADMIN}ctl.php" method="get" class="form-inline">
                <input type="hidden" name="mod" value="advert">
                <input type="hidden" name="act_get" value="list">

                <div class="form-group">
                    <select name="posi_id" class="form-control input-sm">
                        <option value="">{$lang.option.allPosi}</option>
                        {foreach $tplData.posiRows as $key=>$value}
                            <option {if $tplData.search.posi_id == $value.posi_id}selected{/if} value="{$value.posi_id}">{$value.posi_name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <select name="status" class="form-control input-sm">
                        <option value="">{$lang.option.allStatus}</option>
                        {foreach $status.advert as $key=>$value}
                            <option {if $tplData.search.status == $key}selected{/if} value="{$key}">{$value}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <div class="input-group input-group-sm">
                        <input type="text" name="key" class="form-control" value="{$tplData.search.key}" placeholder="{$lang.label.key}">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                </div>
            </form>
        </div>
        <div class="clearfix"></div>
    </div>

    <form name="advert_list" id="advert_list" class="form-inline">
        <input type="hidden" name="token_session" class="token_session" value="{$common.token_session}">

        <div class="panel panel-default">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th class="text-nowrap td_mn">
                                <label for="chk_all" class="checkbox-inline">
                                    <input type="checkbox" name="chk_all" id="chk_all" data-parent="first">
                                    {$lang.label.all}
                                </label>
                            </th>
                            <th class="text-nowrap td_mn">{$lang.label.id}</th>
                            <th>{$lang.label.advertName}</th>
                            <th class="text-nowrap td_bg">{$lang.label.posi} / {$lang.label.advertShow}</th>
                            <th class="text-nowrap td_bg">{$lang.label.advertBegin} / {$lang.label.advertPutType}</th>
                            <th class="text-nowrap td_md">{$lang.label.status} / {$lang.label.note}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $tplData.advertRows as $key=>$value}
                            {if ($value.advert_put_type == "date" && $value.advert_put_opt < $smarty.now) || ($value.advert_put_type == "show" && $value.advert_put_opt < $value.advert_count_show) || ($value.advert_put_type == "hit" && $value.advert_put_opt < $value.advert_count_hit)}
                                {$_css_status = "warning"}
                                {$_str_status = $lang.label.expired}
                            {else}
                                {if $value.advert_status == "enable"}
                                    {$_css_status = "success"}
                                    {$_str_status = $status.advert[$value.advert_status]}
                                {else}
                                    {$_css_status = "default"}
                                    {$_str_status = $status.advert[$value.advert_status]}
                                {/if}
                            {/if}
                            <tr>
                                <td class="text-nowrap td_mn"><input type="checkbox" name="advert_ids[]" value="{$value.advert_id}" id="advert_id_{$value.advert_id}" data-validate="advert_id" data-parent="chk_all"></td>
                                <td class="text-nowrap td_mn">{$value.advert_id}</td>
                                <td>
                                    <ul class="list-unstyled">
                                        <li>{$value.advert_name}</li>
                                        <li>
                                            <ul class="list_menu">
                                                <li>
                                                    <a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=advert&act_get=show&advert_id={$value.advert_id}">{$lang.href.show}</a>
                                                </li>
                                                <li>
                                                    <a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=advert&act_get=form&advert_id={$value.advert_id}">{$lang.href.edit}</a>
                                                </li>
                                                <li>
                                                    <a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=stat&act_get=advert&advert_id={$value.advert_id}">{$lang.href.stat}</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </td>
                                <td class="text-nowrap td_bg">
                                    <ul class="list-unstyled">
                                        <li>
                                            {if isset($value.posiRow.posi_name)}
                                                <a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=advert&act_get=list&posi_id={$value.posiRow.posi_id}">{$value.posiRow.posi_name}</a>
                                            {else}
                                                {$lang.label.unknow}
                                            {/if}
                                        </li>
                                        <li>
                                            <abbr data-toggle="tooltip" data-placement="bottom" title="{$lang.label.advertShow} {$value.advert_count_show}<br>{$lang.label.advertHit} {$value.advert_count_hit}">{$value.advert_count_show}</abbr>
                                        </li>
                                    </ul>
                                </td>
                                <td class="text-nowrap td_bg">
                                    <ul class="list-unstyled">
                                        <li>
                                            <abbr data-toggle="tooltip" data-placement="bottom" title="{$value.advert_begin|date_format:"{$smarty.const.BG_SITE_DATE} {$smarty.const.BG_SITE_TIMESHORT}"}">{$value.advert_begin|date_format:"{$smarty.const.BG_SITE_DATESHORT} {$smarty.const.BG_SITE_TIMESHORT}"}</abbr>
                                        </li>
                                        <li>
                                            {if $value.advert_put_type == "date"}
                                                {$str_putOpt = "{$lang.label.advertPutDate} {$value.advert_put_opt|date_format:"{$smarty.const.BG_SITE_DATE} {$smarty.const.BG_SITE_TIMESHORT}"}"}
                                            {else if $value.advert_put_type == "show"}
                                                {$str_putOpt = "{$lang.label.advertPutShow} {$value.advert_put_opt}"}
                                            {else if $value.advert_put_type == "hit"}
                                                {$str_putOpt = "{$lang.label.advertPutHit} {$value.advert_put_opt}"}
                                            {else}
                                                {$str_putOpt = $type.put[$value.advert_put_type]}
                                            {/if}

                                            <abbr data-toggle="tooltip" data-placement="bottom" title="{$str_putOpt}">
                                                {$type.put[$value.advert_put_type]}
                                            </abbr>
                                        </li>
                                    </ul>
                                </td>
                                <td class="text-nowrap td_md">
                                    <ul class="list-unstyled">
                                        <li class="label_baigo">
                                            <span class="label label-{$_css_status}">{$_str_status}</span>
                                        </li>
                                        <li>{$value.advert_note}</li>
                                    </ul>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2"><span id="msg_advert_id"></span></td>
                            <td colspan="5">
                                <div class="form-group">
                                    <div id="group_act_post">
                                        <select name="act_post" id="act_post" data-validate class="form-control input-sm">
                                            <option value="">{$lang.option.batch}</option>
                                            {foreach $status.advert as $key=>$value}
                                                <option value="{$key}">{$value}</option>
                                            {/foreach}
                                            <option value="del">{$lang.option.del}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="button" id="go_list" class="btn btn-sm btn-primary">{$lang.btn.submit}</button>
                                </div>
                                <div class="form-group">
                                    <span id="msg_act_post"></span>
                                </div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

    </form>

    <div class="text-right">
        {include "{$smarty.const.BG_PATH_TPL}admin/default/include/page.tpl" cfg=$cfg}
    </div>

{include "{$smarty.const.BG_PATH_TPL}admin/default/include/admin_foot.tpl" cfg=$cfg}

    <script type="text/javascript">
    var opts_validator_list = {
        advert_id: {
            len: { min: 1, max: 0 },
            validate: { selector: "[data-validate='advert_id']", type: "checkbox" },
            msg: { selector: "#msg_advert_id", too_few: "{$alert.x030202}" }
        },
        act_post: {
            len: { min: 1, max: 0 },
            validate: { type: "select", group: "#group_act_post" },
            msg: { selector: "#msg_act_post", too_few: "{$alert.x030203}" }
        }
    };

    var opts_submit_list = {
        ajax_url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=advert",
        confirm_selector: "#act_post",
        confirm_val: "del",
        confirm_msg: "{$lang.confirm.del}",
        text_submitting: "{$lang.label.submitting}",
        btn_text: "{$lang.btn.ok}",
        btn_close: "{$lang.btn.close}",
        btn_url: "{$cfg.str_url}"
    };

    $(document).ready(function(){
        var obj_validator_list = $("#advert_list").baigoValidator(opts_validator_list);
        var obj_submit_list = $("#advert_list").baigoSubmit(opts_submit_list);
        $("#go_list").click(function(){
            if (obj_validator_list.verify()) {
                obj_submit_list.formSubmit();
            }
        });

        $("#advert_list").baigoCheckall();
    });
    </script>

{include "{$smarty.const.BG_PATH_TPL}admin/default/include/html_foot.tpl" cfg=$cfg}