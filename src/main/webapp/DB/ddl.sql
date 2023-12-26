-- 筋トレアプリテーブル定義

-- training_programsテーブル
CREATE TABLE training_programs(
    training_program_id			SERIAL PRIMARY KEY,
    training_program_name  VARCHAR(12) NOT NULL
);

-- テストデータ
INSERT INTO training_programs (training_program_name) VALUES
	('Program 1'),
	('Program 2'),
	('Program 3')
;

-- meal_menusテーブル(食事メニュー)
CREATE TABLE meal_menus(
    food_id           	SERIAL PRIMARY KEY,
    food_name         VARCHAR(128),
    calorie           		INTEGER,
    protein           		INTEGER,
    fat               			INTEGER,
    carbo             		INTEGER,
    main_dish_flag   boolean
);

-- テストデータ
INSERT INTO meal_menus (food_name, calorie, protein, fat, carbo, main_dish_flag) VALUES
('簡単エッグベネディクト風サンド',290,40,20,51,TRUE),
('しらすチーズトースト',210,36,37,31,TRUE),
('レンジで簡単キーマカレ',480,52,25,15,TRUE),
('明太豆乳クリームうどん',400,50,29,101,TRUE),
('春巻きの皮でラクラクキッシュ風',310,45,32,86,TRUE),
('納豆味噌そぼろ丼',580,78,47,120,TRUE),
('たらこ、しらす、チーズバターのパスタ',570,32,45,64,TRUE),
('シシャモ入り具だくさんみぞれうどん',380,36,6,113,TRUE),
('納豆もち麦チャーハン',370,63,28,161,TRUE),
('ささみとカラフル野菜のハニーソース',260,47,18,60,TRUE),
('タラとじゃがいものカレー炒め',210,47,18,60,FALSE),
('納豆とオクラの麻婆豆腐',210,27,23,28,TRUE),
('きのこの肉巻きごま味噌レンジ蒸し',320,70,50,35,TRUE),
('ヘルシーアジフライ',270,36,50,10,TRUE),
('しゃきしゃき長いもと豆腐のふんわりつくね',280,38,27,40,TRUE),
('豚肉とニラのオートミールチヂミ',300,39,27,45,TRUE)
;

-- muscle_usersテーブル
CREATE TABLE muscle_users(
    id                      				SERIAL          PRIMARY KEY,
    name                    			VARCHAR(12)     		NOT NULL,
    gender                  			INTEGER        		 		NOT NULL,
    birth                   				DATE            		 		NOT NULL,
    height                  			FLOAT           		 		NOT NULL,
    mail                    				VARCHAR(255)    		UNIQUE NOT NULL,
    salt                    				VARCHAR(256)    		NOT NULL,
    password                		VARCHAR(256)    		NOT NULL,
    level                   				INTEGER         			DEFAULT 1 NOT NULL,
    training_program_id     INTEGER         			NOT NULL,
    food_id                 			INTEGER         						NOT NULL,
    last_login              			DATE            							NOT NULL,
    FOREIGN KEY(training_program_id) REFERENCES training_programs(training_program_id),
    FOREIGN KEY(food_id) REFERENCES meal_menus(food_id)
);

-- パスワード変更用テーブル
CREATE TABLE onetime_passwords (
    id    								SERIAL 			PRIMARY KEY,
    onetime_password 	VARCHAR(6) 	NOT NULL,
    user_id      					INTEGER  		NOT NULL,
    FOREIGN KEY(user_id) REFERENCES muscle_users(id)
);

-- weightテーブル(体重)
CREATE TABLE weight (
    user_id    	SERIAL PRIMARY KEY,
    date        		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    weight      	FLOAT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES muscle_users(id)
);

-- ここからトレーニングに関するテーブル
-- positionテーブル
CREATE TABLE position(
    position_id          SERIAL PRIMARY KEY,
    position    VARCHAR(10)
);

-- 部位テーブルのデータ
INSERT INTO position (position) VALUES
    ('腕'),
    ('背筋'),
    ('腹筋'),
    ('胸'),
    ('脚'),
    ('肩'),
    ('有酸素')
;

-- 部位別トレーニングテーブル
CREATE TABLE classify_training_by_parts(
  training_event_id INTEGER,
  position_id 			 INTEGER,
  PRIMARY KEY(training_event_id, position_id),
  FOREIGN KEY(training_event_id) REFERENCES types_of_training(training_event_id),
  FOREIGN KEY(position_id)REFERENCES position(position_id)
);

-- 部位別トレーニングのテストデータ
INSERT INTO classify_training_by_parts VALUES(1, 5);
INSERT INTO classify_training_by_parts VALUES(2, 1);


