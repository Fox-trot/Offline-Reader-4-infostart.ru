﻿
Процедура ПередНачаломРаботыСистемы() Экспорт
	Попытка
		КомОбъект = Новый COMОбъект("Msxml2.XMLHTTP");
	Исключение
		Сообщить(ОписаниеОшибки());
		Возврат;
	КонецПопытки;
		
	Если Регламент.ЗагружатьRSSПриСтарте() Тогда
		Загрузить();
	КонецЕсли;
КонецПроцедуры

Процедура ОткрытьПоСсылке(Гиперссылка) Экспорт
	Если ТипЗнч(Гиперссылка) =  Тип("Строка") Тогда
		Если НЕ ПустаяСтрока(Гиперссылка) Тогда
			ЗапуститьПриложение(Гиперссылка);
		КонецЕсли;
	ИначеЕсли ТипЗнч(Гиперссылка) = Тип("ДокументСсылка.Публикация") Тогда
		ОткрытьПоСсылке(Инфостарт.ГиперссылкаПолучить(Гиперссылка));
	ИначеЕсли ТипЗнч(Гиперссылка) = Тип("СправочникСсылка.Авторы") Тогда
		ОткрытьПоСсылке(Инфостарт.ГиперссылкаПолучить(Гиперссылка));
	КонецЕсли;
КонецПроцедуры

Процедура Загрузить(Канал=Неопределено, Знач Сообщать=Ложь) Экспорт
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
		#Если ТонкийКлиент Тогда
			Оповестить("ЗагрузкаRSS");
		#КонецЕсли
	КонецЕсли;
КонецПроцедуры
