﻿
Процедура ПередНачаломРаботыСистемы() Экспорт
	Попытка
		КомОбъект = Новый COMОбъект("Msxml2.XMLHTTP");
	Исключение
		Возврат;
	КонецПопытки;
		
	//Файлы = Новый Соответствие;
	//Файлы.Вставить(КаталогВременныхФайлов() + "kernel_main.css", "http://infostart.ru/bitrix/cache/css/ru/print/kernel_main/kernel_main.css");
	////Файлы.Вставить(КаталогВременныхФайлов() + "template_f40a4fbe6b365bdb07c4903ed54719690.css", "http://infostart.ru/bitrix/cache/css/ru/print/template_f40a4fbe6b365bdb07c4903ed5471969/template_f40a4fbe6b365bdb07c4903ed54719690.css");
	//Файлы.Вставить(КаталогВременныхФайлов() + "styles.css", "http://infostart.ru/bitrix/templates/print/styles.css");
	//Файлы.Вставить(КаталогВременныхФайлов() + "template_styles.css", "http://infostart.ru/bitrix/templates/print/template_styles.css");
	//Файлы.Вставить(КаталогВременныхФайлов() + "highlight1c.js", "http://infostart.ru/bitrix/templates/.default/js/highlight1c.js");
	//
	//ТекФайл		= Новый ТекстовыйДокумент;
	//Для Каждого тЭлемент Из Файлы Цикл
	//	Попытка
	//		ТекФайл.Прочитать(тЭлемент.Ключ);
	//	Исключение
	//	КонецПопытки;
	//	Если ТекФайл.КоличествоСтрок() = 0 Тогда
	//		Попытка
	//			КомОбъект.Open("GET", тЭлемент.Значение, false);
	//			КомОбъект.Send();
	//			Текст = КомОбъект.responseText;
	//			Если НЕ ПустаяСтрока(Текст) Тогда
	//				ТекФайл.УстановитьТекст(Текст);
	//				ТекФайл.Записать(тЭлемент.Ключ, "windows-1251");
	//			КонецЕсли;
	//		Исключение
	//			Прервать;
	//		КонецПопытки;
	//	КонецЕсли;
	//КонецЦикла;
	Если Регламент.ЗагружатьRSSПриСтарте() Тогда
		Загрузить();
	КонецЕсли;
КонецПроцедуры

Процедура ОткрытьПоСсылке(Знач Гиперссылка) Экспорт
	Если ТипЗнч(Гиперссылка) =  Тип("Строка") И НЕ ПустаяСтрока(Гиперссылка) Тогда
		ПерейтиПоНавигационнойСсылке(Гиперссылка);
		//СистемнаяИнформация = Новый СистемнаяИнформация;
		//Если Лев(СистемнаяИнформация.ТипПлатформы, 7) = "Windows" Тогда
		//	Шел = Новый COMObject("WScript.Shell");
		//	Шел.Run(Гиперссылка);
		//КонецЕсли;
	ИначеЕсли ТипЗнч(Гиперссылка) = Тип("ДокументСсылка.Публикация") Тогда
		ОткрытьПоСсылке(Инфостарт.УРЛПолучить(Гиперссылка));
	ИначеЕсли ТипЗнч(Гиперссылка) = Тип("СправочникСсылка.Авторы") Тогда
		ОткрытьПоСсылке(Инфостарт.УРЛПолучить(Гиперссылка));
	КонецЕсли;
КонецПроцедуры

Процедура Загрузить(Знач Канал=Неопределено, Знач Сообщать=Ложь) Экспорт
	Итог = 0;
	Если ПустаяСтрока(Канал) Или ТипЗнч(Канал) = Тип("СправочникСсылка.Каналы") Тогда
		Итог = Инфостарт.ЗагрузитьRSS(Канал);
	ИначеЕсли ТипЗнч(Канал) = Тип("Массив") Тогда
		Для Каждого тЭлемент Из Канал Цикл
			Если ТипЗнч(тЭлемент) = Тип("СправочникСсылка.Каналы") Тогда
				Итог = Итог + Инфостарт.ЗагрузитьRSS(тЭлемент);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Если Сообщать Тогда
		Сообщить("Загружено сообщений: " + Строка(Итог));
	КонецЕсли;
	Если Итог > 0 Тогда
		Оповестить("ЗагрузкаRSS");
	КонецЕсли;
КонецПроцедуры

Функция ХТМЛ(Знач Текст) Экспорт
	//Файлы = Новый Соответствие;
	//Файлы.Вставить(КаталогВременныхФайлов() + "kernel_main.css", "/bitrix/cache/css/ru/print/kernel_main/kernel_main.css");
	////Файлы.Вставить(КаталогВременныхФайлов() + "template_f40a4fbe6b365bdb07c4903ed54719690.css", "/bitrix/cache/css/ru/print/template_f40a4fbe6b365bdb07c4903ed5471969/template_f40a4fbe6b365bdb07c4903ed54719690.css");
	//Файлы.Вставить(КаталогВременныхФайлов() + "styles.css", "/bitrix/templates/print/styles.css");
	//Файлы.Вставить(КаталогВременныхФайлов() + "template_styles.css", "/bitrix/templates/print/template_styles.css");
	//Файлы.Вставить(КаталогВременныхФайлов() + "highlight1c.js", "/bitrix/templates/.default/js/highlight1c.js");
	////Файл = Новый Файл;
	//Для Каждого тЭлемент Из Файлы Цикл
	//	Текст = СтрЗаменить(Текст, тЭлемент.Значение, тЭлемент.Ключ);
	//КонецЦикла;
	Возврат Текст;
КонецФункции
