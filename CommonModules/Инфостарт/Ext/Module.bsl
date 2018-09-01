﻿
Функция КаналДефолт() Экспорт
	Возврат Справочники.Каналы.Инфостарт;
КонецФункции

Функция КомПарсерСоздать(КомОбъект)
	Если КомОбъект = Неопределено Тогда
		Попытка
			КомОбъект = Новый COMОбъект("Msxml2.DOMDocument");
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	Возврат КомОбъект;
КонецФункции

Функция ДатаПреобразовать(Знач Слово)
	Сдвиг = 0;
	Если Найти(Слово, "+") > 0 Тогда
		Попытка
			Сдвиг = Число(Сред(Слово, Найти(Слово, "+") + 1));
			Слово = Лев(Слово, Найти(Слово, "+") - 1);
		Исключение
			Сдвиг = 0;
		КонецПопытки;
	ИначеЕсли Найти(Слово, "-") > 0 Тогда
		Попытка
			Сдвиг = - Число(Сред(Слово, Найти(Слово, "-") + 1));
			Слово = Лев(Слово, Найти(Слово, "-") - 1);
		Исключение
			Сдвиг = 0;
		КонецПопытки;
	КонецЕсли;
	День	= "";
	Месяц	= Формат(Месяц(ТекущаяДата()), "ЧЦ=2; ЧВН=");
	Год		= Формат(Год(ТекущаяДата()), "ЧЦ=4; ЧВН=");
	Время	= "";
	Кондуит = Новый Массив;
	Кондуит.Добавить(", ");
	Кондуит.Добавить("Sun");
	Кондуит.Добавить("Mon");
	Кондуит.Добавить("Tue");
	Кондуит.Добавить("Wed");
	Кондуит.Добавить("Thu");
	Кондуит.Добавить("Fri");
	Кондуит.Добавить("Sat");
	Для Каждого тЭлемент Из Кондуит Цикл
		Слово = СтрЗаменить(Слово, тЭлемент, "");
	КонецЦикла;
	
	День = Формат(Лев(Слово, 2), "ЧЦ=2; ЧВН=");
	Если НЕ ПустаяСтрока(День) Тогда
		Слово = СокрЛП(Сред(Слово, Найти(Слово, " ")));

		Кондуит.Очистить();
		Кондуит.Добавить("Jan");
		Кондуит.Добавить("Feb");
		Кондуит.Добавить("Mar");
		Кондуит.Добавить("Apr");
		Кондуит.Добавить("May");
		Кондуит.Добавить("Jun");
		Кондуит.Добавить("Jul");
		Кондуит.Добавить("Aug");
		Кондуит.Добавить("Sep");
		Кондуит.Добавить("Oct");
		Кондуит.Добавить("Nov");
		Кондуит.Добавить("Dec");
		
		Для Каждого тЭлемент Из Кондуит Цикл
			Если Найти(Слово, тЭлемент) > 0 Тогда
				Месяц	= Формат(Кондуит.Найти(тЭлемент) + 1, "ЧЦ=2; ЧВН=");
				Год		= Лев(СокрЛП(Сред(Слово, Найти(Слово, тЭлемент) + 4)), 4);
				Если Найти(Слово, ":") > 0 Тогда
					Время	= СокрЛП(СтрЗаменить(Сред(Слово, Найти(Слово, ":") - 2), ":", ""));
				КонецЕсли;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Попытка
		Дата = Дата(Год + Месяц + День + Время) + (Цел(Сдвиг / 100) * 60 + (Сдвиг - Цел(Сдвиг / 100) * 100)) * 60;
	Исключение
		Дата = ТекущаяДата();
	КонецПопытки;
	Возврат Дата;
КонецФункции

Функция Цензура(Знач Слово)
	Кондуит = Новый Массив;
	Кондуит.Добавить("&quot;");
	Для Каждого тЭлемент Из Кондуит Цикл
		Слово = СтрЗаменить(Слово, тЭлемент, "");
	КонецЦикла;
	Возврат СокрЛП(Слово);
КонецФункции

Функция БукваПравославная(Буква)
	Возврат (Найти("/", Буква) = 0);
КонецФункции

Функция НомерПолучить(Знач Слово)
	Слово = СокрЛП(СтрЗаменить(Слово, "/", " "));
	Пока Найти(Слово, " ") > 0 Цикл
		Слово = Сред(Слово, Найти(Слово, " ") + 1);
	КонецЦикла;
	Возврат Слово;
КонецФункции

