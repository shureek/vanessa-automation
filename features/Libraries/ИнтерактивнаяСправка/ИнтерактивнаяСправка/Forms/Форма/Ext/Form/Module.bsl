﻿&НаКлиенте
Перем ФормаОбработкиVA;

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Automation
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Automation.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСпрашиваюИмяУченикаЕслиОноНеЗадано()","ЯСпрашиваюИмяУченикаЕслиОноНеЗадано","И я спрашиваю имя ученика если оно не задано","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯОткрываюVanessaAutomationВРежимеОбучения()","ЯОткрываюVanessaAutomationВРежимеОбучения","И я открываю Vanessa Automation в режиме обучения","","");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Функция выполняется перед началом каждого сценария
Функция ПередНачаломСценария() Экспорт
	
КонецФункции

&НаКлиенте
// Функция выполняется перед окончанием каждого сценария
Функция ПередОкончаниемСценария() Экспорт
	
КонецФункции



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я спрашиваю имя ученика если оно не задано
//@ЯСпрашиваюИмяУченикаЕслиОноНеЗадано()
Процедура ЯСпрашиваюИмяУченикаЕслиОноНеЗадано() Экспорт
	
	Если КонтекстСохраняемый.Свойство("ИмяУченика") Тогда
		Если ЗначениеЗаполнено(КонтекстСохраняемый.ИмяУченика) Тогда
			Возврат;
		КонецЕсли;	 
	КонецЕсли;	 
	
	Ванесса.ВоспроизвестиФразуАсинхронно("Чтобы продолжить укажите ваше имя, пожалуйста.");
	
	Ванесса.ЗапретитьВыполнениеШагов();
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВводаИмениУченика", ЭтаФорма);
	ПоказатьВводСтроки(ОписаниеОповещения, , "Введите ваше имя");
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаИмениУченика(ИмяУченика, ДопПараметры) Экспорт
	
	Если ЗначениеЗаполнено(ИмяУченика) Тогда
		КонтекстСохраняемый.Вставить("ИмяУченика", ИмяУченика);
	Иначе	
		КонтекстСохраняемый.Вставить("ИмяУченика", "Ученик");
	КонецЕсли;	 
	
	Ванесса.ПродолжитьВыполнениеШагов();
	
КонецПроцедуры

&НаКлиенте
//И я открываю Vanessa Automation в режиме обучения
//@ЯОткрываюVanessaAutomationВРежимеОбучения()
Функция ЯОткрываюVanessaAutomationВРежимеОбучения() Экспорт
	
	Ванесса.ЗапретитьВыполнениеШагов();
	
	Если Ванесса.Объект.ВерсияПоставки = "single" Тогда
		ПутьКVA = Ванесса.ДополнитьСлешВПуть(Ванесса.Объект.КаталогИнструментов) + "vanessa-automation-single.epf";
	Иначе	
		ПутьКVA = Ванесса.ДополнитьСлешВПуть(Ванесса.Объект.КаталогИнструментов) + "vanessa-automation.epf";
	КонецЕсли;
	
	ПомещаемыйФайл = Новый ОписаниеПередаваемогоФайла(ПутьКVA);
	ПомещаемыеФайлы = Новый Массив;
	ПомещаемыеФайлы.Добавить(ПомещаемыйФайл);
	
	ПараметрыЗавершения = Новый Структура;
	ПараметрыЗавершения.Вставить("ПутьКVA", ПутьКVA);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеПомещенияФайлаVA", ЭтаФорма, ПараметрыЗавершения);
	НачатьПомещениеФайлов(ОписаниеОповещения, ПомещаемыеФайлы,, Ложь, ЭтаФорма.УникальныйИдентификатор);
	
КонецФункции

&НаКлиенте
Процедура ПослеПомещенияФайлаVA(Знач ПомещенныеФайлы, Знач ДополнительныеПараметры) Экспорт
	
	
	Для Каждого ПомещенныйФайл Из ПомещенныеФайлы Цикл
		ДополнительныеПараметрыПодключения = Новый Структура;
		ДополнительныеПараметрыПодключения.Вставить("АдресХранилища",ПомещенныйФайл.Хранение);
		ДополнительныеПараметрыПодключения.Вставить("ИмяФайла",ДополнительныеПараметры.ПутьКVA);
		ИмяОбработки = ПодключитьВнешнююОбработкуСервер(ПомещенныйФайл.Хранение,Ванесса.ЕстьЗащитаОтОпасныхДействий,ДополнительныеПараметрыПодключения);
		
		ПодключениеОбработкиПродолжение(ИмяОбработки);
		Возврат;
	КонецЦикла;	 
	
	Ванесса.ПродолжитьВыполнениеШагов();
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПодключитьВнешнююОбработкуСервер(Знач АдресХранилища,ИспользуетсяЗащитаОтОпасныхДействий,ДополнительныеПараметры = Неопределено) Экспорт
	ИмяОбработки = Неопределено;
	Если ИспользуетсяЗащитаОтОпасныхДействий Тогда
		ОписаниеЗащитыОтОпасныхДействий = Вычислить("Новый ОписаниеЗащитыОтОпасныхДействий");
		ОписаниеЗащитыОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях = Ложь;
		
		Обработка = ПолучитьОбработкуИзФайлаЧерезМетодСоздать(ДополнительныеПараметры,ИмяОбработки);
		Если Обработка = Неопределено Тогда
			Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда
				Если ДополнительныеПараметры.Свойство("АдресХранилища") Тогда
					ИмяОбработки = ВнешниеОбработки.Подключить(ДополнительныеПараметры.АдресХранилища, , Ложь, ОписаниеЗащитыОтОпасныхДействий);
				Иначе	
					ИмяОбработки = ВнешниеОбработки.Подключить(АдресХранилища, , Ложь, ОписаниеЗащитыОтОпасныхДействий);
				КонецЕсли;	 
			КонецЕсли;	 
		КонецЕсли;	 
		ПроверитьОбработкуНаВозможностьПодключения(ИмяОбработки);
		
		Возврат ИмяОбработки;
	Иначе	
		Обработка = ПолучитьОбработкуИзФайлаЧерезМетодСоздать(ДополнительныеПараметры,ИмяОбработки);
		Если Обработка = Неопределено Тогда
			Если ДополнительныеПараметры.Свойство("АдресХранилища") Тогда
				ИмяОбработки = ВнешниеОбработки.Подключить(ДополнительныеПараметры.АдресХранилища, , Ложь); 
			Иначе	
				ИмяОбработки = ВнешниеОбработки.Подключить(АдресХранилища, , Ложь); 
			КонецЕсли;	 
			ПроверитьОбработкуНаВозможностьПодключения(ИмяОбработки);
		КонецЕсли;	 
		Возврат ИмяОбработки;
	КонецЕсли;	 
