﻿
Процедура ПередУдалением(Отказ)
	Выборка = ПубликацииПолучить(Ссылка);
	Если НЕ Выборка.Пустой() Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	Если ПометкаУдаления И Ссылка.ПометкаУдаления <> ПометкаУдаления Тогда
		Выборка = ПубликацииПолучить(Ссылка).Выбрать();
		Пока Выборка.Следующий() Цикл
			Если НЕ Выборка.Проведен Тогда
				Попытка
					Док = Выборка.Ссылка.ПолучитьОбъект();
					Док.УстановитьПометкуУдаления(Ложь);
					Док.Записать(РежимЗаписиДокумента.Проведение);
				Исключение
				КонецПопытки;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Функция ПубликацииПолучить(Автор)
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	Публикация.Ссылка КАК Ссылка,
	                      |	Публикация.Проведен КАК Проведен
	                      |ИЗ
	                      |	Документ.Публикация КАК Публикация
	                      |ГДЕ
	                      |	Публикация.Автор = &Автор");
	Запрос.УстановитьПараметр("Автор", Автор);
	Возврат Запрос.Выполнить();
КонецФункции
