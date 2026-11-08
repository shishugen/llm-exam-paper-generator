-- 把演示课程名统一成定稿的《数据库原理》
-- 可重复执行
UPDATE exam_course SET course_name = '数据库原理' WHERE id = 1;
UPDATE exam_paper SET title = '数据库原理 期末测验（A 卷·演示）' WHERE id = 1;
-- 其它历史演示试卷的标题里也带着旧课程名，一起替换
UPDATE exam_paper SET title = REPLACE(title, '数据库原理与应用', '数据库原理')
  WHERE title LIKE '%数据库原理与应用%';

-- 回滚：用 sql/备份_课程名统一前_20261108.sql 恢复这两张表
