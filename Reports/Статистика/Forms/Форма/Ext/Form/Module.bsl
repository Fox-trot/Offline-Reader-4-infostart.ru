﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	МАКСИМУМ(Публикация.Дата) КАК ДатаМАКСИМУМ
	                      |ИЗ
	                      |	Документ.Публикация КАК Публикация
	                      |ГДЕ
	                      |	Публикация.Канал = &Канал");
	Запрос.УстановитьПараметр("Канал",	Инфостарт.КаналДефолт());
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		//График.ОбластьЛегенды.Прокрутка	= Истина;
	Иначе
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ГрафикОбновить()
	График.Очистить();
	График.ОбластьЗаголовка.Текст = "Количество публикаций";
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Канал",	Инфостарт.КаналДефолт());
	Если ТипГрафика = "ТопАвторов" Тогда
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 10
		               |	Публикация.Автор КАК Автор,
		               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Публикация.Ссылка) КАК Количество
		               |ИЗ
		               |	Документ.Публикация КАК Публикация
		               |ГДЕ
		               |	Публикация.Канал = &Канал
		               |	И Публикация.Дата >= &Дата
		               |	И Публикация.Автор.ПометкаУдаления = ЛОЖЬ
		               |
		               |СГРУППИРОВАТЬ ПО
		               |	Публикация.Автор
		               |
		               |ИМЕЮЩИЕ
		               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Публикация.Ссылка) > 1
		               |
		               |УПОРЯДОЧИТЬ ПО
		               |	Количество УБЫВ,
		               |	Автор
		               |АВТОУПОРЯДОЧИВАНИЕ";
		Запрос.УстановитьПараметр("Дата",	НачалоМесяца(ДобавитьМесяц(ТекущаяДата(), -3)));
		Выборка = Запрос.Выполнить().Выбрать();
		График.ТипДиаграммы			= ТипДиаграммы.ГистограммаОбъемная;
		График.ВидПодписей			= ВидПодписейКДиаграмме.СерияЗначение;
		График.ОтображатьЛегенду	= Истина;
		Точка = График.УстановитьТочку("");
		Пока Выборка.Следующий() Цикл
			Серия = График.УстановитьСерию(Выборка.Автор);
			График.УстановитьЗначение(Точка, Серия, Выборка.Количество, Выборка.Автор);
		КонецЦикла;
		
	ИначеЕсли ТипГрафика = "Прочитанные" Тогда
		Запрос.Текст = "ВЫБРАТЬ
		               |	Публикация.Проведен КАК Проведен,
		               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Публикация.Ссылка) КАК Количество
		               |ИЗ
		               |	Документ.Публикация КАК Публикация
		               |ГДЕ
		               |	Публикация.Канал = &Канал
		               |
		               |СГРУППИРОВАТЬ ПО
		               |	Публикация.Проведен
		               |
		               |УПОРЯДОЧИТЬ ПО
		               |	Проведен";
		Выборка = Запрос.Выполнить().Выбрать();
		График.ТипДиаграммы			= ТипДиаграммы.КруговаяОбъемная;
		График.ВидПодписей			= ВидПодписейКДиаграмме.СерияЗначение;
		График.ОтображатьЛегенду	= Истина;
		Точка = График.УстановитьТочку("");
		РасшифровакаПотребуется = Ложь;
		Пока Выборка.Следующий() Цикл
			Серия = График.УстановитьСерию(?(Выборка.Проведен, "Прочитано", "Не прочитано"));
			Если Выборка.Проведен Тогда
				Серия.Цвет	= Новый Цвет(90, 140, 255);	// синий
			Иначе
				РасшифровакаПотребуется = Истина;
			КонецЕсли;
			Если РасшифровакаПотребуется Тогда
				График.УстановитьЗначение(Точка, Серия, Выборка.Количество, Ложь);
			Иначе
				График.УстановитьЗначение(Точка, Серия, Выборка.Количество);
			КонецЕсли;
		КонецЦикла;
		
	ИначеЕсли ТипГрафика = "Хронология" Тогда
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 7
		               |	НАЧАЛОПЕРИОДА(Публикация.Дата, МЕСЯЦ) КАК Период,
		               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Публикация.Ссылка) КАК Количество
		               |ПОМЕСТИТЬ ВТ
		               |ИЗ
		               |	Документ.Публикация КАК Публикация
		               |ГДЕ
		               |	Публикация.Канал = &Канал
		               |
		               |СГРУППИРОВАТЬ ПО
		               |	НАЧАЛОПЕРИОДА(Публикация.Дата, МЕСЯЦ)
		               |
		               |УПОРЯДОЧИТЬ ПО
		               |	Период УБЫВ
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ
		               |	ВТ.Период КАК Период,
		               |	ВТ.Количество КАК Количество
		               |ИЗ
		               |	ВТ КАК ВТ
		               |
		               |УПОРЯДОЧИТЬ ПО
		               |	Период";
		Выборка = Запрос.Выполнить().Выбрать();
		График.ТипДиаграммы			= ТипДиаграммы.ГистограммаОбъемная;
		График.ВидПодписей			= ВидПодписейКДиаграмме.Значение;
		График.ОтображатьЛегенду	= Ложь;
		Серия = График.УстановитьСерию("");
		Пустой = Дата(1, 1, 1);
		Пока Выборка.Следующий() Цикл
			Если Год(Пустой) < 2 Тогда
				Пустой = Выборка.Период;
			ИначеЕсли Пустой < Выборка.Период Тогда
				Пустой = ДобавитьМесяц(Пустой, 1);
				Пока Пустой < Выборка.Период Цикл
					Точка = График.УстановитьТочку(Формат(Пустой, "ДФ=MM.yyyy"));
					
					Пустой = ДобавитьМесяц(Пустой, 1);
				КонецЦикла;
			КонецЕсли;
			Точка = График.УстановитьТочку(Формат(Выборка.Период, "ДФ=MM.yyyy"));
			График.УстановитьЗначение(Точка, Серия, Выборка.Количество, , Точка.Значение);
		КонецЦикла;
	Иначе
		Запрос.Текст = "ВЫБРАТЬ
		               |	НАЧАЛОПЕРИОДА(Публикация.Дата, ГОД) КАК Период,
		               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Публикация.Ссылка) КАК Количество
		               |ИЗ
		               |	Документ.Публикация КАК Публикация
		               |ГДЕ
		               |	Публикация.Канал = &Канал
		               |
		               |СГРУППИРОВАТЬ ПО
		               |	НАЧАЛОПЕРИОДА(Публикация.Дата, ГОД)
		               |
		               |УПОРЯДОЧИТЬ ПО
		               |	Период";
		Если ТипГрафика = "Авторы" Тогда
			График.ОбластьЗаголовка.Текст = "Количество авторов";
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "Ссылка", "Автор");
		КонецЕсли;
		Выборка = Запрос.Выполнить().Выбрать();
		График.ТипДиаграммы			= ТипДиаграммы.ГистограммаОбъемная;
		График.ВидПодписей			= ВидПодписейКДиаграмме.Значение;
		График.ОтображатьЛегенду	= Ложь;
		Серия = График.УстановитьСерию("");
		Пока Выборка.Следующий() Цикл
			Точка = График.УстановитьТочку(Формат(Выборка.Период, "ДФ=yyyy"));
			График.УстановитьЗначение(Точка, Серия, Выборка.Количество);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//График.ТипДиаграммы			= ТипДиаграммы.ГистограммаОбъемная;
	//График.ВидПодписей			= ВидПодписейКДиаграмме.Значение;
	Если ПустаяСтрока(ТипГрафика) Тогда
		ТипГрафика = Элементы.ТипГрафика.СписокВыбора[0].Значение;
		
		Сообщить("Добро пожаловать!");
	КонецЕсли;
	ГрафикОбновить();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	#Если ТонкийКлиент Тогда
		Если ИмяСобытия = "ПубликацияПрочитано" И ТипГрафика = "Прочитанные" Тогда
			ГрафикОбновить();
		ИначеЕсли ИмяСобытия = "ЗагрузкаRSS" Тогда
			ГрафикОбновить();
		КонецЕсли;
	#КонецЕсли
КонецПроцедуры

&НаКлиенте
Процедура ТипГрафикаПриИзменении(Элемент)
	Модифицированность	= Ложь;
	ГрафикОбновить();
КонецПроцедуры

&НаКлиенте
Процедура ТипГрафикаОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ЛогоНажатие(Элемент)
	Элемент.Доступность	= Ложь;
	
	НаКлиенте.ОткрытьПоСсылке(Инфостарт.АдресИнформацииОКонфигурации());
КонецПроцедуры

&НаКлиенте
Процедура ГрафикОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	Если ТипЗнч(Расшифровка) = Тип("Булево") Тогда
		СтандартнаяОбработка = Ложь;
		
		тФорма = ПолучитьФорму("Документ.Публикация.ФормаСписка", Новый Структура("КлючНазначенияИспользования,Отбор", Строка(Новый УникальныйИдентификатор), Новый Структура("Проведен", Ложь)));
		тФорма.Открыть();
	КонецЕсли;
КонецПроцедуры
