# Home Network (GNS 3)
Проект домашньої лабораторії для тестування та навчання у сфері мережевих технологій на GNS 3.
На даний момент використовується віртуальні машини Mikrotik CHR та Cisco L2 (i86bi-linux-l2-ipbasek9-15.1g.bin)
![HomeNetworkV1](https://github.com/user-attachments/assets/7b19aa1d-7ccf-4a55-8959-6522e47cb9a9)

## Реалізовані пункти
- Налаштування MSTP на комутаторах
- Налаштування динамачної маршрутизації - OSPF
- Доступ до мережі Інтернет клієнтам через DHCP
- Обмеження доступу до керування обладнання для клієнтів
- Доступ до керування обладнання через FreeRadius
- Налаштування моніторингу з використання Zabbix (агент та SNMP)

## В проекті
- Налаштування автентифікації через AD DS з використанням FreeRadius
- Налаштування файлового серверу на Windows Server 2019 для збереження бекапів конфігурації
- Написання скриптів для централізованого керування на Ansible

## IP Pool
1. Мережа клієнтів: 10.0.0.0/8. Vlan: 2-100
2. Мережа управління та серверів: 192.168.10.0/24. Vlan: 500
3. Мережа серверів: 172.16.0.0/24. Vlan: 700
4. OSPF: 172.16.8.0/26. Vlan: 800
5. Office 1 - Київ, позначення KIYV
6. Office 2 - Бориспіль, позначення BOR
7. Серверна - локація Київ, позначення IS
