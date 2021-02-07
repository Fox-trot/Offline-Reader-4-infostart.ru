﻿
&НаСервере
Функция ЭтоТакиДокумент(Знач Ссылка)
	Возврат ТипЗнч(Ссылка) = Тип("ДокументСсылка.Публикация")
		Или (ТипЗнч(Ссылка) = Тип("ДанныеФормыСтруктура") И Ссылка.Свойство("Ссылка"));
КонецФункции

&НаСервере
Функция ТекстПолучить(Знач Ссылка)
	Ответ = ?(ПустаяСтрока(Ссылка.ТекстСтатьи), Ссылка.Описание, Ссылка.ТекстСтатьи);
	Возврат Ответ;
КонецФункции

&НаСервере
Функция ОтметитьКакПрочтенное(Знач Ссылка)
	Ответ = Ложь;
	Если НЕ ПроведенТаки(Ссылка) Тогда
		Попытка
			Док = Ссылка.ПолучитьОбъект();
			Док.Записать(РежимЗаписиДокумента.Проведение);
			Ответ = Истина;
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	Возврат Ответ;
КонецФункции

&НаСервере
Функция ПроведенТаки(Знач Ссылка)
	Возврат ?(ЭтоТакиДокумент(Ссылка), Ссылка.Проведен, Истина);
КонецФункции

&НаСервере
Процедура ТекстУстановить(Знач Ссылка)
	Содержание.Удалить();
	Если ЭтоТакиДокумент(Ссылка) Тогда
		Содержание.УстановитьHTML(Инфостарт.Причесать(ТекстПолучить(Ссылка)), Новый Структура);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СписокПриАктивизацииСтроки();
КонецПроцедуры

&НаКлиенте
Процедура СписокПриИзменении(Элемент)
	Оповестить("ПубликацияПрочитано");
КонецПроцедуры

&НаКлиенте
Процедура Обновка()
	Если ОтметитьКакПрочтенное(Элементы.Список.ТекущаяСтрока) Тогда
		//Оповестить("ПубликацияПрочитано");
		
		Элементы.Список.Обновить();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ЭтаФорма.ОтключитьОбработчикОжидания("Обновка");
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент=Неопределено)
	ЭтаФорма.ОтключитьОбработчикОжидания("Обновка");

	Если Элементы.Содержание.Видимость Тогда
		Если Элементы.Список.ТекущиеДанные = Неопределено Тогда
			Если НЕ ПустаяСтрока(Содержание.ПолучитьТекст()) Тогда
				Содержание.Удалить();
			КонецЕсли;
			Возврат;
		ИначеЕсли НЕ Элементы.Список.ТекущиеДанные.Свойство("Описание") Тогда
			Содержание.Удалить();
		ИначеЕсли Найти(Содержание.ПолучитьТекст(), Лев(Элементы.Список.ТекущиеДанные.Описание, 17)) = 0 Тогда
			ТекстУстановить(Элементы.Список.ТекущиеДанные);
		КонецЕсли;
		ЭтаФорма.ОбновитьОтображениеДанных(Элементы.Содержание);
		
		Если НЕ ПроведенТаки(Элементы.Список.ТекущиеДанные) Тогда
			ЭтаФорма.ПодключитьОбработчикОжидания("Обновка", Регламент.ОтметитьКакПрочтенноеЧерезСек(), Истина);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	СписокПриАктивизацииСтроки();
КонецПроцедуры
