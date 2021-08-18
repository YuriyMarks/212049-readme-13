USE readme;

-- Добавление информации в БД
-- Записываем данные (список типов контента для поста)
INSERT INTO content_types
	(type, class_name)
VALUES
	('Текст', 'text'),
	('Цитата', 'quote'),
	('Картинка', 'photo'),
	('Видео', 'video'),
	('Ссылка', 'link');

-- Добавляем пользователей
INSERT INTO users
	(email, login, password)
VALUES
	('larisa@gmail.com', 'Лариса', 'qwerty'),
	('vladik@gmail.com', 'Владик', '12345'),
	('viktor@gmail.com', 'Виктор', 'qaz');

-- Добавляем существующий список постов
INSERT INTO posts
	(title, content, quote_author, image, video, link, num_of_views, user_id, content_type_id)
VALUES
	(
		'Цитата', 
		'Мы в жизни любим только раз, а после ищем лишь похожих', 
		'Лариса',
		'',
		'',
		'',
		11,
		1, 
		2
	),
	(
		'Игра престолов', 
		'Не могу дождаться начала финального сезона своего любимого сериала!', 
		'Владик', 
		'',
		'',
		'',
		22,
		2, 
		2
	),
	(
		'Наконец, обработал фотки!',
		'',
		'Виктор',
		'rock-medium.jpg',
		'',
		'',
		35,
		3,
		3
	),
	(
		'Моя мечта',
		'',
		'Лариса',
		'coast-medium.jpg',
		'',
		'',
		22,
		1,
		3
	),
	(
		'Лучшие курсы',
		'',
		'Владик',
		'',
		'',
		'www.htmlacademy.ru ',
		1,
		2,
		5
	);

-- Добавить лайк к посту
INSERT INTO likes VALUES
					(1, 2),
					(1, 2),
					(1, 2),
					(2, 3),
					(2, 3),
					(3, 1);

-- Подписаться на пользователя
INSERT INTO subscriptions VALUES (1, 2);

-- Добавляем три комментария
INSERT INTO comments
	(comment, user_id, post_id)
VALUES
	('Отличный сериал!', 1, 2),
	('Сериал бомба!', 3, 2),
	('Шикарная цитата!', 2, 1);

-- Запросы для этих действий
-- Получить список постов с сортировкой по популярности и вместе с именами авторов и типом контента
SELECT posts.id, content, num_likes, login, type FROM posts
	LEFT JOIN (
		SELECT post_id, COUNT(post_id) AS num_likes FROM likes
		GROUP BY post_id
	) AS result ON posts.id = result.post_id
	RIGHT JOIN content_types ON content_types.id = posts.content_type_id
	RIGHT JOIN users ON users.id = posts.user_id
 	ORDER BY num_likes DESC;

-- Получить список постов для конкретного пользователя
SELECT content, login FROM posts
	INNER JOIN users ON users.id = posts.user_id
	WHERE users.id = 2;

-- Получить список комментариев для одного поста, в комментариях должен быть логин пользователя
SELECT comment, login FROM comments
	INNER JOIN users ON users.id = comments.user_id
	WHERE post_id = 2;