--トレーニング種目テーブル
CREATE TABLE types_of_training(
    training_event_id     SERIAL PRIMARY KEY,
    event_name            VARCHAR(32),
    mets                  INTEGER,
    movie_url             TEXT,
    default_number        INTEGER DEFAULT -1,
    default_time          INTEGER DEFAULT -1
);
-- テストデータ5件
INSERT INTO types_of_training (event_name, mets, movie_url, default_number, default_time) VALUES('スクワット',5,'<iframe width="560" height="315" src="https://www.youtube.com/embed/SFnfYPktYBU?si=JZmpunSJZI2-KeiI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',10,-1);
INSERT INTO types_of_training (event_name, mets, movie_url, default_number, default_time) VALUES('腕立て伏せ',3.5,'<iframe width="560" height="315" src="https://www.youtube.com/embed/k4fsFKCp5iU?si=2NpfOIwMJKHlNoYN" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',10,-1);
INSERT INTO types_of_training (event_name, mets, movie_url, default_number, default_time) VALUES('上体起こし',3.5,'<iframe width="560" height="315" src="https://www.youtube.com/embed/kXEBIOJyXmo?si=X0asHFktJa4RwIov" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',10,-1);
INSERT INTO types_of_training (event_name, mets, movie_url, default_number, default_time) VALUES('背筋',3.5,'<iframe width="560" height="315" src="https://www.youtube.com/embed/cPmZpupDLrE?si=__fsLiOMay7MT8z6" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',10,-1);
INSERT INTO types_of_training (event_name, mets, movie_url, default_number, default_time) VALUES('プランク',8,'<iframe width="560" height="315" src="https://www.youtube.com/embed/lSKmC3kLT6w?si=B3H8aaMBADVDtV_7" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',-1,20);

--トレーニング説明テーブル
CREATE TABLE training_descriptions(
  training_event_id 	INTEGER,
  step 							INTEGER,
  explanation 				TEXT,
  PRIMARY KEY(training_event_id, step),
  FOREIGN KEY(training_event_id) REFERENCES types_of_training(training_event_id)
);

--トレーニングプログラム詳細テーブル
CREATE TABLE traning_programs_detail(
    detail_id             					SERIAL PRIMARY KEY,
    training_program_id   		INTEGER,
    step                 					INTEGER,
    training_event_id     			INTEGER,
    FOREIGN KEY(training_program_id) REFERENCES training_programs(training_program_id),
    FOREIGN KEY(training_event_id) REFERENCES types_of_training(training_event_id)
);
-- テストデータ5件＋
INSERT INTO traning_programs_detail(training_program_id, step, training_event_id) VALUES(1,1,1);
INSERT INTO traning_programs_detail(training_program_id, step, training_event_id) VALUES(1,2,2);
INSERT INTO traning_programs_detail(training_program_id, step, training_event_id) VALUES(1,3,3);
INSERT INTO traning_programs_detail(training_program_id, step, training_event_id) VALUES(1,4,4);
INSERT INTO traning_programs_detail(training_program_id, step, training_event_id) VALUES(1,5,5);

--トレーニング記録テーブル
CREATE TABLE training_records(
  training_record_id 	SERIAL PRIMARY KEY,
  user_id 						INTEGER,
  training_event_id 	INTEGER,
  date DATE,
  number INTEGER DEFAULT 0,
  time DOUBLE DEFAULT 0,
  calories_burned INTEGER DEFAULT 0,
  FOREIGN KEY(user_id) REFERENCES muscle_users(id),
  FOREIGN KEY(training_event_id) REFERENCES types_of_training(training_event_id)
);
--テストデータ
INSERT INTO training_records (user_id, training_event_id, date, number, time, calories_burned)
VALUES
(2, 1, '2023-01-05', 10, 0, 300),
(3, 2, '2023-01-07', 30, 0, 500),
(3, 3, '2023-01-06', 20, 0, 400)
;


-- ここから食事に関するテーブル
--カテゴリー
CREATE TABLE category(
	category_id 				SERIAL PRIMARY KEY,
	category_name 			VARCHAR(10)
);

--カテゴリーテーブルのデータ
INSERT INTO category (category_name) VALUES
	('肉'),
	('魚'),
	('卵'),
	('乳製品'),
	('豆'),
	('野菜'),
	('果物'),
	('その他')
;

--カテゴリー別食事メニュー
CREATE TABLE meal_menu_by_category(
  category_id 	INTEGER,
  food_id 		INTEGER,
  PRIMARY KEY(category_id, food_id),
  FOREIGN KEY(category_id) REFERENCES category(category_id),
  FOREIGN KEY(food_id) REFERENCES meal_menus(food_id)
);

--食事記録
CREATE TABLE meal_record(
  id 					SERIAL 					PRIMARY KEY,
  user_id 			INTEGER,
  date 				DATE 						DEFAULT CURRENT_DATE,
  food_name 	VARCHAR(128),
  calorie 			INTEGER,
  food_id 		INTEGER,
  FOREIGN KEY(user_id) REFERENCES muscle_users(id),
  FOREIGN KEY(food_id) REFERENCES meal_menus(food_id)
);

