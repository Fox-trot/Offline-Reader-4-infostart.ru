﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Неопределено;
	Если ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Авторы") Тогда
		ПараметрыФормы = Новый Структура("Отбор,Группировка", Новый Структура("Автор", ПараметрКоманды), Новый Структура);
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Каналы") Тогда
		ПараметрыФормы = Новый Структура("Отбор", Новый Структура("Канал", ПараметрКоманды));
	КонецЕсли;
	Если ТипЗнч(ПараметрыФормы) = Тип("Структура") Тогда
		ОткрытьФорму("Документ.Публикация.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	Иначе
		Сообщить("Что-то пошло не так :-(");
	КонецЕсли;
КонецПроцедуры
