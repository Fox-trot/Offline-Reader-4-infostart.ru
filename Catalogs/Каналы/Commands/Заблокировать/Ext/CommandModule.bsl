﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Если ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.Каналы") Тогда
		ФлагиУстановить(ПараметрКоманды);
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("Массив") Тогда
		Для Каждого тЭлемент Из ПараметрКоманды Цикл
			ОбработкаКоманды(тЭлемент, ПараметрыВыполненияКоманды);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ФлагиУстановить(ПараметрКоманды)
	Регламент.ФлагиУстановить(ПараметрКоманды, Истина);
КонецПроцедуры
