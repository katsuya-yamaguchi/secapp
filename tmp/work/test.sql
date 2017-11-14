# video_categoriesテーブルにテスト用のデータを挿入する
insert into video_categories (id, uq_category_name, created_at, updated_at) values(1,'Sec',current_timestamp,current_timestamp);

# video_groupsテーブルにテスト用のデータを挿入する
insert into video_groups (id, uq_group_name, fk_category_id, created_at, updated_at) values(1, 'WEB', 1, current_timestamp, current_timestamp);

# itemsテーブルにテスト用のデータを挿入する
#insert into items (id, video, description, procedure, created_at, updated_at) values(1, '01_test.mp3', '001_desc_owasp_setup.html', '001_proc_owasp_setup.html', current_timestamp, current_timestamp);
#insert into items (id, video, description, procedure, created_at, updated_at) values(2, '02_test.mp3', '002_desc_owasp_setup.html', '002_proc_owasp_setup.html', current_timestamp, current_timestamp);

# videosテーブルにテスト用のデータを挿入する
insert into videos (id, video_time, uq_video_name, fk_groups_id, created_at, updated_at, video, description, procedure) values(1, '10:00:00', '001_video_owasp', 1, current_timestamp, current_timestamp, 'video', 'description', 'procedure');
insert into videos (id, video_time, uq_video_name, fk_groups_id, created_at, updated_at, video, description, procedure) values(2, '10:00:00', '002_video_wire', 1, current_timestamp, current_timestamp, 'video2', 'descriptioo2', 'procedure2');

delete from video_groups where id=1;
