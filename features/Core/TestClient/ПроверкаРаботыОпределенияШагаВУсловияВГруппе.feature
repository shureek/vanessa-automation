# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb
@IgnoreOn836
@IgnoreOn837
@IgnoreOn838



Функционал: Проверка работы определения шага в условии в группе


Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	
	
Сценарий: Проверка работы определения шага в условии в группе
	Когда Я открываю VanessaBehavior в режиме TestClient со стандартной библиотекой
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ДляПроверкаРаботыОпределенияШагаВУсловииВГруппе"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Behavior TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Behavior TestClient
	
	Тогда элемент формы с именем "Статистика" стал равен '1/4/21, 21/0/0'
	
