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

--作り方
INSERT INTO recipe (food_id, step, explanation) VALUES
--簡単エッグベネディクト風サンド
(0,1,'ヨーグルト、マヨネーズ、七味唐辛子、レモン汁を混ぜ合わせソースを作っておく')
(0,2,'直径12cm、深さ5cmの耐熱皿に、生卵を割り入れ、黄身に竹串で2か所穴をあける')
(0,3,'かぶるぐらいに水を入れたら、ラップをせずに600w30秒電子レンジで加熱する')
(0,4,'10秒ずつ、様子をみながら加熱し、ポーチドエッグをつくる')
(0,5,'半分に割ったバンズの片方に、サラダ菜、スモークサーモン、ポーチドエッグの順にのせる')
(0,6,'step1のソースを上からかけ、もう片方のバンズを添える')
(0,7,'カットしたきゅうり、ミニトマトを添える')
--しらすチーズトースト
(0,1,'キャベツを千切りして塩をふり、もんで水分をしぼる')
(0,2,'トマトを1cmの角切りにする')
(0,3,'食パンにマヨネーズを塗って、パンの大きさに切った海苔をのせる')
(0,4,'塩もみキャベツ、しらす、トマト、とろけるチーズの順でのせる')
(0,5,'チーズに焼き目がつくまでトースターで焼く')
--レンジで簡単キーマカレー
(0,1,'ひき肉、大豆、にんにく、しょうがを耐熱ボウルに入れる')
(0,2,'step1に塩、ケチャップ、酒、しょうゆ、カレー粉を加えて全体に絡める')
(0,3,'step2に野菜、油を加えて混ぜる')
(0,4,'中央を少しへこませ、ラップをふんわりかけて600wのレンジに5分かける')
(0,5,'いったん取り出して、全体を混ぜる')
(0,6,'ふんわりラップをし、さらに1分ほど加熱し、2～3分予熱で蒸らす')
(0,7,'ご飯と一緒に皿に盛り、スライスしたゆで卵をそえる')
--明太豆乳クリームうどん
(0,1,'レンジにうどんをかけ解凍')
(0,2,'薄皮をはずした明太子を、ソース用とトッピング用に分ける')
(0,3,'玉ねぎはスライス、しめじはほぐす')
(0,4,'固いところをのぞいたアスパラを斜めに切る')
(0,5,'オリーブオイルをフライパンに入れて熱し、玉ねぎとしめじを炒める')
(0,6,'豆乳、ホタテ缶を汁ごと入れ加熱する')
(0,7,'沸騰したらアスパラ、ソース用の明太子、うどんをいれてなじませるように炒める')
(0,8,'塩、ブラックペッパーで味を調整し、トッピング用の明太子をのせる')
--春巻きの皮でラクラクキッシュ風
(0,1,'鮭はそぎ切り、たまねぎは1cmの角切り、ブロッコリーは小房に分ける')
(0,2,'オリーブオイル、塩、こしょうをふって軽く炒める')
(0,3,'耐熱皿にアルミホイルをしき、底の部分に油をぬり、上に春巻きの皮を交差させる')
(0,4,'皿から出た春巻きの皮を内側に折り込む')
(0,5,'ヘタを取ったミニトマト、step1を置く')
(0,6,'牛乳、卵、パルチザンチーズを混ぜて合わせた卵液を流し入れる')
(0,7,'温めたトースターで約10分加熱し、竹串をさして卵液が付かなかったら出来上がり')
--納豆味噌そぼろ丼
(0,1,'長ねぎをみじん切りにし、新玉ねぎをくし形に切る')
(0,2,'フライパンにごま油を加えて熱し、豚ひき肉を炒める')
(0,3,'長ねぎ、納豆を加えパラパラになるまで炒める')
(0,4,'酒、味噌、きび砂糖、豆板醤、白ごまを加え炒める')
(0,5,'別のフライパンにごま油を加えて玉ねぎを炒め、塩・こしょうで味つけをする')
(0,6,'卵に塩を入れて混ぜ、フライパンで炒め炒り卵を作る')
(0,7,'step4の納豆味噌そぼろ、step5の玉ねぎを一緒にごはんにのせる')
--たらこ、しらす、チーズバターのパスタ
(0,1,'たらこは薄皮に切れ目を入れて、包丁の背で身をこそげ出す')
(0,2,'かいわれ菜の根元を切り落とす')
(0,3,'ボウルに粉チーズ、バターを混ぜて、たらこを加えよく混ぜる')
(0,4,'鍋に湯を沸かし多めの塩を加える')
(0,5,'スパゲティを入れてほぐしながらゆでる')
(0,6,'step3にstep5、しらすとかいわれ菜を加えて手早く混ぜあわせ、器に盛る')
--ししゃも入り具だくさんみぞれうどん
(0,1,'シシャモを焼き、にんじん、大根はすりおろして水気を切っておく')
(0,2,'オクラは輪切り、まいたけは食べやすい大きさにほぐす')
(0,3,'鍋にめんつゆと水をいれて沸騰したら、オクラとまいたけをいれ再沸騰させる')
(0,4,'step3を電子レンジであたためた冷凍うどんにかける')
(0,5,'step4の上におろしたにんじんと大根、焼いたシシャモをのせる')
--納豆もち麦チャーハン
(0,1,'フライパンに油を熱してにんにくを炒め、香りが立ったらひき肉を加え炒める')
(0,2,'ひき肉がパラパラになったら塩・こしょうを加える')
(0,3,'さらに納豆ほどの大きさに切ったパプリカともち麦を加えて炒める')
(0,4,'油が全体に回り熱くなったらしょうゆ、砂糖を混ぜた納豆を加えてさっと炒める')
(0,5,'お好みでサラダ菜を添える')
--ささみとカラフル野菜のハニーソース
(0,1,'ささみの横に切り込みを入れて開き、軽く押してのばす')
(0,2,'鍋で小松菜を茹でて水を切り、ざく切りする')
(0,3,'オリーブオイル、酢、塩、こしょうをまぜてドレッシングを作る')
(0,4,'ピーマンと小松菜を和えて皿に置く')
(0,5,'鍋を沸騰させ、ささみを入れて約2分茹でる')
(0,6,'中まで火が通ったら水気を切ってstep4の皿にのせる')
(0,7,'粉マスタード、はちみつ、塩こうじを混ぜ合わせてハニーソースを作る')
(0,7,'step7をささみに塗る')
--たらとじゃがいものカレー炒め
(0,1,'タラをひと口大に、じゃがいもを1cm厚の半月切りに、いんげんを4～5cmの長さに切る')
(0,2,'にんにくを薄切りにする')
(0,3,'フライパンににんにく、オリーブオイルを入れて中火にかける')
(0,4,'まわりに小麦粉をまぶしたタラ、じゃがいもを入れて2～3分焼く')
(0,5,'じゃがいも、タラを裏返し、いんげんをいれ、さらに2～3分焼く')
(0,6,'カレー粉を全体にまぶし、砂糖、酒、しょうゆを加えて全体に絡め、味を整える')
--納豆とオクラの麻婆豆腐
(0,1,'水気を切った豆腐を2cm角に切る')
(0,2,'納豆にしょうゆをいれて混ぜる')
(0,3,'水、鶏ガラのスープの素、オイスターソース、砂糖を混ぜ合わせておく')
(0,4,'油、にんにく、しょうがをフライパンに入れて弱火で炒める')
(0,5,'香りがでてきたら長ねぎを加えてさっと炒める')
(0,6,'step3と豆腐を入れて中火で約2分煮る')
(0,7,'納豆とオクラをいれてさっと煮て、とろみがついたら火を止める')
(0,8,'お好みでラー油をかける')
--きのこの肉巻きごまみそレンジ蒸し
(0,1,'肉に酒をまぶし、10等分に分けたしめじに、らせん状に巻き付ける')
(0,2,'耐熱皿にstep1を並べて、味噌、すり白ごま、砂糖、酒、ごま油、片栗粉を混ぜたタレをかける')
(0,3,'step2にふんわりラップをかけ、レンジ600Wで4分加熱して2分蒸らす')
(0,4,'step3の肉巻きをころがして耐熱皿に出た水気と調味料をなじませてとろみを出し、ねぎを散らす')
--ヘルシーアジフライ
(0,1,'アジを3枚におろし腹骨をとる')
(0,2,'酒をからめて水気をふいたら、塩こしょうをふる')
(0,3,'小麦粉、溶き卵、ざるに通して細かくしたパン粉をまぶす')
(0,4,'フライパンに油を熱し、アジの身側から3分ほど中火で焼いたら、返して2～3分焼く')
(0,5,'キャベツとベビーリーフを混ぜstep4と一緒に皿に盛る')
(0,6,'step5に玉ねぎ（みじん切り）、マヨネーズ、粉マスタードを添える')
--しゃきしゃき長いもと豆腐のふんわりつくね
(0,1,'長ねぎはみじん切りに、長いもは8㎜角に切る')
(0,2,'ボウルに鶏ひき肉、木綿豆腐、卵、長ねぎ、長いも、味噌、片栗粉を入れよく混ぜて8等分にする')
(0,3,'ごま油をフライパンに入れて中火にかけ、step2を入れ片面2～3分ずつ焼く')
(0,4,'全体に火が通ったら、酒、しょうゆ、砂糖を入れて絡め、小ねぎを散らす')
--豚肉とニラのオートミールチヂミ
(0,1,'豚肉を1cm幅に、ニラは3cmの長さに切る')
(0,2,'耐熱ボウルに水とオートミールを混ぜ、ラップなしで600wのレンジで1分加熱する')
(0,3,'粗熱が取れたら卵を加えてよく混ぜ、豚肉、ニラ、桜エビ、塩を加えて混ぜる')
(0,4,'ごま油をフライパンに中火で熱し、step3を入れる')
(0,5,'3分ほど焼いて焼き目がついたら皿などを使って裏返し、さらに1～2分焼く')
(0,6,'食べやすい大きさに切って盛り付け、酢じょうゆを添える')
--ささみのゴマスティック
(0,1,'ささみは筋を取り、縦にそぎ切りにする')
(0,2,'ささみに酒、しょうゆ、しょうがチューブをまんべんなくもみ込み、２０分～ひと晩漬けておく')
(0,3,'バットに片栗粉、いりごま（白）、いりごま（黒）を広げて混ぜ合わせたら、ささみにまんべんなくまぶす')
(0,4,'フライパンに多めの油を熱し、中火～強めの中火で３を揚げ焼きにする')
--鶏そぼろひじき
(0,1,'ひじきを水で戻す')
(0,2,'フライパンに少量の油を熱し、鶏ひき肉を入れ、弱めの中火でそぼろ状になるように炒める')
(0,3,'ひじきの水気を切ってフライパンに入れ、全体を炒め合わせる')
(0,4,'step3に砂糖、しょうゆ、白だし、しょうがチューブを入れ、ほどよく汁気が飛ぶまで炒め合わせる')
(0,5,'火を止め、お好みで小ねぎをさっくり混ぜる')
--鶏ささみと茄子の黒酢炒め
(0,1,'ささみは筋を取り、そぎ切りにする')
(0,2,'フライパンに油を入れ、黒酢、しょうゆ、みりん、砂糖はボウルで混ぜ合わせる')
(0,3,'なすはへたを切り落とし、横半分に切ったら、さらに縦半分に切り、皮に斜めの切り込みを入れる')
(0,4,'切ったらすぐにフライパンに入れ、油をからませる')
(0,5,'ささみに片栗粉を薄くまぶす')
(0,6,'フライパンを中火にかけ、なすを端によせたら、ささみを入れて表面の色が変わるくらいまで炒める')
(0,7,'step6に黒酢、しょうゆ、みりん、砂糖を入れ、３～４分ほど煮からめる')
(0,8,'お好みでいりごま、小ねぎを散らす')
--ヤンニョムチキン
--チキンのトマト煮込み
--梅しそチーズのつくね
--豚ロースの酢豚風炒め
--トンテキ
--肉豆腐
--豆腐とキムチの豆乳スープ
--ひじき入り豆腐ハンバーグ
--厚揚げの豚肉巻き
--豆腐しゅうまい
--厚揚げの甘辛ごま焼き
--厚揚げとししとうのおかか炒め
--バターチキンカレー
--鮭のほぐし身と玉ねぎのチーズ焼き
--鶏肉とかぼちゃのクリーム煮
--ほうれん草のオムレツ
--タラの和風チーズ焼き
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
