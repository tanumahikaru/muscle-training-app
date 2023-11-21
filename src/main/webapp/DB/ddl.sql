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
    cardo             		INTEGER,
    main_dish_flag   boolean
);

-- テストデータ
INSERT INTO meal_menus (food_name, calorie, protein, fat, cardo, main_dish_flag) VALUES
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