-- 桌球教室管理系統 - 資料庫建立 SQL
-- 在 Supabase SQL Editor 貼上這段並執行

-- 教練資料表
create table coaches (
  id serial primary key,
  name text not null
);

-- 學生資料表
create table students (
  id serial primary key,
  name text not null,
  day_index integer not null,  -- 0=週一 1=週二 ... 6=週日
  coach_id integer references coaches(id),
  period integer default 1,
  paid boolean default false
);

-- 上課記錄資料表
create table records (
  id serial primary key,
  student_id integer references students(id) on delete cascade,
  coach_id integer references coaches(id),
  date text not null,
  created_at timestamp default now()
);

-- 開放 API 存取權限（允許網頁讀寫）
alter table coaches enable row level security;
alter table students enable row level security;
alter table records enable row level security;

create policy "allow all" on coaches for all using (true) with check (true);
create policy "allow all" on students for all using (true) with check (true);
create policy "allow all" on records for all using (true) with check (true);

-- 新增你的5位教練（可以改成真實名字）
insert into coaches (name) values
  ('王教練'),
  ('李教練'),
  ('張教練'),
  ('陳教練'),
  ('林教練');