КонецФункции 

&НаСервереБезКонтекста
Функция ПолучитьОбработкуИзФайлаЧерезМетодСоздать(ДополнительныеПараметры,ИмяОбработки)
	Обработка = Неопределено;
	Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда
		Если ДополнительныеПараметры.Свойство("ИмяФайла") Тогда
			Файл = Новый Файл(ДополнительныеПараметры.ИмяФайла);
			Если Файл.Существует() Тогда
				Обработка = ВнешниеОбработки.Создать(ДополнительныеПараметры.ИмяФайла, Ложь);
				ИмяОбработки = Обработка.Метаданные().Имя;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЕсли;	 
	
	Возврат Обработка; 
КонецФункции	 

&НаСервереБезКонтекста
Процедура ПроверитьОбработкуНаВозможностьПодключения(ИмяОбработки)
	Обработка = ВнешниеОбработки.Создать(ИмяОбработки,Ложь);
	Попытка
		ПараметрыОбработки = Обработка.ПараметрыОбработки();
	Исключение
		// значит параметры не указаны
		Возврат;
	КонецПопытки;
	
	IgnoreOn82 = Ложь;
	ПараметрыОбработки.Свойство("IgnoreOn82",IgnoreOn82);
	
	Если IgnoreOn82 Тогда
		СистемнаяИнформация = Новый СистемнаяИнформация;
		Если Лев(СистемнаяИнформация.ВерсияПриложения,4) = "8.2." Тогда
			ИмяОбработки = Неопределено;
		Иначе
			Попытка
				ТекущийРежимСовместимости = Вычислить("Метаданные.РежимСовместимости");
				РежимыСовместимости = Метаданные.СвойстваОбъектов.РежимСовместимости;
			Исключение
				Возврат;
			КонецПопытки;
			
			Если ТекущийРежимСовместимости = РежимыСовместимости.Версия8_1 Тогда
				ИмяОбработки = Неопределено;
			ИначеЕсли ТекущийРежимСовместимости = РежимыСовместимости.Версия8_2_13 Тогда
				ИмяОбработки = Неопределено;
			ИначеЕсли ТекущийРежимСовместимости = РежимыСовместимости.Версия8_2_16 Тогда
				ИмяОбработки = Неопределено;
			КонецЕсли;	 

		КонецЕсли;	 
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
Процедура ОжиданиеОткрытияФормыVA()
	
	Если ФормаОбработкиVA.СработалиВсеАсинхронныеОбработчикиФормыПриОткрытии = Истина Тогда
		Если Найти(ФормаОбработкиVA.Заголовок, "Режим обучения") = 0 Тогда
			ФормаОбработкиVA.Заголовок = ФормаОбработкиVA.Заголовок + " Режим обучения";
		КонецЕсли;
		ФормаОбработкиVA.ЗапрашиватьПодтверждениеПриЗакрытии = "Нет";
		Оповестить("ОткрытаФормаVAВРежимеОбучения", ФормаОбработкиVA);
		Ванесса.ПродолжитьВыполнениеШагов();
		Возврат;
	КонецЕсли;	 
	
	ПодключитьОбработчикОжидания("ОжиданиеОткрытияФормыVA",1, Истина);
	
КонецПроцедуры 

&НаКлиенте
Процедура ПодключениеОбработкиПродолжение(ИмяОбработки)
	ФормаОбработкиVA = ПолучитьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма.УправляемаяФорма",,,"Обучение");
	ФормаОбработкиVA.Объект.ЗагрузкаФичПриОткрытии = "Не загружать";
	ФормаОбработкиVA.Объект.ДополнительныеПараметры = Новый Структура;
	ФормаОбработкиVA.Объект.ДополнительныеПараметры.Вставить("ЗагрузитьНастройкуКаталогФич", Ложь);
	ФормаОбработкиVA.Объект.ДополнительныеПараметры.Вставить("ВЭтомСеансеИдётОбучение", Истина);
	ФормаОбработкиVA.Открыть();
	
	КонтекстСохраняемый.Вставить("VAОткрытаяДляОбучения", ФормаОбработкиVA);
	
	ПодключитьОбработчикОжидания("ОжиданиеОткрытияФормыVA",1, Истина);
	
КонецПроцедуры 