Функция АвторНайти(Канал, Знач Слово="")
	Автор = Неопределено;
	Код = "";
	Если НЕ ПустаяСтрока(Слово) И Найти(Слово, "infostart.ru/profile") > 0 Тогда
		Слово = Сред(Слово, Найти(Слово, "infostart.ru/profile/") + 21);
		Для Итератор=1 По СтрДлина(Слово) Цикл
			Если БукваПравославная(Сред(Слово, Итератор, 1)) Тогда
				Код = Код + Сред(Слово, Итератор, 1);
			Иначе
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Если ПустаяСтрока(Код) И НЕ ПустаяСтрока(Слово) Тогда
		Автор = Справочники.Авторы.НайтиПоНаименованию(Слово, Истина, , Канал);
		Если Автор.Пустая() Тогда
			Объект = Справочники.Авторы.СоздатьЭлемент();
			Объект.Наименование	= Слово;
			Объект.Владелец		= Канал;
			Объект.Записать();
			
			Автор = Объект.Ссылка;
		КонецЕсли;
	ИначеЕсли ПустаяСтрока(Код) Тогда
		Наименование = Канал.Наименование;
		Автор = Справочники.Авторы.НайтиПоНаименованию("", , , Канал);
		Если Автор.Пустая() Тогда
			Объект = Справочники.Авторы.СоздатьЭлемент();
			ЗаполнитьЗначенияСвойств(Объект, Канал, "Код,Наименование");
			Объект.Владелец		= Канал;
			Объект.Записать();
			
			Автор = Объект.Ссылка;
		ИначеЕсли Автор.Наименование <> Канал.Наименование Тогда
			
			Объект = Автор.ПолучитьОбъект();
			Объект.Наименование = Канал.Наименование;
			Объект.Записать();
		КонецЕсли;
	Иначе
		Автор = Справочники.Авторы.НайтиПоКоду(Код, , , Канал);
		Если Автор.Пустая() Тогда
			Наименование = Сред(Слово, СтрДлина(Код) + 4);
			Наименование = Лев(Наименование, Найти(Наименование, "<") - 1);
			Автор = Справочники.Авторы.НайтиПоНаименованию(Наименование, Истина, , Канал);
			Если Автор.Пустая() Тогда
				Объект = Справочники.Авторы.СоздатьЭлемент();
				Объект.Код			= Код;
				Объект.Наименование	= Наименование;
				Объект.Владелец		= Канал;
				Объект.Записать();
				
				Автор = Объект.Ссылка;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	//Если Автор.ПометкаУдаления Тогда
	//	Объект = Автор.ПолучитьОбъект();
	//	Объект.УстановитьПометкуУдаления(Ложь);
	//	Объект.Записать();
	//КонецЕсли;
	Возврат Автор;
КонецФункции

Функция ЭлементПрочитать(Элемент, Имя)
	Ответ = "";
	Ветка = Элемент.SelectSingleNode(Имя);
	Если Ветка <> Неопределено Тогда
		Ответ = Ветка.Text;
	КонецЕсли;
	Возврат Ответ;
КонецФункции

