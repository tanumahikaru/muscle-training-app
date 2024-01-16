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
('ささみのゴマスティック',172,22,4,9,TRUE)
('鶏そぼろひじき',162,24,3,12,TRUE)
('鶏ささみの茄子の黒酢炒め',138,13,3,14,TRUE)
('ヤンニョムチキン',282,28,32,58,TRUE)
('チキンのトマト煮込み',245,15,13,16,TRUE)
('梅しそチーズのつくね',267,32,9,13,TRUE)
('豚ロースの酢豚風炒め',458,36,24,22,TRUE)
('トンテキ',457,32,28,14,TRUE)
('肉豆腐',246,24,13,6,TRUE)
('豆腐とキムチの豆乳スープ',62,6,4,4,FALSE)
('ひじき入り豆腐ハンバーグ',217,24,10,9,TRUE)
('厚揚げの豚肉巻き',345,14,25,12,TRUE)
('豆腐シュウマイ',300,16,17,18,TRUE)
('厚揚げの甘辛ゴマ焼き',238,13,15,14,TRUE)
('厚揚げとしし唐のおかか炒め',187,10,12,10,TRUE)
('バターチキンカレー',573,38,42,19,TRUE)
('鮭のほぐし身と玉ねぎのチーズ焼き',440,25,36,7,TRUE)
('鶏肉とかぼちゃのクリーム煮',233,14,10,9,TRUE)
('ほうれん草のオムレツ',195,14,14,4,TRUE)
('タラの和風チーズ焼き',70,12,2,1,TRUE)
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

--クイズ
CREATE TABLE quiz(
  quiz_id INTEGER PRIMARY KEY,
  question TEXT, 
  title VARCHAR(128),
  choices_1 VARCHAR(128),
  choices_2 VARCHAR(128),
  choices_3 VARCHAR(128),
  choices_4 VARCHAR(128),
  correct  INTEGER,
  explanation TEXT
);

INSERT INTO quiz (quiz_id, question, title, choices_1, choices_2, choices_3, choices_4, correct) VALUES
(1,'筋肉の成長を促進するためには、どの栄養素が必要?','筋肉と栄養素','タンパク質','脂質','炭水化物','ビタミンC',1),
(2,'筋肉が1kg増えたときの基礎代謝の増加量は何kcal?','筋肉と基礎代謝','3kcal','13kcal','23kcal','33kcal',2),
(3,'筋トレの効果が目視できるまでどれくらいかかる?','成果が見えるまで','1週間','1ヶ月','3ヶ月','半年',3),
(4,'筋トレは筋肉以外にどんな効果を及ぼす?','筋トレと脳1','記憶力が良くなる','ストレス耐性がつく','頭の回転が早くなる','1, 2, 3全て',4),
(5,'筋トレによって脳を活性化する最適な運動法は？','筋トレと脳2','10分程度の有酸素運動','30分程度の有酸素運動','30分程度の筋トレ','1時間程度の筋トレ',2),
(6,'筋肥大が目的の場合、セット間の休憩時間は？','セット間の休憩1','0~90秒','1~2分','3~5分','5分以上',2),
(7,'筋力向上が目的の場合、セット間の休憩時間は？','セット間の休憩2','0~90秒','1~2分','3~5分','5分以上',3),
(8,'持久力向上が目的の場合、セット間の休憩時間は？','セット間の休憩3','0~90秒','1~2分','3~5分','5分以上',1),
(9,'筋肥大が目的の場合、Max重量の何%でトレーニングすると良い？','負荷のかけ方1','~59%','60~66%','67~86%','87~100%',3),
(10,'筋力向上が目的の場合、Max重量の何%でトレーニングすると良い？','負荷のかけ方2','~59%','60~66%','67~86%','87~100%',4);

--回答状況
CREATE TABLE answer_record(
  user_id INTEGER,
  quiz_id INTEGER,
  status INTEGER DEFAULT 1,
  PRIMARY KEY(user_id, quiz_id),
  FOREIGN KEY(user_id) REFERENCES muscle_users(id),
  FOREIGN KEY(quiz_id) REFERENCES quiz(quiz_id)
);

--マッスルコール
CREATE TABLE muscle_call(
  id SERIAL PRIMARY KEY,
  call VARCHAR(32),
  evaluation INTEGER
 );
