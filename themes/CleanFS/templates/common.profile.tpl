<?php echo tpl_form( $do=='myprofile' ? Filters::noXSS(CreateUrl('myprofile')) : Filters::noXSS(CreateUrl('edituser', $theuser->id))); ?>
    <ul class="form_elements">
      <li>
        <label for="realname"><?php echo Filters::noXSS(L('realname')); ?></label>
        <input id="realname" class="text" type="text" name="real_name" maxlength="100"
          value="<?php echo Filters::noXSS(Req::val('real_name', $theuser->infos['real_name'])); ?>" />
      </li>
      <li>
        <label for="emailaddress"><?php echo Filters::noXSS(L('emailaddress')); ?></label>
        <input id="emailaddress" class="text" type="text" name="email_address" maxlength="100"
          value="<?php echo Filters::noXSS(Req::val('email_address', $theuser->infos['email_address'])); ?>" />
      </li>
      <li>
        <label for="hide_my_email"><?php echo Filters::noXSS(L('hidemyemail')); ?></label>
        <?php echo tpl_checkbox('hide_my_email', Req::val('hide_my_email', !Post::val('action') && $theuser->infos['hide_my_email']), 'hide_my_email', 1, ($fs->prefs['hide_emails'] ) ? array('checked' => 'true', 'disabled' => 'true') : ''); ?>
      </li>
      <?php if (!empty($fs->prefs['jabber_server'])):?>
      <li>
        <label for="jabberid"><?php echo Filters::noXSS(L('jabberid')); ?></label>
        <input id="jabberid" class="text" type="text" name="jabber_id" maxlength="100"
          value="<?php echo Filters::noXSS(Req::val('jabber_id', $theuser->infos['jabber_id'])); ?>" />
        <input type="hidden" name="old_jabber_id" value="<?php echo Filters::noXSS($theuser->infos['jabber_id']); ?>" />
      </li>
      <?php endif ?>
      <?php if ($fs->prefs['enable_avatars']): ?>
      <li>
        <label for="profileimage"><?php echo Filters::noXSS(L('profileimage')); ?></label>
        <?php echo tpl_userlinkavatar($theuser->id, $fs->prefs['max_avatar_size'], 'av_comment'); ?>
      </li>
      <li>
        <label for="profileimage_input">&nbsp;</label>
        <input id="profileimage_input" name="profile_image" type="file" value="<?php echo Filters::noXSS(Req::val('profile_image')); ?>"/>
      </li>
      <?php endif ?>
      <li>
        <label for="notifytype"><?php echo Filters::noXSS(L('notifytype')); ?></label>
        <select id="notifytype" name="notify_type">
          <?php echo tpl_options($fs->GetNotificationOptions(), Req::val('notify_type', $theuser->infos['notify_type'])); ?>
        </select>
      </li>
      <li>
        <label for="notify_own"><?php echo Filters::noXSS(L('notifyown')); ?></label>
        <?php echo tpl_checkbox('notify_own', Req::val('notify_own', !Post::val('action') && $theuser->infos['notify_own']), 'notify_own'); ?>
      </li>
      <!--<li>
        <label for="notify_online"><?php echo Filters::noXSS(L('notifyonline')); ?></label>
        <?php echo tpl_checkbox('notify_online', Req::val('notify_online', !Post::val('action')  && $theuser->infos['notify_online']), 'notify_online'); ?>
      </li>-->
      <li>
        <label for="dateformat"><?php echo Filters::noXSS(L('dateformat')); ?></label>
        <select id="dateformat" name="dateformat">
          <?php echo tpl_date_formats($theuser->infos['dateformat']); ?>
        </select>
      </li>
      <li>
        <label for="dateformat_extended"><?php echo Filters::noXSS(L('dateformat_extended')); ?></label>
        <select id="dateformat_extended" name="dateformat_extended">
          <?php echo tpl_date_formats($theuser->infos['dateformat_extended'], true); ?>
        </select>
      </li>
      <li>
        <label for="tasks_perpage"><?php echo Filters::noXSS(L('tasksperpage')); ?></label>
        <select name="tasks_perpage" id="tasks_perpage">
          <?php echo tpl_options(array(10, 25, 50, 100, 250), Req::val('tasks_perpage', $theuser->infos['tasks_perpage']), true); ?>
        </select>
      </li>
      <li>
        <label for="time_zone"><?php echo Filters::noXSS(L('timezone')); ?></label>
        <select id="time_zone" name="time_zone">
          <?php
            $times = array();
            for ($i = -12; $i <= 13; $i++) {
              $times[$i] = L('GMT') . (($i == 0) ? ' ' : (($i > 0) ? '+' . $i : $i));
            }
          ?>
          <?php echo tpl_options($times, Req::val('time_zone', $theuser->infos['time_zone'])); ?>
        </select>
      </li>
      <li>
            <label for="langcode"><?php echo Filters::noXSS(L('language')); ?></label>
            <select id="langcode" name="lang_code">
                <?php 
                #echo tpl_options(array_merge(array('browser', 'project'), Flyspray::listLangs()), Req::val('lang_code', $theuser->infos['lang_code']), true);
                echo tpl_options( Flyspray::listLangs(), Req::val('lang_code', $theuser->infos['lang_code']), true);
                ?>
            </select>
        </li>
      <li>
        <hr />
      </li>
      <?php if ($user->perms('is_admin')): ?>
      <li>
        <label for="accountenabled"><?php echo Filters::noXSS(L('accountenabled')); ?></label>
        <?php echo tpl_checkbox('account_enabled', Req::val('account_enabled', !Post::val('action') && $theuser->infos['account_enabled']), 'accountenabled'); ?>
      </li>
      <li>
        <label for="delete_user"><?php echo Filters::noXSS(L('deleteuser')); ?></label>
        <?php echo tpl_checkbox('delete_user', false, 'delete_user'); ?>
      </li>
      <?php endif; ?>
      <li>
        <label for="groupin"><?php echo Filters::noXSS(L('globalgroup')); ?></label>
        <select id="groupin" class="adminlist" name="group_in" <?php echo Filters::noXSS(tpl_disableif(!$user->perms('is_admin'))); ?>>
          <?php echo tpl_options($groups, Req::val('group_in', $theuser->infos['global_group'])); ?>
        </select>
        <input type="hidden" name="old_global_id" value="<?php echo Filters::noXSS($theuser->infos['global_group']); ?>" />
      </li>

      <?php if ($proj->id): ?>
      <li>
        <label for="projectgroupin"><?php echo Filters::noXSS(L('projectgroup')); ?></label>
        <select id="projectgroupin" class="adminlist" name="project_group_in" <?php echo Filters::noXSS(tpl_disableif(!$user->perms('manage_project'))); ?>>
          <?php echo tpl_options(array_merge($project_groups, array(0 => array('group_name' => L('none'), 0 => 0, 'group_id' => 0, 1 => L('none')))), Req::val('project_group_in', $theuser->perms('project_group'))); ?>
        </select>
          <input type="hidden" name="old_project_id" value="<?php echo Filters::noXSS($theuser->perms('project_group')); ?>" />
      </li>
      <?php endif; ?>
      <li>
        <hr />
      </li>

      <?php if (!$theuser->infos['oauth_uid']): ?>
      <?php if ($user->perms('is_admin') || $user->id == $theuser->id): ?>
      <?php if (!$fs->prefs['disable_changepw']): ?>
      <?php if (!$user->perms('is_admin')): ?>
      <li>
        <label for="oldpass"><?php echo Filters::noXSS(L('oldpass')); ?></label>
        <input id="oldpass" class="password" type="password" name="oldpass" value="<?php echo Filters::noXSS(Req::val('oldpass')); ?>" maxlength="100" />
      </li>
      <?php endif; ?>
      <li>
        <label for="changepass"><?php echo Filters::noXSS(L('changepass')); ?></label>
        <input id="changepass" class="password" type="password" name="changepass" value="<?php echo Filters::noXSS(Req::val('changepass')); ?>" maxlength="100" />
      </li>
      <li>
        <label for="confirmpass"><?php echo Filters::noXSS(L('confirmpass')); ?></label>
        <input id="confirmpass" class="password" type="password" name="confirmpass" value="<?php echo Filters::noXSS(Req::val('confirmpass')); ?>" maxlength="100" />
      </li>
      <?php endif; ?>
      <?php endif; ?>
      <?php endif; ?>
      <li>
        <input type="hidden" name="action" value="<?php echo Filters::noXSS(Req::val('action', $do . '.edituser')); ?>" />
        <?php if (Req::val('area') || $do == 'admin'): ?><input type="hidden" name="area" value="users" /><?php endif; ?>
        <input type="hidden" name="user_id" value="<?php echo Filters::noXSS($theuser->id); ?>" />
        <button type="submit"><?php echo Filters::noXSS(L('updatedetails')); ?></button>
      </li>
    </ul>
  </form>