Функция Парсить(Текст, Канал, КомПарсер=Неопределено, КомЗагрузчик=Неопределено)
	Если ПустаяСтрока(Текст) Тогда
		Возврат 0;
	КонецЕсли;
	КомПарсер		= КомПарсерСоздать(КомПарсер);
	Если КомПарсер = Неопределено Тогда
		Возврат 0;
	КонецЕсли;
	КомПарсер.LoadXML(Текст);
	КомПарсер.SetProperty("SelectionLanguage", "XPath");
	КомПарсер.SetProperty("SelectionNamespaces", "xmlns:d='http://schemas.microsoft.com/ado/2007/08/dataservices' xmlns:m='http://schemas.microsoft.com/ado/2007/08/dataservices/metadata' xmlns:a='http://www.w3.org/2005/Atom'");
	СписокЭлементов = КомПарсер.SelectNodes("rss/channel/item");
	ФрешСтеп = Новый Структура("Канал,Дата,Номер,Автор,Заголовок,Описание,ТекстСтатьи,Гиперссылка", Канал);
	
	Счетовод		= 0;
	Запрос			= Новый Запрос;
	Запрос.УстановитьПараметр("Канал",	Канал);
	Для Каждого Элемент ИЗ СписокЭлементов Цикл
		ФрешСтеп.Заголовок	= Цензура(Элемент.SelectSingleNode("title").Text);
		ФрешСтеп.Гиперссылка= ЭлементПрочитать(Элемент, "link");
		Если ПустаяСтрока(ФрешСтеп.Заголовок) Или ПустаяСтрока(ФрешСтеп.Гиперссылка) Тогда
			Продолжить;
		КонецЕсли;
		ФрешСтеп.Дата		= ДатаПреобразовать(Элемент.SelectSingleNode("pubDate").Text);
		ФрешСтеп.Описание	= ЭлементПрочитать(Элемент, "description");
		
		Если Канал.Парсер = Перечисления.Парсеры.Инфостарт Тогда
			ФрешСтеп.Номер = НомерПолучить(ФрешСтеп.Гиперссылка);
			
			ФрешСтеп.Автор = АвторНайти(Канал, ФрешСтеп.Описание);
			Если Регламент.ЗагружатьТекстыПубликацийПриЗагрузке() И НЕ ПустаяСтрока(Канал.Гиперссылка) Тогда
				ФрешСтеп.ТекстСтатьи = СкачатьПоСсылке(Канал.Гиперссылка + ФрешСтеп.Номер + "/", КомЗагрузчик);
			Иначе
				ФрешСтеп.ТекстСтатьи = "";
			КонецЕсли;
			
			Если ПустаяСтрока(Запрос.Текст) Тогда
				Запрос.Текст = "ВЫБРАТЬ
				               |	Публикация.Ссылка КАК Документ,
				               |	Публикация.Проведен КАК Проведен
				               |ИЗ
				               |	Документ.Публикация КАК Публикация
				               |ГДЕ
				               |	Публикация.Номер = &Номер
				               |	И Публикация.Канал = &Канал";
			КонецЕсли;
			Запрос.УстановитьПараметр("Номер",	ФрешСтеп.Номер);
		Иначе
			
			Автор = ЭлементПрочитать(Элемент, "author");
			Если НЕ ПустаяСтрока(Автор) Тогда
				ФрешСтеп.Автор = АвторНайти(Канал, Автор);
			КонецЕсли;
			
			Если ПустаяСтрока(Запрос.Текст) Тогда
				Запрос.Текст = "ВЫБРАТЬ
				               |	Публикация.Ссылка КАК Документ,
				               |	Публикация.Проведен
				               |ИЗ
				               |	Документ.Публикация КАК Публикация
				               |ГДЕ
				               |	Публикация.Канал = &Канал
				               |	И Публикация.Гиперссылка ПОДОБНО &Гиперссылка";
			КонецЕсли;
			Запрос.УстановитьПараметр("Гиперссылка",	ФрешСтеп.Гиперссылка);
		КонецЕсли;
		ПредЗапрос = Запрос.Выполнить();
		Если ПредЗапрос.Пустой() Тогда
			Документ = Документы.Публикация.СоздатьДокумент();
			
			Счетовод	= Счетовод + 1;
		Иначе
			Выборка = ПредЗапрос.Выбрать();
			Выборка.Следующий();
			//Если Выборка.Проведен Тогда
			//	Продолжить;
			//КонецЕсли;
			Документ = Выборка.Документ.ПолучитьОбъект();
			//Если НЕ ПустаяСтрока(Документ.ТекстСтатьи) Тогда
			//	Продолжить;
			//КонецЕсли;
		КонецЕсли;
		ЗаполнитьЗначенияСвойств(Документ, ФрешСтеп);
		Попытка
			Документ.Записать(?(ФрешСтеп.Автор.ПометкаУдаления, РежимЗаписиДокумента.Проведение, РежимЗаписиДокумента.Запись));
		Исключение
			ЗаписьЖурналаРегистрации("Сохранение " + Строка(Документ), УровеньЖурналаРегистрации.Ошибка, Метаданные.Документы.Публикация, , ОписаниеОшибки());
		КонецПопытки;
	КонецЦикла;
	
	Если Регламент.ВестиПротоколЗагрузки() Тогда
		Запись = РегистрыСведений.Загрузки.СоздатьМенеджерЗаписи();
		Запись.Период		= ТекущаяДата();
		Запись.Канал		= Канал;
		Если Регламент.ВестиПротоколЗагрузкиПодробно() Тогда
			Запись.Комментарий	= Текст;
		КонецЕсли;
		Попытка
			Запись.Записать(Ложь);
		Исключение
			ЗаписьЖурналаРегистрации("Сохранение " + Строка(Документ), УровеньЖурналаРегистрации.Ошибка, Метаданные.РегистрыСведений.Загрузки, , ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	Возврат Счетовод;
КонецФункции

Функция СкачатьПоСсылке(Гиперссылка, КомОбъект=Неопределено) Экспорт
	Ответ = "";
	Если НЕ ПустаяСтрока(Гиперссылка) Тогда
		Попытка
			Если КомОбъект = Неопределено Тогда
				КомОбъект = Новый COMОбъект("Msxml2.XMLHTTP");
			КонецЕсли;
			КомОбъект.Open("GET", Гиперссылка, false);
			КомОбъект.Send();
			Ответ = КомОбъект.responseText;
		Исключение
			ЗаписьЖурналаРегистрации("Загрузка RSS", УровеньЖурналаРегистрации.Ошибка, Метаданные.РегламентныеЗадания.ЗагрузкаRSS, , ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	Возврат Ответ;
КонецФункции

Функция ЗагрузитьRSS(Знач Канал=Неопределено) Экспорт
	Ответ = 0;
	КомЗагрузчик	= Неопределено;
	КомПарсер		= Неопределено;
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	Каналы.Ссылка КАК Канал,
	                      |	Каналы.Гиперссылка КАК Гиперссылка,
	                      |	ЕСТЬNULL(ВложенныйЗапрос.Период, &Период) КАК Период,
	                      |	ВЫБОР
	                      |		КОГДА Каналы.Ссылка.ПериодОбновления = 0
	                      |			ТОГДА 60
	                      |		ИНАЧЕ Каналы.Ссылка.ПериодОбновления * 60
	                      |	КОНЕЦ КАК ПериодОбновления
	                      |ИЗ
	                      |	Справочник.Каналы.Гиперссылки КАК Каналы
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	                      |			Каналы.Ссылка КАК Канал,
	                      |			МАКСИМУМ(ВложенныйЗапрос.Период) КАК Период
	                      |		ИЗ
	                      |			Справочник.Каналы КАК Каналы
	                      |				ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	                      |					Загрузки.Канал КАК Канал,
	                      |					МАКСИМУМ(ЕСТЬNULL(Загрузки.Период, &Период)) КАК Период
	                      |				ИЗ
	                      |					РегистрСведений.Загрузки КАК Загрузки
	                      |				ГДЕ
	                      |					Загрузки.Канал = &Канал
	                      |				
	                      |				СГРУППИРОВАТЬ ПО
	                      |					Загрузки.Канал
	                      |				
	                      |				ОБЪЕДИНИТЬ ВСЕ
	                      |				
	                      |				ВЫБРАТЬ
	                      |					Публикация.Канал,
	                      |					МАКСИМУМ(ЕСТЬNULL(Публикация.Дата, &Период))
	                      |				ИЗ
	                      |					Документ.Публикация КАК Публикация
	                      |				ГДЕ
	                      |					Публикация.Канал = &Канал
	                      |				
	                      |				СГРУППИРОВАТЬ ПО
	                      |					Публикация.Канал) КАК ВложенныйЗапрос
	                      |				ПО Каналы.Ссылка = ВложенныйЗапрос.Канал
	                      |		
	                      |		СГРУППИРОВАТЬ ПО
	                      |			Каналы.Ссылка
	                      |		
	                      |		ИМЕЮЩИЕ
	                      |			МАКСИМУМ(ВложенныйЗапрос.Период) < &Предел) КАК ВложенныйЗапрос
	                      |		ПО Каналы.Ссылка = ВложенныйЗапрос.Канал
	                      |ГДЕ
	                      |	Каналы.Заблокировано = ЛОЖЬ
	                      |	И Каналы.Ссылка.ПометкаУдаления = ЛОЖЬ
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	Период УБЫВ");
	Запрос.УстановитьПараметр("Канал",	Канал);
	Запрос.УстановитьПараметр("Период",	ДобавитьМесяц(ТекущаяДата(), -1));
	Запрос.УстановитьПараметр("Предел",	ТекущаяДата() - 180);				// минимальный период между обновлениями
	Если ПустаяСтрока(Канал) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Канал = &Канал", "Канал.ПометкаУдаления = ЛОЖЬ");
	КонецЕсли;
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Если ТекущаяДата() - Выборка.Период > Выборка.ПериодОбновления Тогда
			Текст = СкачатьПоСсылке(Выборка.Гиперссылка, КомЗагрузчик);
			Вольта = Парсить(Текст, Выборка.Канал, КомПарсер, КомЗагрузчик);
			
			Ответ = Ответ + Вольта;
		КонецЕсли;
	КонецЦикла;
	Возврат Ответ;
КонецФункции

Функция АдресИнформацииОКонфигурации() Экспорт
	Возврат Метаданные.АдресИнформацииОКонфигурации;
КонецФункции

Функция УРЛПолучить(Ссылка) Экспорт
	Возврат ?(ТипЗнч(Ссылка) = Тип("ДокументСсылка.Публикация"), Ссылка.Гиперссылка, ?(ТипЗнч(Ссылка) = Тип("СправочникСсылка.Авторы") И НЕ ПустаяСтрока(Ссылка.Код), "https://infostart.ru/profile/" + Ссылка.Код, ""));
КонецФункции
