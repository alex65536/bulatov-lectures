# Конспект по математическому анализу в LaTeX (по лекциям Булатова)

[![Build Status](https://travis-ci.com/alex65536/bulatov-lectures.svg?token=jpeNqaJZZxa4oU5dqJk8&branch=master)](https://travis-ci.com/alex65536/bulatov-lectures)

В этом репозитории будет вестись работа над конспектом.

## Шаблон

Сейчас матана здесь нет (почти), но зато есть шаблон.
Там есть примеры использования, создания теорем.
По нему можно понять, как писать.

## Code-style

Не думаю, что нужен строгий code-style.

Однако, одно правило уже есть.
Не допускайте длинный строк; так сложнее смотреть изменения.
Как максимальное число символов в строке можно взять число 80.
Смотрите тестовую главу в шаблоне.

Может, что то еще потом добавится.

## Коммиты

Для изменений стоит создавать свою ветку, а потом сливать их в `master`.
В одной ветке лучше работать над одним изменением
(например, добавление новой главы)
Мелкие исправления можно и сразу в `master` коммитить.

## Continuous Integration

В этом репозитории настроен Travis CI, который собирает конспект на сервере.
Следите за статусом сборки
(виден в списке коммитов, на который можно попасть,
если щелкнуть на число коммитов в репозитории).

## План работы

После каждой лекции выбирается один человек и добавляет очередную часть.
Предварительный план &mdash; добавить python-скрипт, который будет выбирать
на основе даты и последней строки из конспекта. Первую лекцию добавлю я
(@alex65536), пока не все умею работать с `git`-ом
(лучше научиться быстрее!)

## Ресурсы по LaTeX

* https://en.wikibooks.org/wiki/LaTeX/

## Этот README

Это описание можно менять, если с чем-то не согласны (лучше после обсуждения).
Дополнения и решение общих проблем также можно писать сюда.

## В случае каких-либо проблем (с компиляцией, с добавлением файлов)

Можно попробовать разобраться, если не получилось,
писать мне (@alex65536) или в чат.
