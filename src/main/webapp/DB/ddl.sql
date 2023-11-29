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
	('Chicken Salad', 300, 25, 12, 10, true),
	('Vegetable Stir-fry', 200, 8, 6, 15, true),
	('Fruit Smoothie', 150, 5, 2, 30, false),
	('Pasta with Tomato Sauce', 400, 12, 10, 40, true)
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
    id          SERIAL PRIMARY KEY,
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

--トレーニングプログラム詳細
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




