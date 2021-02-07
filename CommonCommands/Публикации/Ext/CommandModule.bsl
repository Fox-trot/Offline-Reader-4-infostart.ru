﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура;
	Если ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Авторы") Тогда
		ПараметрыФормы.Вставить("Отбор",		Новый Структура("Автор", ПараметрКоманды));
		ПараметрыФормы.Вставить("Группировка",	Новый Структура);
		
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Каналы") Тогда
		ПараметрыФормы.Вставить("Отбор", Новый Структура("Канал", ПараметрКоманды));
	КонецЕсли;
	
	ОткрытьФорму("Документ.Публикация.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры
