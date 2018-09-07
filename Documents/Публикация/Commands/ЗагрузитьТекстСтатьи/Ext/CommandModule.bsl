﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//ОтключитьОбработчикОжидания("Обновка");
	Если ТипЗнч(ПараметрКоманды) = Тип("ДокументСсылка.Публикация") Тогда
		Если СкачатьПоСсылке(ПараметрКоманды) Тогда
			Оповестить(, ПараметрКоманды);
		КонецЕсли;
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("Массив") Тогда
		Для Каждого тЭлемент Из ПараметрКоманды Цикл
			ОбработкаКоманды(тЭлемент, ПараметрыВыполненияКоманды);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция СкачатьПоСсылке(Ссылка)
	Ответ = Ложь;
	Если (ПустаяСтрока(Ссылка.ТекстСтатьи) Или Ссылка.Проведен) И Ссылка.Канал = Справочники.Каналы.Инфостарт И НЕ ПустаяСтрока(Ссылка.Канал.Гиперссылка) Тогда
		Текст = Инфостарт.СкачатьПоСсылке(Ссылка.Канал.Гиперссылка + Ссылка.Номер + "/");
		Если НЕ ПустаяСтрока(Текст) Тогда
			Объект = Ссылка.ПолучитьОбъект();
			Объект.ТекстСтатьи	= Текст;
			Объект.Записать(РежимЗаписиДокумента.Проведение);
			Ответ = Истина;
		КонецЕсли;
	КонецЕсли;
	Возврат Ответ;
КонецФункции
