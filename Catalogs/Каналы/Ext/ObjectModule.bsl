﻿
Процедура ПередУдалением(Отказ)
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	Публикация.Ссылка КАК Ссылка
	                      |ИЗ
	                      |	Документ.Публикация КАК Публикация
	                      |ГДЕ
	                      |	Публикация.Канал = &Канал
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	Публикация.Дата УБЫВ");
	Запрос.УстановитьПараметр("Канал", Ссылка);
	Если Ссылка.ПометкаУдаления Тогда
		// каскадное удаление
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			Объект = Выборка.Ссылка.ПолучитьОбъект();
			Объект.Удалить();
		КонецЦикла;
		Запрос.Текст = "ВЫБРАТЬ
		               |	Авторы.Ссылка
		               |ИЗ
		               |	Справочник.Авторы КАК Авторы
		               |ГДЕ
		               |	Авторы.Владелец = &Канал";
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			Объект = Выборка.Ссылка.ПолучитьОбъект();
			Объект.Удалить();
		КонецЦикла;
	ИначеЕсли НЕ Запрос.Выполнить().Пустой() Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	ТЧ = Гиперссылки.ВыгрузитьКолонки();
	Для Каждого ТекСтрока Из Гиперссылки Цикл
		Если ТЧ.Найти(ТекСтрока.Гиперссылка, "Гиперссылка") = Неопределено Тогда
			ЗаполнитьЗначенияСвойств(ТЧ.Добавить(), ТекСтрока);
		КонецЕсли;
	КонецЦикла;
	Гиперссылки.Загрузить(ТЧ);
КонецПроцедуры
